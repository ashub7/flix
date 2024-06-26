import 'dart:math';

import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:flix/ui/widgets/animation/highlight.dart';
import 'package:flutter/material.dart';

class MovieListItem extends StatefulWidget {
  final Movie movie;
  final int index;

  const MovieListItem({super.key, required this.movie, required this.index});

  @override
  State<MovieListItem> createState() => _MovieListItemState();
}

class _MovieListItemState extends State<MovieListItem> {

  @override
  void initState() {
    if(widget.movie.height==0){
      widget.movie.height = ( 40*(Random().nextInt(6)+1)).toDouble();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   /* if(widget.movie.shouldHighlight) {
      scheduleUnhighlight();
    }*/
    return SmoothHighlight(
      color: Colors.blue,
      enabled: widget.movie.shouldHighlight,
      child: Container(
        height: widget.movie.height,
        decoration: BoxDecoration(
          border: Border.all(color: context.onPrimary, width: 2),
          color: widget.movie.shouldHighlight? Colors.blue.withOpacity(0.8) : null
        ),
        child: Center(
          child: Text(
              " ${widget.index} =>  ${widget.movie.originalTitle}"),
        ),
      ),
    );
  }

  scheduleUnhighlight() async {
    await Future.delayed(const Duration(seconds: 2));
    widget.movie.shouldHighlight = false;
    if(mounted) {
      setState(() {
      });
    }
  }
}
