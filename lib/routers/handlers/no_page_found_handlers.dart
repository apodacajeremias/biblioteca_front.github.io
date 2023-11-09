import 'package:fluro/fluro.dart';

import 'package:biblioteca_front/ui/views/no_page_found_view.dart';

class NoPageFoundHandlers {

  static Handler noPageFound = Handler(
    handlerFunc: ( context, params ) {
      return NoPageFoundView();
    }
  );


}

