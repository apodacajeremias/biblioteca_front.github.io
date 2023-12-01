import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/prestamo.dart';
import '../../providers/prestamo_provider.dart';
import '../../providers/search_provider.dart';
import '../../services/notifications_service.dart';
import '../shared/my_elevated_button.dart';

class ModalDevolver extends StatelessWidget {
  final Prestamo item;
  const ModalDevolver({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final large = Theme.of(context).textTheme.titleLarge;
    final medium = Theme.of(context).textTheme.bodyMedium;
    final small = Theme.of(context).textTheme.displaySmall;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: Text('Devolver', style: large),
        ),

        ///
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 4),
          child: Text('Persona', style: small),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 4),
          child: Text(item.persona.nombre, style: medium),
        ),

        ///
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 4),
          child: Text('Obra', style: small),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 4),
          child: Text(item.existencia.obra.nombre, style: medium),
        ),

        ///
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 4),
          child: Text('Codigo Unitario', style: small),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 4),
          child: Text(item.existencia.id, style: medium),
        ),

        ///
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 4),
          child: Text('Fecha de prestamo', style: small),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 4),
          child: Text(
              '${DateFormat.yMMMMd('es').format(item.fechaCreacion)} ${DateFormat.jms('es').format(item.fechaCreacion)}',
              style: medium),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: MyElevatedButton.cancelar(
                  onPressed: Navigator.of(context).pop),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: MyElevatedButton.confirmar(onPressed: () async {
                try {
                  await Provider.of<PrestamoProvider>(context, listen: false)
                      .devolver(item.id);
                  if (context.mounted) {
                    Provider.of<SearchProvider>(context, listen: false)
                        .refresh();
                    Navigator.of(context).pop();
                  }
                  NotificationsService.showSnackbar(
                      'La obra ha sido devuelta con exito.');
                } on Exception {
                  NotificationsService.showSnackbarError(
                      'No se ha procesado la devolucion.');
                  rethrow;
                }
              }),
            ))
          ],
        )
      ],
    );
  }
}
