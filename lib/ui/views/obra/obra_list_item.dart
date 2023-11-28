import 'package:biblioteca_front/models/prestamo.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/obra.dart';
import '../../modals/modal_devolver.dart';
import '../../modals/modal_prestar.dart';

class ObraListItem extends StatelessWidget {
  final dynamic item;

  const ObraListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return _ListItem(item: item);
  }
}

class _ListItem extends StatelessWidget {
  final dynamic item;

  const _ListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(item, context),
      subtitle: _buildSubtitle(item, context),
      trailing: _buildTrailing(item, context),
    );
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
      subtitle: item.autores != null
          ? Text(
              item.autores!,
              style: Theme.of(context).textTheme.displaySmall,
            )
          : null,
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
        ],
        Text(
          'Area:',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: Text(
            item.area.name,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
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

Widget _buildTitle(final dynamic item, final BuildContext context) {
  final style = Theme.of(context).textTheme.bodyMedium;
  if (item is Obra) {
    final String subtitle = item.nombre;
    return Text(subtitle, style: style);
  } else if (item is Prestamo) {
    final String subtitle = item.existencia.obra.nombre;
    return Text(subtitle, style: style);
  } else {
    return Text('Haga click para mas informacion...', style: style);
  }
}

Widget? _buildSubtitle(final dynamic item, final BuildContext context) {
  final style = Theme.of(context).textTheme.displaySmall;
  if (item is Obra) {
    final String? subtitle = item.subtitulo ?? item.autores;
    return subtitle != null ? Text(subtitle, style: style) : null;
  } else if (item is Prestamo) {
    final String subtitle = item.persona.nombre;
    return Text(subtitle, style: style);
  }
  return null;
}

Widget? _buildTrailing(final dynamic item, final BuildContext context) {
  final style = Theme.of(context).textTheme.displaySmall;
  if (item is Obra) {
    if (item.activo && item.disponible) {
      return MyElevatedButton.prestar(onPressed: () async {
        await showModalBottomSheet(
            elevation: 1,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ModalPrestar(idObra: item.id);
            });
      });
    } else if (!item.activo) {
      return Text('Obra bloqueada.', style: style);
    } else if (!item.disponible) {
      return Text('Unidades no disponibles.', style: style);
    }
    return null;
  } else if (item is Prestamo) {
    if (item.activo) {
      return MyElevatedButton.devolver(onPressed: () async {
        await showModalBottomSheet(
            elevation: 1,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ModalDevolver(prestamo: item);
            });
      });
    }
  }
  return null;
}
