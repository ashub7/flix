import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/logger_provider.dart';
import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flix/ui/features/favorite/bloc/favorite_bloc.dart';
import 'package:flix/ui/features/favorite/widgets/fav_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../../config/rout_names.dart';
import '../../models/event_fav_change.dart';
import '../../models/movie_list.dart';

class FavoriteScreen extends StatefulWidget {
  final bool reload;
  const FavoriteScreen({super.key, required this.reload});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie>? movieList;

  @override
  void activate() {
    logger.e("activate");
    super.activate();
  }

  @override
  void didChangeDependencies() {
    logger.e("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FavoriteScreen oldWidget) {
    logger.e("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    logger.e("build");
    return SafeArea(
        child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: false,
            elevation: 8,
            systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.deepPurple),
            snap: true,
            title: Text(
              context.loc.favorites,
            ),
            automaticallyImplyLeading: false,
            floating: true,
          )
        ];
      },
      body: _body(context),
    ));
  }

  _body(BuildContext context) {
    return BlocConsumer(
      bloc: BlocProvider.of<FavoriteBloc>(context)..add(const LoadFavorites()),
      builder: (context, state) {
        return BlocBuilder<FavoriteBloc, FavoriteState>(
            bloc: BlocProvider.of<FavoriteBloc>(context),
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                if (movieList != null) {
                  if (movieList!.isNotEmpty) {
                    return FavoriteList(
                      movieList: movieList!,
                      onFavIconCLicked: (movie) {
                        BlocProvider.of<FavoriteBloc>(context)
                            .add(ChangeFavoriteEvent(movie));
                      },
                      onItemClicked: (movie) {
                        context.push(RoutesName.detail.path,
                            extra: {"id": movie.id});
                      },
                      onRefresh: () {
                        BlocProvider.of<FavoriteBloc>(context)
                            .add(const LoadFavorites());
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        context.loc.no_favorites,
                        style: context.bodyMedium,
                      ),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              }
            });
      },
      listener: (context, state) {
        if (state is FavoritesLoaded) {
          movieList = state.movies;
        } else if (state is FavoriteModified) {
          if (state.isAdded) {
            movieList?.add(state.movie);
          } else {
            movieList?.remove(state.movie);
            context.showSnackBarWithAction(
              "Removed",
              "Undo",
              () {
                BlocProvider.of<FavoriteBloc>(context)
                    .add(ChangeFavoriteEvent(state.movie));
              },
            );
          }
          eventBus.fire(EventFavoriteChange(
              movie: state.movie, isAdded: state.isAdded, from: "fav_page"));
        }
      },
    );
  }
}
