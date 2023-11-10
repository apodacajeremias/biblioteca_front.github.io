import 'package:biblioteca_front/providers/obra_provider.dart';
import 'package:biblioteca_front/ui/views/obra_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObraDisponibleView extends StatelessWidget {
  const ObraDisponibleView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ObraProvider>(context, listen: false);
    // return ObraView(titulo: 'Libros disponibles', onSearch: provider.buscarDisponibles, onFutureLoad: provider.disponibles);
    return const ObraView(type: ObraViewType.DISPONIBLES);
  }
}
