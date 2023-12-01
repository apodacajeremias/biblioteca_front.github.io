import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';

  String get query => _query;
  set query(String q) {
    print("Search query: $q");
    _query = q;
    notifyListeners();
  }

  refresh() {
    debugPrint('refresh ui');
    notifyListeners();
  }
}
