
import 'package:biblioteca_front/routers/handlers/no_page_found_handlers.dart';
import 'package:biblioteca_front/routers/handlers/obra_handler.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {

  static final FluroRouter router = FluroRouter();

  static String rootRoute     = '/';

  // Obras
  static String obrasDisponiblesRoute  = '/disponibles';
  static String obrasPrestadasRoute  = '/prestados';
  static String obrasDevueltasRoute      = '/devueltos';


  static void configureRoutes() {
    // Auth Routes
    router.define( rootRoute, handler: ObraHandler.disponibles, transitionType: TransitionType.none );
    // router.define( loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    // router.define( registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none );

    // Dashboard
    router.define( obrasDisponiblesRoute, handler: ObraHandler.disponibles, transitionType: TransitionType.none );
    router.define( obrasPrestadasRoute, handler: ObraHandler.prestados, transitionType: TransitionType.none );
    router.define( obrasDevueltasRoute, handler: ObraHandler.devueltos, transitionType: TransitionType.none );
    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;

  }
  


}
