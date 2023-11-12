// ignore_for_file: avoid_print

import 'package:biblioteca_front/api/biblioteca_api.dart';
import 'package:biblioteca_front/models/persona.dart';
import 'package:flutter/material.dart';

class PersonaProvider extends ChangeNotifier {

    Future buscar(
      {int page = 0,
      int size = 100,
      bool activo = true,
      String query = ''}) async {
    var url = '/personas?page=$page&size=$size&activo=$activo&query=$query';
    print(url);
    final response = await BibliotecaAPI.httpGet(url);
    final listResponse =
        List.from(response).map((e) => Persona.fromJson(e)).toList();
    notifyListeners();
    return listResponse;
  }
}
