import 'package:biblioteca_front/models/existencia.dart';
import 'package:biblioteca_front/models/persona.dart';
import 'package:biblioteca_front/providers/obra_provider.dart';
import 'package:biblioteca_front/providers/persona_provider.dart';
import 'package:biblioteca_front/providers/prestamo_provider.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../constants.dart';
import '../../models/obra.dart';
import '../../providers/search_provider.dart';
import '../../services/notifications_service.dart';
import '../shared/my_outlined_button.dart';

class ModalPrestar extends StatelessWidget {
  final Obra obra;

  const ModalPrestar({super.key, required this.obra});

  @override
  Widget build(BuildContext context) {
    String idPersona = '';
    String idExistencia = '';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text('Prestar', style: Theme.of(context).textTheme.titleLarge),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding / 2),
          child: SearchableDropdown<String>.paginated(
            backgroundDecoration: (child) => Card(
              margin: EdgeInsets.zero,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
            changeCompletionDelay: const Duration(seconds: 1),
            hintText: const Text('Personas disponibles'),
            searchHintText: 'Busque por nombre',
            margin: const EdgeInsets.all(15),
            paginatedRequest: (int page, String? searchKey) async {
              final List<Persona> paginatedList =
                  await Provider.of<PersonaProvider>(context, listen: false)
                      .buscar(page: page - 1, query: searchKey ?? '');
              return paginatedList
                  .map((p) => SearchableDropdownMenuItem(
                      value: p.id,
                      label: p.nombre,
                      child: ListTile(
                        title: Text(p.nombre),
                        subtitle: Text(p.documentoIdentidad),
                      )))
                  .toList();
            },
            requestItemCount: 100,
            onChanged: (String? value) {
              idPersona = value ?? '';
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text('Seleccione la unidad',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding / 2),
          child: SearchableDropdown<String>.future(
            backgroundDecoration: (child) => Card(
              margin: EdgeInsets.zero,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
            changeCompletionDelay: const Duration(seconds: 1),
            hintText: const Text('Unidades disponibles'),
            searchHintText: 'Busque por codigo',
            margin: const EdgeInsets.all(15),
            futureRequest: () async {
              final List<Existencia> paginatedList =
                  await Provider.of<ObraProvider>(context, listen: false)
                      .buscarExistencias(obra.id);
              return paginatedList
                  .map((p) => SearchableDropdownMenuItem(
                      value: p.id,
                      label: p.id,
                      child: ListTile(
                        title: Text(p.id),
                        subtitle: Text(p.nombre),
                      )))
                  .toList();
            },
            onChanged: (String? value) {
              idExistencia = value ?? '';
            },
          ),
        ),
        Expanded(
            child: Center(
          child: SvgPicture.asset(
            'Research-amico.svg',
            height: defaultPadding * 15,
          ),
        )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 4),
              child: MyOutlinedButton.cancelar(
                  onPressed: Navigator.of(context).pop),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 4),
              child: MyElevatedButton.confirmar(onPressed: () async {
                if (idExistencia.isNotEmpty && idPersona.isNotEmpty) {
                  try {
                    await Provider.of<PrestamoProvider>(context, listen: false)
                        .prestar(idExistencia, idPersona);
                    if (context.mounted) {
                      Provider.of<SearchProvider>(context, listen: false)
                          .refresh();
                      Navigator.of(context).pop();
                    }
                    NotificationsService.showSnackbar(
                        'El prestamo se ha registrado.');
                  } on Exception {
                    NotificationsService.showSnackbarError(
                        'No se ha registrado el prestamo.');
                    rethrow;
                  }
                } else if (idExistencia.isEmpty) {
                  NotificationsService.showSnackbarError(
                      'Debe seleccionar la unidad que va a prestar.');
                } else if (idPersona.isEmpty) {
                  NotificationsService.showSnackbarError(
                      'Debe indicar a la persona.');
                } else {
                  NotificationsService.showSnackbarError(
                      'Debe intentar nuevamente.');
                  if (context.mounted) {
                    Provider.of<SearchProvider>(context, listen: false).query ==
                        '';
                    Navigator.of(context).pop();
                  }
                }
              }),
            ))
          ],
        )
      ],
    );
  }
}
