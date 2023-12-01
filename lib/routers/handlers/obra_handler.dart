

import 'package:biblioteca_front/ui/views/entrada/entrada_list_view.dart';
import 'package:biblioteca_front/ui/views/obra/obra_list_view.dart';
import 'package:fluro/fluro.dart';

class BibliotecaHandler{
  static Handler devueltos = Handler(handlerFunc: (context, parameters) => const ObraListView(ObraViewType.DEVUELTOS));
  static Handler disponibles = Handler(handlerFunc: (context, parameters) => const ObraListView(ObraViewType.DISPONIBLES));
  static Handler prestados = Handler(handlerFunc: (context, parameters) => const ObraListView(ObraViewType.PRESTADOS));
  static Handler entradas = Handler(handlerFunc: (context, parameters) => const EntradaListView());
}