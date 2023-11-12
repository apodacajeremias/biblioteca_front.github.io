import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';
  Function(String) _onChanged = (value) {
    debugPrint(value);
  };

  String get query => _query;
  set query(String q) {
    print(q);
    _query = q;
    notifyListeners();
  }

  Function(String) get onChanged => _onChanged;
  set onChanged(Function(String) oc) {
    _onChanged = oc;
    notifyListeners();
  }
}
