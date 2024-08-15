
import 'dart:async';

import 'package:app_peliculas/modelos/resultado_pelicula.dart';
import 'package:app_peliculas/providers/provider_peliculas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class PeliculaSearchDelegate extends SearchDelegate{

  @override
  /// Podemos cambiar el texto de búsqueda
  String? get searchFieldLabel => "Buscar películas";

  @override
  /// buildActions define las acciones que se pueden escoger
  /// al lado del campo de búsqueda
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )

    ];
  }

  @override
  /// buildLeading se posiciona al lado del campo de busqueda
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
    );
  }

  @override
  /// buildResults aparece cuando ejecutamos el buildActions
  Widget buildResults(BuildContext context) {

    return busqueda(context);
  }

  @override
  /// buildSuggestions aparece cuando se abre el SearchDelegate
  /// Cuando se escribe texto, este lo recibe automáticamente
  Widget buildSuggestions(BuildContext context) {
    
    return busquedaSuggestions(context);
  }

  /// Esta función determina que se muestra por pantalla. Como da la casualidad
  /// de que buildSuggestions y buildResults hacen lo mismo, hago esta función
  /// para simplificar. Necesita el contexto para llamar al proveedor
  Widget busqueda(contexto){

    if(query.isEmpty){
      return Container(
        child: Center(
          child: Icon(Icons.play_disabled, color: Colors.grey, size: 100,),
        ),
      );
    }

    /// Llamamos al proveedor a que le pida a la API las peliculas que coincidan
    final proveedorPeliculas = Provider.of<ProviderPeliculas>(contexto, listen: false);

    return FutureBuilder(
        future: proveedorPeliculas.buscarPeliculas(query),
        builder: (_, AsyncSnapshot<List<Pelicula>> snapshot) {

          final peliculas = snapshot.data;
          if(peliculas == null || peliculas.isEmpty) return _WidgetVacio();


          return ListView.builder(
            itemCount: peliculas.length,
            itemBuilder: (_, int index) => ItemPelicula(pelicula: peliculas[index]),

          );
        }
    );
  }

  Widget busquedaSuggestions(contexto){

    if(query.isEmpty){
      return Container(
        child: Center(
          child: Icon(Icons.play_disabled, color: Colors.grey, size: 100,),
        ),
      );
    }

    /// Llamamos al proveedor a que le pida a la API las peliculas que coincidan
    final proveedorPeliculas = Provider.of<ProviderPeliculas>(contexto, listen: false);
    proveedorPeliculas.getSugerencias(query);

    return StreamBuilder(
        stream: proveedorPeliculas.suggestionStream, /// Se queda enlazado con el Stream
        builder: (_, AsyncSnapshot<List<Pelicula>> snapshot) {

          final peliculas = snapshot.data;
          if(peliculas == null || peliculas.isEmpty) return _WidgetVacio();


          return ListView.builder(
            itemCount: peliculas.length,
            itemBuilder: (_, int index) => ItemPelicula(pelicula: peliculas[index]),

          );
        }
    );
  }

  Widget _WidgetVacio(){
    return Container(
      child: Center(
          child: Icon(Icons.search_off_sharp, size: 100, color: Colors.grey,)
      ),
    );
  }

}



class ItemPelicula extends StatelessWidget {
  ItemPelicula({Key? key, required this.pelicula}) : super(key: key);

  final Pelicula pelicula;
  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: Hero(
        tag: pelicula.id,
        child: FadeInImage(
          placeholder: AssetImage("recursos/no-image.jpg"),
          image: NetworkImage(pelicula.urlFoto),
          height: 100,
          width: 50,
          fit: BoxFit.contain,
        ),
      ),

      title: Text(pelicula.title),
      subtitle: Text(pelicula.originalTitle),
      onTap: () => Navigator.pushNamed(context, "detalles", arguments: pelicula ),

    );
    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 20),
    //   child: ConstrainedBox(
    //     constraints: BoxConstraints(maxWidth: 10),
    //     child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //
    //         children: [
    //           GestureDetector(
    //             child: FadeInImage(
    //               placeholder: AssetImage("recursos/no-image.jpg"),
    //               image: NetworkImage(pelicula.urlFoto),
    //               height: 100,
    //               width: 50,
    //               fit: BoxFit.contain,
    //             ),
    //             onTap: () => Navigator.pushNamed(context, "detalles", arguments: pelicula ),
    //           ),
    //
    //           Column(
    //             children: [
    //               Text(pelicula.title, textAlign: TextAlign.left, style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.clip, maxLines: 2,),
    //               Text(pelicula.originalTitle, textAlign: TextAlign.left, style: Theme.of(context).textTheme.labelLarge,),
    //               Text(pelicula.releaseDate.toString(), textAlign: TextAlign.left, style: Theme.of(context).textTheme.labelLarge,)
    //             ],
    //           )
    //         ]
    //     ),
    //   )
    // );
  }
}
