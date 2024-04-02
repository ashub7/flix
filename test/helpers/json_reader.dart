import 'dart:convert';
import 'dart:io';

import 'package:flix/data/local/model/user_model.dart';
import 'package:flix/data/remote/models/cast_response.dart';
import 'package:flix/data/remote/models/movie_detail_response.dart';
import 'package:flix/data/remote/models/movie_list_response.dart';
import 'package:flix/data/remote/models/movie_photos_response.dart';
import 'package:flix/ui/models/movie_detail.dart';


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
