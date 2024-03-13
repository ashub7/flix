import '../../core/utils/constants.dart';

class Cast {
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

  Cast(
      {required this.adult,
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

  String get profileImage =>
      profilePath != null ? "${Constants.imageBaseUrl}$profilePath" : "";
}
