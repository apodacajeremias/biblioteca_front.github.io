import 'package:flutter/material.dart';

import '../../../models/persona.dart';

class PersonaItem extends StatefulWidget {
  final Persona persona;

  const PersonaItem({super.key, required this.persona});

  @override
  State<PersonaItem> createState() => _PersonaItemState();
}

class _PersonaItemState extends State<PersonaItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.persona.nombre ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Icon(
          selected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
    );
  }
}
