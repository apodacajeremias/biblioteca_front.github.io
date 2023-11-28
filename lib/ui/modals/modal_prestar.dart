import 'package:biblioteca_front/models/persona.dart';
import 'package:biblioteca_front/providers/persona_provider.dart';
import 'package:biblioteca_front/providers/prestamo_provider.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:biblioteca_front/ui/shared/my_title.dart';
import 'package:biblioteca_front/ui/views/persona_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../constants.dart';
import '../../services/notifications_service.dart';

class ModalPrestar extends StatelessWidget {
  final String idObra;
  const ModalPrestar({super.key, required this.idObra});

  @override
  Widget build(BuildContext context) {
    String idPersona = '';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text('Indique la persona',
              style: Theme.of(context).textTheme.titleLarge),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding / 2),
          child: SearchableDropdown<String>.paginated(
            backgroundDecoration: (child) => Card(
              margin: EdgeInsets.zero,
              // color: Colors.yellowAccent,
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
                  .map((e) => SearchableDropdownMenuItem(
                      value: e.id,
                      label: e.nombre ?? '',
                      child: Text(e.nombre ?? '')))
                  .toList();
            },
            requestItemCount: 100,
            onChanged: (String? value) {
              idPersona = value ?? '';
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
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: MyElevatedButton.cancelar(
                  onPressed: Navigator.of(context).pop),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: MyElevatedButton.confirmar(onPressed: () async {
                if (idObra.isNotEmpty && idPersona.isNotEmpty) {
                  try {
                    await Provider.of<PrestamoProvider>(context, listen: false)
                        .prestar(idObra, idPersona);
                    NotificationsService.showSnackbar(
                        'El prestamo se ha registrado.');
                  } on Exception catch (e) {
                    NotificationsService.showSnackbarError(
                        'No se ha registrado el prestamo.');
                    rethrow;
                  }
                } else if (idObra.isEmpty) {
                  NotificationsService.showSnackbarError(
                      'Debe seleccionar nuevamente la obra.');
                } else if (idPersona.isEmpty) {
                  NotificationsService.showSnackbarError(
                      'Debe indicar a la persona.');
                } else {
                  NotificationsService.showSnackbarError(
                      'Debe intentar nuevamente.');
                }
                Navigator.of(context).pop();
              }),
            ))
          ],
        )
      ],
    );
  }
}
