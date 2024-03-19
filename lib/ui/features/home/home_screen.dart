import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/ui/config/rout_names.dart';
import 'package:flix/ui/features/favorite/bloc/favorite_bloc.dart';
import 'package:flix/ui/features/home/bloc/home_bloc.dart';
import 'package:flix/ui/features/home/widgets/home_slider_view.dart';
import 'package:flix/ui/features/home/widgets/movies_grid.dart';
import 'package:flix/ui/widgets/api_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../models/movie_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool hasNextPage = true;
  int currentPage = 1;
  final List<Movie> latestMovies = [];
  final List<Movie> topRated = [];
  @override
  initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadMoviesEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (BlocProvider.of<HomeBloc>(context).state is! HomePageLoading &&
            hasNextPage) {
          BlocProvider.of<HomeBloc>(context)
              .add(LoadMoreLatestEvent(currentPage));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [_body(context)],
    );
  }

  _body(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            bloc: BlocProvider.of<HomeBloc>(context),
            listener: _onHomeChanged,
          ),
          BlocListener<FavoriteBloc, FavoriteState>(
            bloc: BlocProvider.of<FavoriteBloc>(context),
            listener: _onFavoriteChanged,
          ),
        ],
        child: BlocBuilder(
          bloc: BlocProvider.of<HomeBloc>(context),
          builder: (context, state) {
            if (state is HomeLoading) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            } else if (state is HomeLoadError && state.page == 1) {
              return SliverFillRemaining(
                  hasScrollBody: false,
                  child: ApiErrorWidget(
                    errorText: state.message,
                    onRetry: () {
                      BlocProvider.of<HomeBloc>(context).add(LoadMoviesEvent());
                    },
                  ));
            } else {
              return MultiSliver(children: [
                SliverToBoxAdapter(
                  child: SizedBox(
                      height: context.screenHeight / 2,
                      child: HomeSliderView(
                        movieList: topRated,
                        onItemClicked: (movie) {
                          context.push(RoutesName.detail.path,
                              extra: {"id": movie.id});
                        },
                      )),
                ),
                MoviesGrid(
                  movieList: latestMovies,
                  onFavIconCLicked: (movie) {
                    BlocProvider.of<FavoriteBloc>(context)
                        .add(ChangeFavoriteEvent(movie));
                  },
                  onItemClicked: (movie) {
                    context
                        .push(RoutesName.detail.path, extra: {"id": movie.id});
                  },
                ),
                _pagingIndicator()
              ]);
            }
          },
        ));
  }

  Future<void> _onHomeChanged(BuildContext context, HomeState state) async {
    if (state is HomeLoadError && state.page > 1) {
      context.showErrorSnackBar(state.message);
    } else if (state is HomeLoadSuccess) {
      currentPage++;
      if (state.topRated != null) {
        topRated.addAll(state.topRated!);
      }
      latestMovies.addAll(state.latest!.results);
    }
  }

  Future<void> _onFavoriteChanged(
      BuildContext context, FavoriteState state) async {
    if (state is FavoriteModified) {
      Movie? movie = latestMovies.firstWhereOrNull((element) => element.id == state.movie.id);
      if (movie != null) {
        movie.isFavorite = state.isAdded;
        BlocProvider.of<HomeBloc>(context).add(NotifyHomeListEvent());
      }
    }
  }

  _pagingIndicator() {
    return SliverToBoxAdapter(
      child: BlocBuilder(
        buildWhen: (previous, current) =>
            current is HomePageLoading ||
            current is HomeLoadSuccess ||
            current is HomeLoadError,
        bloc: BlocProvider.of<HomeBloc>(context),
        builder: (context, state) {
          if (state is HomePageLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
