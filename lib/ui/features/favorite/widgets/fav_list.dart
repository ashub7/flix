import 'package:flix/ui/features/home/widgets/movie_grid_tile.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:flutter/material.dart';

import 'fav_list_tile.dart';

class FavoriteList extends StatelessWidget {
  final List<Movie> movieList;
  final Function(Movie) onFavIconCLicked;
  final Function(Movie) onItemClicked;
  final Function() onRefresh;


  const FavoriteList({super.key, required this.movieList, required this.onFavIconCLicked, required this.onItemClicked, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => onRefresh.call(),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return FavoriteListTile(movie: movieList[index], onFavIconClicked: onFavIconCLicked,
            onItemClicked: onItemClicked,);
        },
        itemCount: movieList.length,
      ),
    );
  }
}
