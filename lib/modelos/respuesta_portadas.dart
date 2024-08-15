
import 'dart:convert';

import 'resultado_nowplaying.dart';

// Generado con quicktype

class RespuestaPortadas {
  Dates dates;
  int page;
  List<ResultadoPortada> results;
  int totalPages;
  int totalResults;

  RespuestaPortadas({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory RespuestaPortadas.fromRawJson(String str) => RespuestaPortadas.fromJson(json.decode(str));

  factory RespuestaPortadas.fromJson(Map<String, dynamic> json) => RespuestaPortadas(
    dates: Dates.fromJson(json["dates"]),
    page: json["page"],
    results: List<ResultadoPortada>.from(json["results"].map((x) => ResultadoPortada.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "dates": dates.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };
}
