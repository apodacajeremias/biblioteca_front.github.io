import 'package:biblioteca_front/models/entrada.dart';
import 'package:biblioteca_front/providers/entrada_provider.dart';
import 'package:biblioteca_front/ui/shared/my_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../constants.dart';
import '../../models/persona.dart';
import '../../providers/persona_provider.dart';
import '../../providers/search_provider.dart';
import '../../services/notifications_service.dart';
import '../shared/my_elevated_button.dart';

class ModalEntrar extends StatelessWidget {
  const ModalEntrar({super.key});

  @override
  Widget build(BuildContext context) {
    String idPersona = '';
    String motivo = '';
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
        Expanded(
          child: TextFormField(
            minLines: 5,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) => motivo = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: MyOutlinedButton.cancelar(
                  onPressed: Navigator.of(context).pop),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: MyElevatedButton.confirmar(onPressed: () async {
                try {
                  final Entrada response =
                      await Provider.of<EntradaProvider>(context, listen: false)
                          .entrar(idPersona, motivo);
                  NotificationsService.showSnackbar(
                      'La entrada de ${response.persona.nombre} se ha registrado.');
                  if (context.mounted) {
                    Provider.of<SearchProvider>(context, listen: false)
                        .refresh();
                    Navigator.of(context).pop();
                  }
                } on Exception {
                  NotificationsService.showSnackbarError(
                      'No se ha registrado la entrada.');
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
