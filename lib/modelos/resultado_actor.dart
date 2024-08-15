
import 'meta.dart';

class ResultadoActor {
  bool adult;
  int gender;
  int id;
  String? knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int castId;
  String? character;
  String creditId;
  int? order;

  ResultadoActor({
    required this.adult,
    required this.gender,
    required this.id,
    this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.castId,
    this.character,
    required this.creditId,
    this.order,
  });

  get urlFoto{
    if(profilePath == null){
      return "https://i.stack.imgur.com/GNhxO.png";
    }
    return "https://image.tmdb.org/t/p/w500$profilePath";
  }

  factory ResultadoActor.fromJson(Map<String, dynamic> json) => ResultadoActor(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"]!,
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartmentValues.reverse[knownForDepartment],
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "order": order,
  };
}