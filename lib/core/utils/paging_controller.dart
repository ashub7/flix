import 'package:flix/core/extension/logger_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PagingController<T> {
  final List<T> _items = [];
  bool hasNextPage = true, isLoading = false;
  void Function()? pageRequestListener;
  void Function(int)? pageTopOffsetListener;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  int itemCount =0;

  PagingController({
    this.pageRequestListener,
    this.pageTopOffsetListener
  }) {
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if(positions.last.index == itemCount-1){
        pageRequestListener?.call();
      }
      if(positions.first.index ==0){
        logger.d("call previous");
      }
      pageTopOffsetListener?.call(positions.first.index);
      //logger.e("${positions.first.index} and ${_items.length}");
     /* if(positions.first.index == 10) {
        pageTopOffsetListener?.call();
      }
      if(positions.first.index < 10) {
        pageTopOffsetListener?.call();
      }*/
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
  }
}
