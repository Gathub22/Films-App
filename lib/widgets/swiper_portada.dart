import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../modelos/modelos.dart';

class SwiperTarjetas extends StatelessWidget {

  final List<ResultadoPortada> peliculas;
  const SwiperTarjetas({Key? key, required this.peliculas}) : super(key: key);



  /// PELICULAS DE PORTADA
  @override
  Widget build(BuildContext context) {

    /// Tamaño de la pantalla
    final dimensiones = MediaQuery.of(context).size;

    /// Si no hay peliculas por el momento...
    if(peliculas.isEmpty){
      return Container(
        width: double.infinity,
        height: dimensiones.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: dimensiones.height * 0.5,
      child: Swiper(
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
        itemWidth: dimensiones.width * 0.5,
        itemHeight: dimensiones.height * 0.45,

        /// Constructor de GestureDetectors con películas de portada
        itemBuilder: (_, int index){

          final pelicula = peliculas[index];

          /// GestureDetector es un widget que ejecuta código cuando se pulsa sobre él
          return GestureDetector(

            onTap: () => Navigator.pushNamed(context, 'detalles',  arguments: pelicula),

            child: Hero(

              tag: pelicula.id,
              child: ClipRRect( /// ClipRRect crea un widget para ponerle bordes redondeados
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: const AssetImage("recursos/no-image.jpg"),
                  image: NetworkImage(pelicula.urlFoto),
                  fit: BoxFit.cover,
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}
