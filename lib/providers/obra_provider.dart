// ignore_for_file: avoid_print

import 'package:biblioteca_front_02/api/biblioteca_api.dart';
import 'package:biblioteca_front_02/models/obra.dart';
import 'package:biblioteca_front_02/models/pages/obra_paging.dart';
import 'package:biblioteca_front_02/models/pages/paging.dart';
import 'package:flutter/material.dart';
class ObraProvider extends ChangeNotifier {

  // List<Obra> disponibles = [];
  // List<Obra> devueltos = [];
  // List<Obra> prestados = [];

  Future buscar({int page = 0, int size = 100, bool? activo = true}) async {
    final pagingResponse = await BibliotecaAPI.httpGet('/obras?page=$page&size=$size&activo=$activo');
    final paging = pagingFromJson(pagingResponse);
    final content = paging.content.map((e) => Obra.fromJson(e)).toList();
    final obraPaging = ObraPaging(paging: paging, content: content);
    notifyListeners();
    return obraPaging;
  }

}
