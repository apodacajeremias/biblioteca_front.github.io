import 'package:flutter/material.dart';

import '../api/biblioteca_api.dart';
import '../models/entrada.dart';
import '../models/prestamo.dart';

class EntradaProvider extends ChangeNotifier {
  Future buscar({int page = 0, String query = ''}) async {
    var url = '/entradas?page=$page&query=$query';
    final response = await BibliotecaAPI.httpGet(url);
    final listResponse =
        List.from(response).map((p) => Prestamo.fromJson(p)).toList();
    notifyListeners();
    return listResponse;
  }

  Future entrar(String idPersona, String motivo) async {
    final response = await BibliotecaAPI.httpPost('/entradas', {'persona' : idPersona, 'motivo' : motivo});
    return Entrada.fromJson(response);
  }

  Future salir(String id) async {
    await BibliotecaAPI.httpPut('/entradas/$id', {});
  }
}
