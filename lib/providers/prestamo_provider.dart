import 'package:flutter/material.dart';

import '../api/biblioteca_api.dart';
import '../models/prestamo.dart';

class PrestamoProvider extends ChangeNotifier {
  Future prestar(String idExistencia, String idPersona) async {
    final response = await BibliotecaAPI.httpPost(
        '/prestamos', {'existencia': idExistencia, 'persona': idPersona});
    return Prestamo.fromJson(response);
  }

  //TODO; debe ser id de prstamo
  Future<void> devolver(String id) async {
    await BibliotecaAPI.httpPut('/prestamos/$id', {});
  }
}
