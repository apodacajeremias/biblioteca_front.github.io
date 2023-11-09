// ignore_for_file: avoid_print

import 'package:biblioteca_front/api/biblioteca_api.dart';
import 'package:biblioteca_front/models/persona.dart';
import 'package:flutter/material.dart';

class PersonaProvider extends ChangeNotifier {

  disponibles({int page = 1}) async {
    final response = await BibliotecaAPI.httpGet('/persona/soloIDyString');print(response);
    final ofResponse = response.map((json) => Persona.fromJson(json)).toList();
    notifyListeners();
    
    return ofResponse;
  }

  Future<List> buscarPorNombre(String query, {int page = 1}) async {
    print('Buscando por nombre: $query');
    final response = await BibliotecaAPI.httpGet('/personas/porNombre?query=$query');
    List ofResponse = response.map((json) => Persona.fromJson(json)).toList();
    notifyListeners();
    return ofResponse;
  }

}
