import 'package:biblioteca_front/api/biblioteca_api.dart';
import 'package:biblioteca_front/app_colors.dart';
import 'package:biblioteca_front/routers/router.dart';
import 'package:biblioteca_front/services/navigation_service.dart';
import 'package:biblioteca_front/services/notifications_service.dart';
import 'package:biblioteca_front/ui/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'providers/entrada_provider.dart';
import 'providers/obra_provider.dart';
import 'providers/persona_provider.dart';
import 'providers/search_provider.dart';
import 'providers/prestamo_provider.dart';

void main() async {
  BibliotecaAPI.configureDio();
  Flurorouter.configureRoutes();
  await initializeDateFormatting('es');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EntradaProvider()),
        ChangeNotifierProvider(create: (context) => ObraProvider()),
        ChangeNotifierProvider(create: (context) => PersonaProvider()),
        ChangeNotifierProvider(create: (context) => PrestamoProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider())
      ],
      child: const MyDashboard(),
    );
  }
}

class MyDashboard extends StatelessWidget {
  const MyDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (context, child) => DashboardLayout(child: child!),
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          // seedColor: const Color(0xFFFFFDF1),
          // primary: const Color(0xFFB0C4DE),
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          // ···
          brightness: Brightness.light,
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
          titleLarge: GoogleFonts.oswald(
            fontSize: 32,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(fontSize: 16),
          displaySmall: GoogleFonts.montserrat(fontSize: 12),
        ),
      ),
    );
  }
}
