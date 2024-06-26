import 'package:bloc_test/bloc_test.dart';
import 'package:flix/data/local/model/fav_movie_model.dart';
import 'package:flix/ui/features/favorite/bloc/favorite_bloc.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

main() {
  late MockManageFavoritesUseCase manageFavoritesUseCase;
  late FavoriteBloc favoriteBloc;
  final favList = dummyFavoritesList();
  late List<Movie> favUIList;
  late Movie testMovie = getDummyMovie();
  late FavMovieModel testFavMovieModel;

  setUpAll((){
    manageFavoritesUseCase = MockManageFavoritesUseCase();
    favUIList = favList.map((e) => e.toUiModel()).toList();
    testFavMovieModel = FavMovieModel.fromUiModel(testMovie);
  });

  setUp(() {
    testMovie.isFavorite = false;
    favoriteBloc = FavoriteBloc(manageFavoritesUseCase);
  });

  test("Initial state should be empty", () async {
    expect(favoriteBloc.state, FavoriteInitial());
  });

  blocTest<FavoriteBloc, FavoriteState>(
    "Load all favorites test",
    build: () {
      when(manageFavoritesUseCase.getAllFavorites()).thenAnswer(
        (realInvocation) async {
          return favList;
        },
      );
      return favoriteBloc;
    },
    act: (bloc) => bloc.add(const LoadFavorites()),
    wait: const Duration(milliseconds: 3000),
    expect: () => [FavoritesLoading(), FavoritesLoaded(favUIList)],
  );

  blocTest<FavoriteBloc, FavoriteState>(
    "Change favorites status test by removing from favorite",
    build: () {
      testMovie.isFavorite = true;
      when(manageFavoritesUseCase.removeFromFavorites(testMovie.id)).thenAnswer(
        (realInvocation) async {
          return;
        },
      );
      return favoriteBloc;
    },
    act: (bloc) => bloc.add(ChangeFavoriteEvent(testMovie)),
    wait: const Duration(milliseconds: 3000),
    expect: () => [FavoriteModified(testMovie, false)],
  );

  blocTest<FavoriteBloc, FavoriteState>(
    "Change favorites status test by adding to favorite",
    build: () {
      when(manageFavoritesUseCase.addToFavorites(testFavMovieModel)).thenAnswer(
            (realInvocation) async {
          return 1;
        },
      );
      return favoriteBloc;
    },
    act: (bloc) => bloc.add(ChangeFavoriteEvent(testMovie)),
    wait: const Duration(milliseconds: 3000),
    expect: () => [FavoriteModified(testMovie, true)],
  );
}
