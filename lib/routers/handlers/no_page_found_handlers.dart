import 'package:fluro/fluro.dart';

import 'package:biblioteca_front_02/ui/views/no_page_found_view.dart';

class NoPageFoundHandlers {

  static Handler noPageFound = Handler(
    handlerFunc: ( context, params ) {
      return NoPageFoundView();
    }
  );


}

