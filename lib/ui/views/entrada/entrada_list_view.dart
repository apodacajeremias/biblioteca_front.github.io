// ignore_for_file: constant_identifier_names

import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/entrada.dart';
import '../../../providers/entrada_provider.dart';
import '../../../providers/search_provider.dart';
import '../../indicators/firsts_page_error.dart';
import '../../indicators/no_items_found.dart';
import '../../modals/modal_entrar.dart';
import '../../shared/my_title.dart';
import 'entrada_list_item.dart';

class EntradaListView extends StatefulWidget {
  const EntradaListView({super.key});

  @override
  State<EntradaListView> createState() => _EntradaListViewState();
}

class _EntradaListViewState extends State<EntradaListView> {
  static const _pageSize = 100;

  final PagingController<int, Entrada> _pagingController =
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
          await Provider.of<EntradaProvider>(context, listen: false)
              .buscar(page: pageNumber, query: _searchTerm ?? '');
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
        const MyTitle(title: 'Registro de entradas'),
        MyElevatedButton.entrar(onPressed: () async {
          await showModalBottomSheet(
              elevation: 1,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const ModalEntrar();
              });
        }),
        Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                child: PagedListView<int, Entrada>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Entrada>(
                      itemBuilder: (context, item, index) => EntradaListItem(
                        item: item,
                      ),
                      noItemsFoundIndicatorBuilder: (context) {
                        return NoItemsFound(
                            onReload: _pagingController.refresh);
                      },
                      firstPageErrorIndicatorBuilder: (context) {
                        return FirstPageError(
                            onReload: _pagingController.refresh);
                      },
                    ))))
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
