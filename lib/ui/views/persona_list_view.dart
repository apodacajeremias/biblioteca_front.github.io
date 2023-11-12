// ignore_for_file: library_private_types_in_public_api

import 'package:biblioteca_front/providers/persona_provider.dart';
import 'package:biblioteca_front/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../models/persona.dart';

class PersonaListView extends StatefulWidget {
  const PersonaListView({super.key});

  @override
  _PersonaListViewState createState() => _PersonaListViewState();
}

class _PersonaListViewState extends State<PersonaListView> {
  static const _pageSize = 17;

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

  Future<void> _fetchPage(pageKey) async {
    int pageNumber = (pageKey / _pageSize) as int;
    try {
      final newItems = await await Provider.of<PersonaProvider>(context, listen: false)
          .buscar(
              page: pageNumber, size: _pageSize, query: _searchTerm ?? '');

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) { 
    Provider.of<SearchProvider>(context).onChanged;
    return
      CustomScrollView(
        slivers: <Widget>[
          BeerSearchInputSliver(
            onChanged: _updateSearchTerm,
          ),
          PagedSliverList<int, Persona>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Persona>(
              itemBuilder: (context, item, index) => BeerListItem(
                beer: item,
              ),
            ),
          ),
        ],
      );
}
  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}