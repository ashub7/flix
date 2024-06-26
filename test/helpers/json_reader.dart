import 'dart:convert';
import 'dart:io';

import 'package:flix/data/local/model/fav_movie_model.dart';
import 'package:flix/data/local/model/user_model.dart';
import 'package:flix/data/remote/models/cast_response.dart';
import 'package:flix/data/remote/models/movie_detail_response.dart';
import 'package:flix/data/remote/models/movie_list_response.dart';
import 'package:flix/data/remote/models/movie_photos_response.dart';
import 'package:flix/ui/models/movie_list.dart';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/$name').readAsStringSync();
}

MovieListResponse dummyMovieListResponse() {
  final Map<String, dynamic> jsonMap = json
      .decode(readJson("helpers/dummy_data/dummy_movie_list_response.json"));
  return MovieListResponse.fromJson(jsonMap);
}

Movie getDummyMovie(){
  return dummyMovieListResponse().results[0].toEntity().toUiModel();
}

MovieDetailResponse dummyMovieDetailResponse() {
  final Map<String, dynamic> jsonMap =
      json.decode(readJson("helpers/dummy_data/dummy_movie_detail.json"));
  return MovieDetailResponse.fromJson(jsonMap);
}

MoviePhotosResponse dummyPhotosResponse() {
  final Map<String, dynamic> jsonMap =
      json.decode(readJson("helpers/dummy_data/dummy_images.json"));
  return MoviePhotosResponse.fromJson(jsonMap);
}

CastListResponse dummyCastResponse() {
  final Map<String, dynamic> jsonMap =
      json.decode(readJson("helpers/dummy_data/dummy_cast.json"));
  return CastListResponse.fromJson(jsonMap);
}

UserModel dummyUser() {
  return UserModel(
      id: null,
      fullName: "Raven",
      email: "a@erd.com",
      password: "111111",
      gender: 1,
      avatar: "",
      dob: "12/03/91");
}

List<FavMovieModel> dummyFavoritesList() {
  return dummyMovieListResponse()
      .results
      .map((e) => FavMovieModel(
          adult: e.adult,
          backdropPath: e.backdropPath,
          id: e.id,
          title: e.title,
          originalLanguage: e.originalLanguage,
          originalTitle: e.originalTitle,
          overview: e.overview,
          posterPath: e.posterPath,
          mediaType: e.mediaType,
          popularity: e.popularity,
          releaseDate: e.releaseDate,
          video: e.video,
          voteAverage: e.voteAverage,
          voteCount: e.voteCount))
      .toList();
}
