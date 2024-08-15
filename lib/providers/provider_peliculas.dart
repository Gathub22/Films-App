
import 'dart:async';

import 'package:app_peliculas/modelos/modelos.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProviderPeliculas extends ChangeNotifier {

  String _claveApi = "API_KEY";
  String _direccion = "api.themoviedb.org";
  String _idioma = "es-ES";

  List<ResultadoPortada> listaPortadas = [];
  List<ResultadoPopular> listaPopulares = [];
  Map <int, List<ResultadoActor>> peliculaActores = {};

  ProviderPeliculas(){
    print("Proveedor de peliculas iniciado");

    getPeliculasPortada();
    getPeliculasPopulares(1);
  }

  getPeliculasPortada() async {

    /// Uri con la info sobre la dirección URL
    var url = Uri.https(
        _direccion,             /// Dirección web
        '3/movie/now_playing',  /// Ruta de directorios
        {
          "api_key": _claveApi, /// Parámetros
          "language": _idioma,
          "page": "1"
        }
    );

    var respuesta = await http.get(url); /// Conectamos y guardamos la respuesta

    /// Convertimos el <body> de la respuesta en un peaso JSON
    var resultadosJson = RespuestaPortadas.fromRawJson(respuesta.body);

    /// Destripando: [peliculas existentes, nuevas peliculas}
    listaPortadas = [...listaPortadas, ...resultadosJson.results];
    // print(listaPortadas);

    /// notifyListeners() llama a todos los widgets que "escuchan" a esta clase
    notifyListeners();
  }

  getPeliculasPopulares(int pag) async {

    /// Uri con la info sobre la dirección URL
    var url = Uri.https(
        _direccion,             /// Dirección web
        '3/movie/popular',      /// Ruta de directorios
        {
          "api_key": _claveApi, /// Parámetros
          "language": _idioma,
          "page": pag.toString()
        }
    );

    var respuesta = await http.get(url); /// Conectamos y guardamos la respuesta

    /// Convertimos el <body> de la respuesta en un peaso JSON
    var resultadosJson = RespuestaPopulares.fromRawJson(respuesta.body);

    listaPopulares = [...listaPopulares, ...resultadosJson.results];
    // print(listaPopulares);

    /// notifyListeners() llama a todos los widgets que "escuchan" a esta clase
    notifyListeners();
  }

  Future<List<ResultadoActor>> getActoresPelicula(int id) async{

    if(peliculaActores.containsKey(id)) return peliculaActores[id]!;

    print("Sacando actores de $id...");

    var url = Uri.https(
        _direccion,             /// Dirección web
        '3/movie/${id}/credits',/// Ruta de directorios
        {
          "api_key": _claveApi, /// Parámetros
        }
    );
    var respuesta = await http.get(url);

                        /// Podria hacerme un fromRawJson en ResultadoActor... pero meh
    var resultadosJson = RespuestaCreditos.fromJson(json.decode(respuesta.body));

    peliculaActores[id] = resultadosJson.actores;

    return resultadosJson.actores;
  }

  Future<List<Pelicula>> buscarPeliculas(String termino) async{
    
    print("Buscando peliculas");
    
    final url = Uri.https(
        _direccion,             /// Dirección web
        '3/search/movie',      /// Ruta de directorios
        {
          "api_key": _claveApi, /// Parámetros
          "language": _idioma,
          "page": "1",
          "query": termino
        }
    );

    var respuesta = await http.get(url); /// Conectamos y guardamos la respuesta
    final respuestaBusqueda = RespuestaBusqueda.fromRawJson(respuesta.body);

    return respuestaBusqueda.results;
  }

  /// Creamos un controlador de Stream que acepte un valor de tipo List<Pelicula>
  final StreamController<List<Pelicula>> _suggestionControladorStream = new StreamController.broadcast();

  /// Para quien quiera enlazarse al controlador
  Stream<List<Pelicula>> get suggestionStream => this._suggestionControladorStream.stream;

  /// Este Debouncer hará que el controlador no ejecute el código de onValue
  /// hasta que no se cumpla un tiempo INTERNO determinado
  final desatascador = Debouncer(
    duration: Duration( milliseconds: 500 ) /// Su tiempo interno antes de ejecutar su onValue
  );

  void getSugerencias( String termino ){
    /// Asignamos un valor para que se cree un Timer dentro de desatascador
    desatascador.value = "";

    /// Creamos el bloque de código que queremos que se ejecute cuando asignemos
    /// el valor al onValue (vease "set value" en debouncer)
    desatascador.onValue = ( valor ) async {
      print("Busqueda: $valor");
      
      final peliculas = await this.buscarPeliculas(valor);
      this._suggestionControladorStream.add(peliculas); /// Enviamos la lista al Stream para que
                                                        /// se propague por los espectadores.
    };

    /// Este timer provocará que se ejecute la funcion de asignar valor al value tras
    /// un tiempo determinado (300 milisegundos)
    /// Cuando se declara su valor, se ejecuta el bloque de código sobre ese valor tras
    /// el tiempo interno de Debouncer definido.
    final t = Timer.periodic(Duration(milliseconds: 300), (_) {
      desatascador.value = termino; /// Al asignarse el valor, se borra el timer interno del
                                    /// desatascador. Cuando el usuario alcanza esta línea
                                    /// repetidas veces (escribiendo sin parar), se cancela
                                    /// el Timer que esté contando. Cuando el usuario pare
                                    /// de escribir, el nuevo Timer será el que le dé tiempo
                                    /// a acabar y podrá ejecutar el código de su onValue.
      print("Termino definido $termino");
    });

    /// Paramos el Timer creado (no el del Debouncer) para que no se repita.
    /// Lo hacemos justo después de que se haya ejecutado (1 milisegundo despues)
    Future.delayed(Duration(milliseconds: 301)).then(( _ ) => t.cancel() );
  }

}
