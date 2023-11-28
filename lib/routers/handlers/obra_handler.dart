

import 'package:biblioteca_front/ui/views/obra/obra_list_view.dart';
import 'package:fluro/fluro.dart';

class ObraHandler{
  static Handler devueltos = Handler(handlerFunc: (context, parameters) => const ObraListView(ObraViewType.DEVUELTOS));
  static Handler disponibles = Handler(handlerFunc: (context, parameters) => const ObraListView(ObraViewType.DISPONIBLES));
  static Handler prestados = Handler(handlerFunc: (context, parameters) => const ObraListView(ObraViewType.PRESTADOS));
}