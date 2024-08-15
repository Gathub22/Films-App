import 'dart:collection';

import 'package:app_peliculas/vistas/casa.dart';
import 'package:app_peliculas/vistas/detalles.dart';
import 'package:flutter/cupertino.dart';

class Vistas{

  static Map<String, Widget> vistas = {
    'casa': VistaCasa(),
    'detalles': VistaDetalles()
  };

  static cogerVista(String clave){
    return (_) => vistas[clave];
  }

  static copiarVistas(){
    Map<String, WidgetBuilder> lista = <String, WidgetBuilder>{};

    for (var i in vistas.entries){
      lista[i.key] = ((_) => i.value);
    }
    return lista;
  }

}