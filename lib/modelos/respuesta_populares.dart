
import 'dart:convert';

import 'package:app_peliculas/modelos/resultado_popular.dart';

RespuestaPopulares respuestaPopularesFromJson(String str) => RespuestaPopulares.fromJson(json.decode(str));

String respuestaPopularesToJson(RespuestaPopulares data) => json.encode(data.toJson());

class RespuestaPopulares {
  int page;
  List<ResultadoPopular> results;
  int totalPages;
  int totalResults;

  RespuestaPopulares({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory RespuestaPopulares.fromRawJson(String str) => RespuestaPopulares.fromJson(json.decode(str));

  factory RespuestaPopulares.fromJson(Map<String, dynamic> json) => RespuestaPopulares(
    page: json["page"],
    results: List<ResultadoPopular>.from(json["results"].map((x) => ResultadoPopular.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

