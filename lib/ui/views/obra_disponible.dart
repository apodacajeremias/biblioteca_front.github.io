import 'package:biblioteca_front_02/providers/obra_provider.dart';
import 'package:biblioteca_front_02/ui/views/obra_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObraDisponibleView extends StatelessWidget {
  const ObraDisponibleView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ObraProvider>(context, listen: false);
    // return ObraView(titulo: 'Libros disponibles', onSearch: provider.buscarDisponibles, onFutureLoad: provider.disponibles);
    return ObraView(titulo: 'Libros disponibles', onSearch: (value){}, onFutureLoad: provider.buscar);
  }
}
