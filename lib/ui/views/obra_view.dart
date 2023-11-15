// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

import 'package:biblioteca_front/constants.dart';
import 'package:biblioteca_front/models/obra.dart';
import 'package:biblioteca_front/providers/obra_provider.dart';
import 'package:biblioteca_front/providers/search_provider.dart';
import 'package:biblioteca_front/ui/modals/modal_prestar.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';

import 'package:biblioteca_front/ui/shared/my_title.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../providers/prestamo_provider.dart';
import '../../services/notifications_service.dart';
import '../indicators/firsts_page_error.dart';
import '../indicators/no_items_found.dart';
import 'items/obra_item.dart';

enum ObraViewType {
  DISPONIBLES('/obras/disponibles', 'Libros disponibles'),
  DEVUELTOS('/obras/devueltos', 'Libros devueltos'),
  PRESTADOS('/obras/prestados', 'Libros prestados');

// URL para buscar la lista segun modalidad
  final String source;
  final String titulo;
  const ObraViewType(this.source, this.titulo);
}

class ObraView extends StatefulWidget {
  final ObraViewType type;

  const ObraView(this.type, {super.key});

  @override
  State<ObraView> createState() => _ObraViewState();
}

class _ObraViewState extends State<ObraView> {
  static const _pageSize = 100;

  final PagingController<int, Obra> _pagingController =
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
          .buscar(widget.type.source,
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
        MyTitle(title: widget.type.titulo),
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: PagedListView<int, Obra>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Obra>(
                  itemBuilder: (context, item, index) => ObraItem(
                      obra: item,
                      trailing: switch (widget.type) {
                        ObraViewType.DISPONIBLES =>
                          MyElevatedButton.prestar(onPressed: () async {
                            await showModalBottomSheet(
                                elevation: 1,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return ModalPrestar(idObra: item.id!);
                                });
                            
                          }),
                        ObraViewType.DEVUELTOS => Text(DateFormat('dd/MM/yyyy').format(DateTime.now())),
                        ObraViewType.PRESTADOS =>
                          MyElevatedButton.devolver(onPressed: () async {
                            try {
                              await Provider.of<PrestamoProvider>(context,
                                      listen: false)
                                  .devolver(item.id!);
                              NotificationsService.showSnackbar(
                                  'Se ha procesado la devolucion.');
                              _pagingController.refresh();
                            } on Exception catch (e) {
                              NotificationsService.showSnackbarError(
                                  'No se ha registrado la devolucion.');
                              rethrow;
                            }
                          }),
                      }),
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
