import 'package:app_peliculas/modelos/modelos.dart';
import 'package:app_peliculas/widgets/desliza_actores.dart';
import 'package:flutter/material.dart';

class VistaDetalles extends StatelessWidget {
  const VistaDetalles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var pelicula;
    try{
      pelicula = ModalRoute.of(context)?.settings.arguments as ResultadoPortada;
    }catch(e){
      try{
        pelicula = ModalRoute.of(context)?.settings.arguments as ResultadoPopular;
      }catch(e){
        pelicula = ModalRoute.of(context)?.settings.arguments as Pelicula;
      }
    }

    return Scaffold(
      body: Scaffold(

        body: CustomScrollView(
          slivers: [
            _AppBarCinta(titulo: pelicula.title, foto: pelicula.urlFoto),
            SliverList(
              delegate: SliverChildListDelegate([
                _Poster(id: pelicula.id, foto: pelicula.urlFoto, titulo: pelicula.title, tituloOriginal: pelicula.originalTitle, anual: pelicula.releaseDate.toString(), nota: pelicula.voteAverage.toString()),
                _Resumen(desc: pelicula.overview),
                TarjetasActores(idPelicula: pelicula.id,)
              ]),
            )
          ],
        ),
      ),
    );
  }
}
// 1865f43a0549ca50d341dd9ab8b29f49
class _AppBarCinta extends StatelessWidget {
  _AppBarCinta({Key? key, required this.titulo, required this.foto}) : super(key: key);

  String titulo;
  String foto;

  @override
  Widget build(BuildContext context) {

    /// SliverAppBar es un Appbar al que se le puede poner un fondo
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
          placeholder: AssetImage("recursos/loading.gif"),
          image: NetworkImage(this.foto),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  _Poster({Key? key, required this.id, required this.foto, required this.titulo, required this.tituloOriginal, required this.anual, required this.nota}) : super(key: key);

  int id;
  String foto;
  String titulo;
  String tituloOriginal;
  String anual;
  String nota;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Row(
        children: [
          Hero(
            tag: id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage("recursos/no-image.jpg"),
                image: NetworkImage(this.foto),
                height: 200,
              )
            ),
          ),

          SizedBox(width: 20,),

          /// ConstrainedBox es un widget que permite poner límites de espacio a los widgets hijos
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.titulo, style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(this.tituloOriginal, style: Theme.of(context).textTheme.labelLarge, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(this.anual, style: Theme.of(context).textTheme.labelSmall, overflow: TextOverflow.ellipsis, maxLines: 2),

                Row(
                  children: [
                    Icon(Icons.star, size: 25, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(this.nota, style: Theme.of(context).textTheme.bodySmall,)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Resumen extends StatelessWidget {
  _Resumen({Key? key, required this.desc}) : super(key: key);

  String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        desc,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}


