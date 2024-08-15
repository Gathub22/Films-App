
import 'dart:convert';
import 'resultado_actor.dart';

RespuestaCreditos respuestaCreditosFromJson(String str) => RespuestaCreditos.fromJson(json.decode(str));

String respuestaCreditosToJson(RespuestaCreditos data) => json.encode(data.toJson());

class RespuestaCreditos {
  int id;
  List<ResultadoActor> actores;

  RespuestaCreditos({
    required this.id,
    required this.actores,
  });

  factory RespuestaCreditos.fromJson(Map<String, dynamic> json) => RespuestaCreditos(
    id: json["id"],
    actores: List<ResultadoActor>.from(json["cast"].map((x) => ResultadoActor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(actores.map((x) => x.toJson())),
  };

}
