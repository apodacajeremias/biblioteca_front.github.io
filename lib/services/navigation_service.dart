import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Para mantener el context y poder volver atras segun contexto
  static navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  // Asigna el inicio de un nuevo contexto
  static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
