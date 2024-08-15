import 'package:app_peliculas/providers/providers.dart';
import 'package:app_peliculas/vistas/vistas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(EstadoApp());

class EstadoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /// MultiProvider devuelve un Widget en el que se pueden declarar los
    /// providers que usarán sus hijos.
    return MultiProvider(
      providers: [
        /// ProviderPeliculas se ejecuta en modo lazy a la espera de que se le llame.
        /// Para que se ejecute inmediatamente cuando se declara hay que decirle lo contrario.
        ChangeNotifierProvider(create: (_) => ProviderPeliculas(), lazy: false),

      ],
      child: MiApp(),
    );
  }
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculazas',
      initialRoute: 'casa',
      routes: Vistas.copiarVistas(),
      home: Scaffold(),
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF044bdc),
          elevation: 0,
        ),
      ),
    );
  }
}

//pedrosoe
//yimago1493@asuflex.com
//password1
// ddf137d5f2a3f040bc1e28aa7c6513a4
