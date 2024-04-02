import 'package:flix/ui/features/detail/bloc/detail_bloc.dart';
import 'package:flix/ui/features/detail/detail_screen.dart';
import 'package:flix/ui/features/favorite/bloc/favorite_bloc.dart';
import 'package:flix/ui/models/cast.dart';
import 'package:flix/ui/models/movie_detail.dart';
import 'package:flix/ui/models/movie_photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/json_reader.dart';
import '../mock_blocs.dart';
import '../ui_test_helper.dart';

late Widget detailScreenWidget;
late DetailBloc _detailBloc;
late FavoriteBloc _favoriteBloc;
late MovieDetail detail;
late List<Cast> castList;
late List<MoviePhoto> backdrops;
late List<MoviePhoto> posters;

void main() {
  setUp(() async {
    detail = dummyMovieDetailResponse().toEntity().toUiModel();
    castList =
        dummyCastResponse().cast!.map((e) => e.toEntity().toUiModel()).toList();
    backdrops = [];
    posters = [];
    _detailBloc = MockDetailBloc();

    _favoriteBloc = MockFavoriteBloc();
    detailScreenWidget = makeTestableWidget(
        child: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => _detailBloc,
      ),
      BlocProvider(
        create: (context) => _favoriteBloc,
      )
    ], child: const DetailScreen(movieId: 272)));
  });

  testWidgets("Detail Screen test Initial", (widgetTester) async {
    when(() => _detailBloc.state).thenReturn(DetailInitial());
    await widgetTester.pumpWidget(detailScreenWidget);
    await widgetTester.pump();
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets("Detail Screen test Loading", (widgetTester) async {
    when(() => _detailBloc.state).thenReturn(DetailLoading());
    await widgetTester.pumpWidget(detailScreenWidget);
    await widgetTester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });


  testWidgets("Detail Screen test Loaded", (widgetTester) async {
    when(() => _detailBloc.state).thenReturn(DetailLoaded(
        backdrops: backdrops,
        castList: castList,
        detail: detail,
        posters: posters));
    await widgetTester.pumpWidget(detailScreenWidget);
    await widgetTester.pump();
    expect(find.byType(SingleChildScrollView), findsAtLeastNWidgets(1));
  });

  testWidgets("Detail Screen test Error", (widgetTester) async {
    when(() => _detailBloc.state)
        .thenReturn(const DetailLoadError("Server Error"));
    await widgetTester.pumpWidget(detailScreenWidget);
    await widgetTester.pump();
    final errorWidgetFinder = find.byKey(const Key("api_error_widget"));
    expect(errorWidgetFinder, findsOneWidget);
  });
}
