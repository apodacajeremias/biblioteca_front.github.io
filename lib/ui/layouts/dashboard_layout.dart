import 'package:biblioteca_front_02/routers/router.dart';
import 'package:biblioteca_front_02/services/navigation_service.dart';
import 'package:biblioteca_front_02/ui/shared/my_search_form_field.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;
  const DashboardLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return Overlay(
      initialEntries: [
        OverlayEntry(
            builder: (context) => Scaffold(
                  appBar:
                      AppBar(title: const Row(children: [MySearchFormField()])),
                  drawer: Drawer(
                      child: ListView(
                    children: [
                      const DrawerHeader(child: SizedBox(height: 32)),
                      ListTile(
                          title: Text('Inicio', style: style),
                          leading: const Icon(Icons.home_outlined),
                          onTap: () {
                            NavigationService.replaceTo(Flurorouter.rootRoute);
                          }),
                      ListTile(
                          title: Text('Disponibles', style: style),
                          leading: const Icon(Icons.book),
                          onTap: () {
                            NavigationService.replaceTo(
                                Flurorouter.obrasDisponiblesRoute);
                          }),
                      ListTile(
                          title: Text('Devueltos', style: style),
                          leading: const Icon(Icons.book_outlined),
                          onTap: () {
                            NavigationService.replaceTo(
                                Flurorouter.obrasDevueltasRoute);
                          }),
                      ListTile(
                          title: Text('Prestados', style: style),
                          leading: const Icon(Icons.menu_book),
                          onTap: () {
                            NavigationService.replaceTo(
                                Flurorouter.obrasPrestadasRoute);
                          }),
                    ],
                  )),
                  body: child,
                ))
      ],
    );
  }
}
