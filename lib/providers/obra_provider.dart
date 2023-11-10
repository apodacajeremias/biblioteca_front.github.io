import 'package:biblioteca_front/api/biblioteca_api.dart';
import 'package:biblioteca_front/models/obra.dart';
import 'package:flutter/material.dart';

class ObraProvider extends ChangeNotifier {
  // List<Obra> disponibles = [];
  // List<Obra> devueltos = [];
  // List<Obra> prestados = [];

  Future buscar(String source,
      {int page = 0,
      int size = 100,
      bool activo = true,
      String query = ''}) async {
    var url = '$source?page=$page&size=$size&activo=$activo&query=$query';
    print(url);
    final response = await BibliotecaAPI.httpGet(url);
    final listResponse =
        List.from(response).map((e) => Obra.fromJson(e)).toList();
    notifyListeners();
    return listResponse;
  }
}
