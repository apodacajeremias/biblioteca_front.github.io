import 'package:biblioteca_front/api/biblioteca_api.dart';
import 'package:biblioteca_front/models/obra.dart';
import 'package:biblioteca_front/models/prestamo.dart';
import 'package:biblioteca_front/ui/views/obra_view.dart';
import 'package:flutter/material.dart';

class ObraProvider extends ChangeNotifier {
  Future buscar(ObraViewType type, {int page = 0, String query = ''}) async {
    var url = '${type.source}&page=$page&query=$query';
    switch (type) {
      case ObraViewType.DISPONIBLES:
        final response = await BibliotecaAPI.httpGet(url);
        final listResponse =
            List.from(response).map((e) => Obra.fromJson(e)).toList();
        notifyListeners();
        return listResponse;
      case ObraViewType.DEVUELTOS:
        final response = await BibliotecaAPI.httpGet(url);
        final listResponse =
            List.from(response).map((e) => Prestamo.fromJson(e)).toList();
        notifyListeners();
        return listResponse;
      case ObraViewType.PRESTADOS:
        final response = await BibliotecaAPI.httpGet(url);
        final listResponse =
            List.from(response).map((e) => Prestamo.fromJson(e)).toList();
        notifyListeners();
        return listResponse;
    }
  }
}
