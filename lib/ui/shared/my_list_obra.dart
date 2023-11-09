import 'package:biblioteca_front_02/models/obra.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ObraListView extends StatefulWidget {
  @override
  _ObraListViewState createState() => _ObraListViewState();
}

class _ObraListViewState extends State<ObraListView> {
  static const _pageSize = 20;

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
    try {
      final newItems = await RemoteApi.getBeerList(pageKey, _pageSize);
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
  Widget build(BuildContext context) => 
      // Don't worry about displaying progress or error indicators on screen; the 
      // package takes care of that. If you want to customize them, use the 
      // [PagedChildBuilderDelegate] properties.
      PagedListView<int, Obra>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Obra>(
          itemBuilder: (context, item, index) => BeerListItem(
            beer: item,
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}