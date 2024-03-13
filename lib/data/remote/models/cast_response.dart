import 'package:flix/domain/entities/cast_entity.dart';

class CastListResponse {
  int? id;
  List<CastResponse>? cast;

  CastListResponse({this.id, this.cast});

  CastListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = <CastResponse>[];
      json['cast'].forEach((v) {
        cast!.add(CastResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (cast != null) {
      data['cast'] = cast!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CastResponse {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  CastResponse({ required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order});

  CastResponse.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['order'] = order;
    return data;
  }

  CastEntity toEntity() {
    return CastEntity(adult: adult,
        gender: gender,
        id: id,
        knownForDepartment: knownForDepartment,
        name: name,
        originalName: originalName,
        popularity: popularity,
        profilePath: profilePath,
        castId: castId,
        character: character,
        creditId: creditId,
        order: order);
  }
}
