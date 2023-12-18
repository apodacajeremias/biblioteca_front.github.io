import 'package:biblioteca_front/models/records/contador_entrada.dart';
import 'package:flutter/material.dart';

import '../api/biblioteca_api.dart';
import '../models/entrada.dart';

class EntradaProvider extends ChangeNotifier {
  List<ContadorEntrada> contadorEntradas = [];
  List<ContadorEntrada> promedioEntradas = [];
  Future buscar({int page = 0, String query = ''}) async {
    var url = '/entradas?page=$page&query=$query';
    final response = await BibliotecaAPI.httpGet(url);
    final listResponse =
        List.from(response).map((p) => Entrada.fromJson(p)).toList();
    notifyListeners();
    return listResponse;
  }

  Future entrar(String idPersona, String motivo) async {
    final response = await BibliotecaAPI.httpPost(
        '/entradas', {'persona': idPersona, 'motivo': motivo});
    return Entrada.fromJson(response);
  }

  Future salir(String id) async {
    await BibliotecaAPI.httpPut('/entradas/$id', {});
  }

  Future<void> contar({DateTime? from, DateTime? to}) async {
    String url = '/entradas/contar';
    final response = await BibliotecaAPI.httpGet(url);
    List<ContadorEntrada> list =
        List.from(response.map((x) => ContadorEntrada.fromJson(x)));
    contadorEntradas = list;
    notifyListeners();
  }

  Future<void> promedio({DateTime? from, DateTime? to}) async {
    String url = '/entradas/promedio';
    final response = await BibliotecaAPI.httpGet(url);
    List<ContadorEntrada> list =
        List.from(response.map((x) => ContadorEntrada.fromJson(x)));
    promedioEntradas = list;
    notifyListeners();
  }
}
