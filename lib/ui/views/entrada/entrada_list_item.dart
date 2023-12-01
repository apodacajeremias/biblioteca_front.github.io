import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:biblioteca_front/ui/shared/my_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/entrada.dart';
import '../../../providers/entrada_provider.dart';
import '../../../services/notifications_service.dart';

class EntradaListItem extends StatelessWidget {
  final Entrada item;
  const EntradaListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(item.persona.nombre),
      subtitle: Text(item.fechaCreacion.toIso8601String()),
      trailing: _buildTrailing(item, context),
    );
  }
}

Widget _buildTrailing(Entrada entrada, BuildContext context) {
  if (entrada.activo) {
    return MyElevatedButton.salir(onPressed: () async {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              title: _subtitleText('Por favor, confirme', context),
              content: _contentText(
                  'Marcar salida de ${entrada.persona.nombre}', context),
              actions: [
                MyOutlinedButton.cancelar(onPressed: () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }),
                MyElevatedButton.confirmar(onPressed: () async {
                  try {
                    await Provider.of<EntradaProvider>(context, listen: false)
                        .salir(entrada.id);
                    NotificationsService.showSnackbar(
                        'La salida se ha registrado.');
                  } on Exception {
                    NotificationsService.showSnackbarError(
                        'La salida no se ha registrado.');
                  }
                })
              ],
            );
          });
    });
  } else {
    if(entrada.fechaHoraSalida != null){
    return _subtitleText(entrada.fechaHoraSalida!.toIso8601String(), context);
    } else {
      return _subtitleText('Sin registro devolucion.', context, icon: Icons.warning);
    }

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
