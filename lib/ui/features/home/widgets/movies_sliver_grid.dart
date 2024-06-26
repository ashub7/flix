import 'package:flix/ui/features/home/widgets/movie_grid_tile.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:flutter/material.dart';

class MoviesSliverGrid extends StatelessWidget {
  final List<Movie> movieList;
  final Function(Movie) onFavIconCLicked;
  final Function(Movie) onItemClicked;


  const MoviesSliverGrid({super.key, required this.movieList, required this.onFavIconCLicked, required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MovieGridTile(movie: movieList[index], onFavIconClicked: onFavIconCLicked,
                    onItemClicked: onItemClicked,);
          },
          childCount: movieList.length,
        ),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            mainAxisSpacing: 12,
            mainAxisExtent: 260,
            crossAxisSpacing: 12),
      ),
    );
  }
}
