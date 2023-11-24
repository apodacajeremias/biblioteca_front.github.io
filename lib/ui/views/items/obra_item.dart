import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/obra.dart';

class ObraItem extends StatelessWidget {
  final Obra obra;
  final Widget trailing;

  const ObraItem({super.key, required this.obra, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        obra.nombre ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        obra.autores.first ?? '',
        style: Theme.of(context).textTheme.displaySmall,
      ),
      trailing: trailing,
      children: [
        if (obra.empresaResponsable != null) ...[
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Text(
              obra.empresaResponsable ?? '',
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
