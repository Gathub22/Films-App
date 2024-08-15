import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../modelos/modelos.dart';

class DeslizaPeliculas extends StatefulWidget {
  DeslizaPeliculas({Key? key, required this.titulo, required this.peliculas, required this.siguientePagina}) : super(key: key);

  String titulo;
  List<ResultadoPopular> peliculas;
  Function siguientePagina;

  /// PELICULAS POPULARES
  @override
  State<DeslizaPeliculas> createState() => _DeslizaPeliculasState();
}

class _DeslizaPeliculasState extends State<DeslizaPeliculas> {

  final ScrollController controladorScroll = new ScrollController();

  int pag = 2;
  /// initState() es una función que se ejecuta cuando aparece un nuevo item.
  /// (Ver ListView.builder)
  @override
  void initState(){
    super.initState();
    controladorScroll.addListener(() {

      /// pixels saca la posicion actual del scroll
      // print(controladorScroll.position.pixels);

      /// maxScrollExtent saca la extensión máxima del scroll
      // print(controladorScroll.position.maxScrollExtent);

      /// Cuando la posición actual del scroll es mayor al límite de este, cargamos una nueva
      /// página de películas populares. Para ello le pasamos un argumento que actualiza nuestra
      /// lista de películas que está enlazada con el argumento de sacar populares.
      if(controladorScroll.position.pixels >= controladorScroll.position.maxScrollExtent-500){

        print("Cargando más imágenes (pag $pag)...");

        /// widget saca la información del widget que alberga esta función
        widget.siguientePagina(pag);
        pag++;
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 255,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(widget.titulo,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
            ),
          ),
          Expanded(
              child: ListView.builder(
                controller: controladorScroll,
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.peliculas.length,
              itemBuilder: (_, int index) => PortadaPelicula(pelicula: this.widget.peliculas[index],),
            )
          )
        ],
      ),
    );
  }
}

class PortadaPelicula extends StatelessWidget {
  PortadaPelicula({Key? key, required this.pelicula}) : super(key: key);

  ResultadoPopular pelicula;

  @override
  Widget build(BuildContext context) {

    if(pelicula.title==""){
      return Container();
    }
    return Container(
      width: 130,
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(

            /// Hero es un widget que al cambiar de vista, hace que este
            /// se mueva de una actividad de otra en la transición.
            /// Necesita un id. Con ese id buscará a otro Hero de la
            /// siguiente actividad que tenga el mismo id para saber cual
            /// es su "destino".
            child: Hero(
              tag: pelicula.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('recursos/no-image.jpg'),
                  image: NetworkImage(pelicula.urlFoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () => Navigator.pushNamed(context, 'detalles',  arguments: pelicula),
          ),
          const SizedBox(height: 5),
          Text(
            pelicula.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
