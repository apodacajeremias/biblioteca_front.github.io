import 'package:biblioteca_front/models/prestamo.dart';
import 'package:biblioteca_front/ui/modals/modal_enviar.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      children: _buildTileContent(item, context),
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
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        const SizedBox(width: double.infinity),
        if (subtitle != null) Text(subtitle, style: style),
        if (item.fisico) ...{
          Text('Disponible: ${item.cantidadDisponible}', style: style),
        } else ...{
          Text('Digital', style: style),
        }
      ],
    );
  } else if (item is Prestamo) {
    final String subtitle = item.persona.nombre;
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        const SizedBox(width: double.infinity),
        Text(subtitle, style: style),
        Text(
            '${DateFormat.yMMMMd('es').format(item.fechaCreacion)} ${DateFormat.jms('es').format(item.fechaCreacion)}',
            style: style),
      ],
    );
  }
  return null;
}

Widget? _buildTrailing(final dynamic item, final BuildContext context) {
  final style = Theme.of(context).textTheme.displaySmall;
  if (item is Obra) {
    if (item.activo && item.disponible && item.fisico) {
      return MyElevatedButton.prestar(onPressed: () async {
        await showModalBottomSheet(
            elevation: 1,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ModalPrestar(obra: item);
            });
      });
    } else if (!item.activo) {
      return Text('Obra bloqueada.', style: style);
    } else if (!item.fisico) {
      return MyElevatedButton.enviar(onPressed: () async {
        await showModalBottomSheet(
            elevation: 1,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ModalEnviar(obra: item);
            });
      });
    } else if (!item.disponible) {
      return Text('No disponible.', style: style);
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
              return ModalDevolver(item: item);
            });
      });
    }
  }
  return null;
}

List<Widget> _buildTileContent(final dynamic item, final BuildContext context) {
  if (item is Obra) {
    return [
      if (item.sinopsis != null) ...{
        _subtitleText('Sinopsis', context),
        _contentText(item.sinopsis!, context),
      },
      if (item.autores != null)
        _subtitleText(item.autores!, context, icon: Icons.group),
      if (item.empresaResponsable != null)
        _subtitleText(item.empresaResponsable!, context, icon: Icons.home_work),
    ];
  } else if (item is Prestamo) {
    return [
      if (item.existencia.obra.sinopsis != null) ...{
        _subtitleText('Sinopsis', context, icon: Icons.info),
        _contentText(item.existencia.obra.sinopsis!, context),
      },
      if (item.existencia.obra.autores != null)
        _subtitleText(item.existencia.obra.autores!, context,
            icon: Icons.group),
      if (item.existencia.obra.empresaResponsable != null)
        _subtitleText(item.existencia.obra.empresaResponsable!, context,
            icon: Icons.home_work),
      if (item.fechaHoraDevolucion != null) ...{
        _subtitleText('Fecha de devolucion', context, icon: Icons.schedule),
        _contentText(
            '${DateFormat.yMMMMd('es').format(item.fechaHoraDevolucion!)} ${DateFormat.jms('es').format(item.fechaHoraDevolucion!)}',
            context),
      } else ...{
        _subtitleText('Devolucion no efectuada.', context, icon: Icons.warning),
        _contentText('Presione el boton Devolver para efectuar.', context),
      }
    ];
  } else {
    return [];
  }
}

Widget _subtitleText(final String text, final BuildContext context,
    {final IconData? icon}) {
  return Padding(
    padding: const EdgeInsets.all(defaultPadding / 4),
    child: (icon != null)
        ? Row(
            children: [
              Icon(icon),
              const SizedBox(width: defaultPadding / 4),
              Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500))
            ],
          )
        : Text(
            text,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
  );
}

Widget _contentText(final String text, final BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(defaultPadding / 2),
    child: Text(
      text,
      style: Theme.of(context).textTheme.displaySmall,
    ),
  );
}
