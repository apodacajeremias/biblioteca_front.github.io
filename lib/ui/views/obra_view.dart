import 'package:biblioteca_front/constants.dart';
import 'package:biblioteca_front/models/obra.dart';
import 'package:biblioteca_front/providers/obra_provider.dart';
import 'package:biblioteca_front/providers/search_provider.dart';
import 'package:biblioteca_front/ui/shared/my_elevated_button.dart';
import 'package:biblioteca_front/ui/shared/my_view_title.dart';
import 'package:biblioteca_front/ui/views/obra_list_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ObraView extends StatefulWidget {
  final String titulo;
  final Function(String) onSearch;
  final Future Function() onFutureLoad;

  const ObraView(
      {super.key,
      required this.titulo,
      required this.onSearch,
      required this.onFutureLoad});

  @override
  State<ObraView> createState() => _ObraViewState();
}

class _ObraViewState extends State<ObraView> {
  static const _pageSize = 100;

  final PagingController<int, Obra> _pagingController =
      PagingController(firstPageKey: 0);

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
      final newItems = await Provider.of<ObraProvider>(context, listen: false).buscar(page: pageNumber, size: _pageSize);
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
    Provider.of<SearchProvider>(context);
    
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: PagedListView<int, Obra>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Obra>(
            itemBuilder: (context, item, index) => _ObraItem(
              obra: item,
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class _ObraItem extends StatelessWidget {
  final Obra obra;

  const _ObraItem({required this.obra});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(obra.nombre ?? ''),
        subtitle: Text(obra.autor ?? ''),
        trailing: MyElevatedButton.done(onPressed: () {}));
  }
}
