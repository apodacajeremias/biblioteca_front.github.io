import 'package:biblioteca_front/ui/views/persona_list_view.dart';
import 'package:flutter/material.dart';

class ModalPrestar extends StatelessWidget {
  const ModalPrestar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Seleccione la persona que va a prestar', style: Theme.of(context).textTheme.bodyMedium),
      MyDropdownSearch()
    ],);
  }
}