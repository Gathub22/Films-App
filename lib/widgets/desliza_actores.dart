import 'package:app_peliculas/modelos/modelos.dart';
import 'package:app_peliculas/providers/provider_peliculas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarjetasActores extends StatelessWidget {

  TarjetasActores({Key? key, required this.idPelicula}) : super(key: key);

  int idPelicula;

  @override
  Widget build(BuildContext context) {


    var providerPeliculas = Provider.of<ProviderPeliculas>(context, listen: false);

    /// Con un FutureBuilder, podemos hacer que se itere sobre una lista de elementos
    /// y devuelva tarjetas con la información de cada uno
    return FutureBuilder(
        future: providerPeliculas.getActoresPelicula(this.idPelicula),
        builder: (_, AsyncSnapshot<List<ResultadoActor>> snapshot) {

          if(!snapshot.hasData){
            return Container();
          }


          return Container(
            width: double.infinity,
            height: 128,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _TarjetaActor(actor: snapshot.data![index]),

              /// ES LO MISMO
              // itemBuilder: (BuildContext context, int index){
              //   return _TarjetaActor();
              // }
            ),
          );
        }
    );


  }
}

class _TarjetaActor extends StatelessWidget {
  _TarjetaActor({Key? key, required this.actor}) : super(key: key);

  ResultadoActor actor;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 90,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage("recursos/no-image.jpg"),
              image: NetworkImage(actor.urlFoto),
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 2,),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

