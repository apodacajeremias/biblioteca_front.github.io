import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';

  String get query => _query;
  set query(String q) {
    print(q);
    _query = q;
    notifyListeners();
  }
}
