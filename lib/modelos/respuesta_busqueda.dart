// To parse this JSON data, do
//
//     final resultadoBusqueda = resultadoBusquedaFromJson(jsonString);

import 'dart:convert';

import 'package:app_peliculas/modelos/resultado_pelicula.dart';

RespuestaBusqueda respuestaBusquedaFromJson(String str) => RespuestaBusqueda.fromJson(json.decode(str));

String respuestaBusquedaToJson(RespuestaBusqueda data) => json.encode(data.toJson());

class RespuestaBusqueda {
  int page;
  List<Pelicula> results;
  int totalPages;
  int totalResults;

  RespuestaBusqueda({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory RespuestaBusqueda.fromJson(Map<String, dynamic> json) => RespuestaBusqueda(
    page: json["page"],
    results: List<Pelicula>.from(json["results"].map((x) => Pelicula.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  factory RespuestaBusqueda.fromRawJson(String str) => RespuestaBusqueda.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}
