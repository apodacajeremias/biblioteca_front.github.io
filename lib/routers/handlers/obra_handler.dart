
import 'package:biblioteca_front/ui/views/obra_disponible.dart';
import 'package:fluro/fluro.dart';

class ObraHandler{
  static Handler devueltos = Handler(handlerFunc: (context, parameters) => const ObraDisponibleView());
  static Handler disponibles = Handler(handlerFunc: (context, parameters) => const ObraDisponibleView());
  static Handler prestados = Handler(handlerFunc: (context, parameters) => const ObraDisponibleView());
}