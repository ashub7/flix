import 'package:flix/domain/entities/movie_photos_entity.dart';

class MoviePhotosResponse {
  List<MovieImageResponse>? backdrops;
  List<MovieImageResponse>? posters;

  MoviePhotosResponse({this.backdrops, this.posters});

  MoviePhotosResponse.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrops = <MovieImageResponse>[];
      json['backdrops'].forEach((v) {
        backdrops!.add(MovieImageResponse.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = <MovieImageResponse>[];
      json['posters'].forEach((v) {
        posters!.add(MovieImageResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (backdrops != null) {
      data['backdrops'] = backdrops!.map((v) => v.toJson()).toList();
    }
    if (posters != null) {
      data['posters'] = posters!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  MoviePhotosEntity toEntity() {
    return MoviePhotosEntity(
        backdrops: backdrops?.map((e) => e.toEntity()).toList(),
        posters: posters?.map((e) => e.toEntity()).toList());
  }
}

class MovieImageResponse {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  MovieImageResponse(
      {required this.aspectRatio,
      required this.height,
      required this.iso6391,
      required this.filePath,
      required this.voteAverage,
      required this.voteCount,
      required this.width});

  MovieImageResponse.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aspect_ratio'] = aspectRatio;
    data['height'] = height;
    data['iso_639_1'] = iso6391;
    data['file_path'] = filePath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['width'] = width;
    return data;
  }

  MovieImageEntity toEntity() => MovieImageEntity(
      aspectRatio: aspectRatio,
      height: height,
      iso6391: iso6391,
      filePath: filePath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      width: width);
}
