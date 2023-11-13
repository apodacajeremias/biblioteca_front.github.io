import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/obra.dart';

class ObraItem extends StatelessWidget {
  final Obra obra;
  final Widget button;

  const ObraItem({super.key, required this.obra, required this.button});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        obra.nombre ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        obra.autor ?? '',
        style: Theme.of(context).textTheme.displaySmall,
      ),
      trailing: button,
      children: [
        if (obra.editorial != null) ...[
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Text(
              obra.editorial ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 12),
            ),
          ),
        ],
        if (obra.sinopsis != null) ...[
          Text(
            'Sinopsis:',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Text(
              obra.sinopsis!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ]
      ],
    );
  }
}
