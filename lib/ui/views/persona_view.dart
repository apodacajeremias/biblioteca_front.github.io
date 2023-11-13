// ignore_for_file: constant_identifier_names

import 'package:biblioteca_front/constants.dart';
import 'package:biblioteca_front/models/persona.dart';
import 'package:biblioteca_front/providers/persona_provider.dart';
import 'package:biblioteca_front/providers/search_provider.dart';
import 'package:biblioteca_front/ui/indicators/firsts_page_error.dart';
import 'package:biblioteca_front/ui/indicators/no_items_found.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';

import 'package:biblioteca_front/ui/shared/my_title.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import 'items/persona_item.dart';

class PersonaView extends StatefulWidget {
  const PersonaView({super.key});

  @override
  State<PersonaView> createState() => _PersonaViewState();
}

class _PersonaViewState extends State<PersonaView> {
  static const _pageSize = 100;

  final PagingController<int, Persona> _pagingController =
      PagingController(firstPageKey: 0);

  String? _searchTerm;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    int pageNumber = (pageKey / _pageSize) as int;
    try {
      final newItems =
          await Provider.of<PersonaProvider>(context, listen: false).buscar(
              page: pageNumber, size: _pageSize, query: _searchTerm ?? '');
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey as int?);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cada vez que se escriba algo en la barra de busqueda, la lista cambia
    _searchTerm = Provider.of<SearchProvider>(context).query;
    _pagingController.refresh();
    return Column(
      children: [
        const MyTitle(title: 'Personas disponibles'),
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: PagedListView<int, Persona>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Persona>(
                  itemBuilder: (context, item, index) =>
                      PersonaItem(persona: item),
                  noItemsFoundIndicatorBuilder: (context) {
                    return NoItemsFound(onReload: _pagingController.refresh);
                  },
                  firstPageErrorIndicatorBuilder: (context) {
                    return FirstPageError(onReload: _pagingController.refresh);
                  },
                ),
              )),
        ),
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: MyElevatedButton.cancelar(onPressed: () {}),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: MyElevatedButton.confirmar(onPressed: () {}),
            ))
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
