import 'package:flutter/material.dart';

class PagingController<T> {
  final List<T> _items = [];
  final ScrollController scrollController;
  bool hasNextPage = true, isLoading = false;
  void Function()? pageRequestListener;

  PagingController({
    required this.scrollController,
    this.pageRequestListener
  }) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!isLoading && hasNextPage) {
          isLoading = !isLoading;
          pageRequestListener?.call();
        }
      }
    });
  }

  List<T> get itemList => _items;

  bool isEmpty() => _items.isEmpty;

  int itemsLength() => _items.length;

  T itemAt(int index) => _items[index];

  addNextPageItems(List<T> pageItems) {
    isLoading = false;
    _items.addAll(pageItems);
  }

  bool removeItem(T item) {
    return _items.remove(item);
  }

  addItemAtIndex(T item, int index) {
    if (_items.contains(item)) return;
    _items.insert(index, item);
  }

  updateItem(T item) {
    int index = _items.indexWhere((element) => element == item);
    if (index >= 0 && index < _items.length) {
      _items[index] = item;
    }
  }

  setPageRequestListener(Function() listener) {
    this.pageRequestListener = listener;
  }

  dispose() {
    _items.clear();
    scrollController.dispose();
  }
}
