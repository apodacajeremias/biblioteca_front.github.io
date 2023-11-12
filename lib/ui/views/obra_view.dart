// ignore_for_file: constant_identifier_names

import 'package:biblioteca_front/constants.dart';
import 'package:biblioteca_front/models/obra.dart';
import 'package:biblioteca_front/providers/obra_provider.dart';
import 'package:biblioteca_front/providers/search_provider.dart';
import 'package:biblioteca_front/ui/modals/modal_prestar.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';

import 'package:biblioteca_front/ui/shared/my_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

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

  // const ObraView(
  //     {super.key,
  //     required this.titulo,
  //     required this.onSearch,
  //     required this.onFutureLoad});

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
      _fetchPage(
          pageKey);
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
    Provider.of<SearchProvider>(context);
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
                  itemBuilder: (context, item, index) => _ObraItem(
                    obra: item,
                    button: switch (widget.type) {
                      ObraViewType.DISPONIBLES => MyElevatedButton.prestar(onPressed:(){
                        showModalBottomSheet(isScrollControlled: true,
                          context: context, builder: (context) {
                        return const ModalPrestar();
                      });
                      }),
                      ObraViewType.DEVUELTOS => MyElevatedButton.prestar(onPressed: (){}),
                      ObraViewType.PRESTADOS => MyElevatedButton.devolver(onPressed: (){}),
                    }
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

class _ObraItem extends StatelessWidget {
  final Obra obra;
  final Widget button;

  const _ObraItem({required this.obra, required this.button});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        obra.nombre ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        obra.autor ?? '',
        style: Theme.of(context).textTheme.displaySmall,
      ),
      trailing: button,
      children: [
        if (obra.editorial != null) ...[
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Text(
              obra.editorial ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 12),
            ),
          ),
        ],
        if (obra.sinopsis != null) ...[
          Text(
            'Sinopsis:',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding / 2),
            child: Text(
              obra.sinopsis!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ]
      ],
    );
  }
}

class NoItemsFound extends StatelessWidget {
  final Function onReload;
  const NoItemsFound({super.key, required this.onReload});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        SvgPicture.asset(
          'Empty-amico.svg',
          height: defaultPadding * 15,
        ),
        Text('No se encontraron resultados.', style: theme.titleMedium),
        Text('Revisa tus filtros de búsqueda y vuelve a intentarlo.',
            style: theme.displaySmall),
        Text.rich(
          TextSpan(
            text: provider.query.isNotEmpty
                ? 'Sin coincidencias para '
                : 'Sin coincidencias.',
            style: theme.displaySmall!,
            children: [
              TextSpan(
                  text: provider.query,
                  style:
                      theme.displaySmall!.copyWith(fontStyle: FontStyle.italic))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: MyElevatedButton.mostrarTodo(onPressed: onReload),
        ),
      ],
    );
  }
}

class FirstPageError extends StatelessWidget {
  final Function onReload;
  const FirstPageError({super.key, required this.onReload});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        //  Revisa tu red e inténtalo de nuevo.
        SvgPicture.asset(
          'Questions-amico.svg',
          height: defaultPadding * 15,
        ),
        Text('Estamos teniendo problemas de conexión.',
            style: theme.titleMedium),
        Text('Revisa tu red e inténtalo de nuevo.', style: theme.displaySmall),
        Padding(
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: MyElevatedButton.reintentar(onPressed: onReload),
        ),
      ],
    );
  }
}

