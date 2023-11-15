import 'package:flutter/material.dart';

import '../api/biblioteca_api.dart';
import '../models/prestamo.dart';

class PrestamoProvider extends ChangeNotifier {

  Future prestar(String idObra, String idPersona) async {
    final response = await BibliotecaAPI.httpPost('/prestamos/prestar/$idObra/$idPersona', {});
    return Prestamo.fromJson(response);
  }

 //TODO; debe ser id de prstamo
  Future devolver(String idObra) async {
  final response = await BibliotecaAPI.httpPut('/prestamos/devolver/$idObra', {});
    return Prestamo.fromJson(response);
  }
}