import 'package:app_peliculas/busqueda/delegado_busqueda.dart';
import 'package:app_peliculas/providers/provider_peliculas.dart';
import 'package:app_peliculas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VistaCasa extends StatelessWidget {
  const VistaCasa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    /// Guardamos en una variable el ProveedorPeliculas que saca todas las películas
    ///
    /// Para ello llamamos a Provider.of() con su contexto. Para que encuentre nuestro
    /// clase provider tenemos que especificar el tipo (ProviderPeliculas) de retorno.
    /// Así Flutter lo busca. Si no lo encuentra (porque no se haya creado antes), lo
    /// crea y ejecuta.
    final proveedorPeliculas = Provider.of<ProviderPeliculas>(context);


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text("Peliculas "),
            actions: [
              IconButton(
                icon: const Icon(Icons.search_outlined),
                onPressed: () => showSearch(context: context, delegate: PeliculaSearchDelegate()),
              )
            ],
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Tarjetas principales
            SwiperTarjetas(peliculas: proveedorPeliculas.listaPortadas,),

            // Slider de películas
            DeslizaPeliculas(titulo: "Populares",
              peliculas: proveedorPeliculas.listaPopulares,
              siguientePagina: proveedorPeliculas.getPeliculasPopulares,
            ),

          ],
        ),
      ),
    );
  }
}
