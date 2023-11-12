

import 'package:biblioteca_front/ui/views/obra_view.dart';
import 'package:fluro/fluro.dart';

class ObraHandler{
  static Handler devueltos = Handler(handlerFunc: (context, parameters) => const ObraView(ObraViewType.DEVUELTOS));
  static Handler disponibles = Handler(handlerFunc: (context, parameters) => const ObraView(ObraViewType.DISPONIBLES));
  static Handler prestados = Handler(handlerFunc: (context, parameters) => const ObraView(ObraViewType.PRESTADOS));
}