
import 'package:biblioteca_front/models/persona.dart';
import 'package:biblioteca_front/providers/persona_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';


class MyDropdownSearch extends StatelessWidget {
  const MyDropdownSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonaProvider>(context, listen: false);
    return SearchableDropdown<Persona>.paginated(
    hintText: const Text('Paginated request'),
    margin: const EdgeInsets.all(15),
    paginatedRequest: (int page, String? searchKey) async {
      debugPrint('page $page');
      debugPrint('searchKey $searchKey');
        final paginatedList = await provider.buscar(page: page, query:searchKey ?? '');
        return paginatedList
            ?.map((e) => SearchableDropdownMenuItem(value: e.id, label: e.nombre ?? '', child: Text(e.nombre ?? '')))
            .toList();
        // return [];
    },
    requestItemCount: 100,
    onChanged: (Persona? value) {
        debugPrint('$value');
    },
);
  }
}

