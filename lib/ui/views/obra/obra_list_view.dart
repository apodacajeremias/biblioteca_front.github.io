// ignore_for_file: constant_identifier_names

import 'package:biblioteca_front/constants.dart';
import 'package:biblioteca_front/providers/obra_provider.dart';
import 'package:biblioteca_front/providers/search_provider.dart';

import 'package:biblioteca_front/ui/shared/my_title.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../indicators/firsts_page_error.dart';
import '../../indicators/no_items_found.dart';
import 'obra_list_item.dart';

enum ObraViewType {
  DISPONIBLES('/obras?disponible=true', 'Libros disponibles'),
  DEVUELTOS('/prestamos?activo=false', 'Libros devueltos'),
  PRESTADOS('/prestamos?activo=true', 'Libros prestados');

// URL para buscar la lista segun modalidad
  final String source;
  final String title;
  const ObraViewType(this.source, this.title);
}

class ObraListView extends StatefulWidget {
  final ObraViewType type;

  const ObraListView(this.type, {super.key});

  @override
  State<ObraListView> createState() => _ObraListViewState();
}

class _ObraListViewState extends State<ObraListView> {
  static const _pageSize = 100;

// Es dynamic porque puede ser Obra o Prestamo
  final PagingController<int, dynamic> _pagingController =
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
      final newItems = await Provider.of<ObraProvider>(context, listen: false)
          .buscar(widget.type, page: pageNumber, query: _searchTerm ?? '');
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
        MyTitle(title: widget.type.title),
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: PagedListView<int, dynamic>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, item, index) => ObraListItem(
                    item: item,
                  ),
                  noItemsFoundIndicatorBuilder: (context) {
                    return NoItemsFound(onReload: _pagingController.refresh);
                  },
                  firstPageErrorIndicatorBuilder: (context) {
                    return FirstPageError(onReload: _pagingController.refresh);
                  },
                ),
              )),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
