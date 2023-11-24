import 'package:biblioteca_front/models/prestamo.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/obra.dart';
import '../../modals/modal_prestar.dart';

class ObraItem extends StatelessWidget {
  final dynamic item;

  const ObraItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    if (item is Obra) {
      return _IsObra(item: item);
    } else if (item is Prestamo) {
      return _IsPrestamo(item: item);
    } else {
      return const Placeholder();
    }
  }
}

class _IsObra extends StatelessWidget {
  final Obra item;
  const _IsObra({required this.item});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        item.nombre,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        item.autores,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      trailing: MyElevatedButton.prestar(onPressed: () async {
        await showModalBottomSheet(
            elevation: 1,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ModalPrestar(idObra: item.id);
            });
      }),
      children: [
        if (item.empresaResponsable != null) ...[
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Text(
              item.empresaResponsable!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 12),
            ),
          ),
        ],
        if (item.sinopsis != null) ...[
          Text(
            'Sinopsis:',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Text(
              item.sinopsis!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ]
      ],
    );
  }
}

class _IsPrestamo extends StatelessWidget {
  final Prestamo item;
  const _IsPrestamo({required this.item});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        item.existencia.obra.nombre,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        item.persona.nombre,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      trailing: (item.activo) ? const Text('activo') : const Text('inactivo'),
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: Text(
            item.existencia.id,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
