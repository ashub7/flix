import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/core/utils/paging_controller.dart';
import 'package:flix/ui/features/home/widgets/movie_grid_tile.dart';
import 'package:flix/ui/features/home/widgets/movie_list_item.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movieList;
  final Function(Movie) onFavIconCLicked;
  final Function(Movie) onItemClicked;
  final PagingController pagingController;

  const MoviesList(
      {super.key,
      required this.movieList,
      required this.onFavIconCLicked,
      required this.onItemClicked,
      required this.pagingController});

  @override
  Widget build(BuildContext context) {
    int itemCount = movieList.length;
    if(pagingController.isLoading) itemCount++;
    return ScrollablePositionedList.separated(
      itemPositionsListener: pagingController.itemPositionsListener,
      itemScrollController: pagingController.itemScrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
       if(index<movieList.length){
         return MovieListItem(
           movie: movieList[index],
           index: index,
         );
       }else{
         return const SizedBox(
           width: double.infinity,
           height: 50,
           child: Center(child: CircularProgressIndicator.adaptive(),),
         );
       }
      },
      separatorBuilder: (context, index) {
        return 10.verticalSpaceFromWidth;
      },
    );
  }
}
