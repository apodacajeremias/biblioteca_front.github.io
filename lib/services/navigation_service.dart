import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Se usa para mantener el context y poder volver atras, lo que hace es agregar la vista arriba de las vistas anteriores.
  static _navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  /// Se usa para reemplazar la vista anterior, mantiene el context pero substituye la vista mas reciente.
    static replaceTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
