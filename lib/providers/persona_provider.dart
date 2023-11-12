// ignore_for_file: avoid_print

import 'package:biblioteca_front/api/biblioteca_api.dart';
import 'package:biblioteca_front/models/persona.dart';
import 'package:flutter/material.dart';

class PersonaProvider extends ChangeNotifier {
    String _query = '';
    Persona? _persona;

  String get query => _query;
  set query(String q) {
    print(q);
    _query = q;
    notifyListeners();
  }

Persona? get persona => _persona;
set persona(Persona? p) {
  _persona = p;
  notifyListeners();
}

    Future buscar(
      {int page = 0,
      int size = 100,
      bool activo = true,
      String query = ''}) async {
    var url = '/personas?page=$page&size=$size&activo=$activo&query=$query';
    final response = await BibliotecaAPI.httpGet(url);
    final listResponse =
        List.from(response).map((e) => Persona.fromJson(e)).toList();
    notifyListeners();
    return listResponse;
  }

  
}

