import 'dart:async';

import '../buttons.dart';
import '../labels/simple_label.dart';
import '../panel.dart';
import 'object_table.dart';
import 'repository.dart';

class RepositoryTable<T> extends ObjectTable<T> {
  RepositoryTable(
      this.repository, ObjectTableRowAdapter<T> objectTableRowAdapter)
      : super(objectTableRowAdapter) {
    addCssClass('RepositoryTable');
    copyButton.onClick.listen((event) {
      copyToClipboard();
    });
    scrollablePanel.nodeRoot.onScroll.listen((event) {
      final scrollableNodeRoot = scrollablePanel.nodeRoot;
      if (scrollableNodeRoot.scrollTop + scrollableNodeRoot.offsetHeight >=
          scrollableNodeRoot.scrollHeight) {
        loadMore();
      }
    });
    headerPanel.addAll([headerLabel, copyButton]);
    insert(0, headerPanel);
    loadMore();
  }

  late Repository<T> repository;

  final StreamController<bool> _onLoadMore = StreamController<bool>();

  Stream<bool> get onLoadMore => _onLoadMore.stream;

  Panel headerPanel = Panel()
    ..fullWidth()
    ..addCssClass('RepositoryTableHeaderPanel');

  SimpleLabel headerLabel = SimpleLabel()
    ..addCssClass('RepositoryTableHeaderLabel')
    ..fillContent = true;
  SimpleButton copyButton = SimpleButton()
    ..caption = 'copy'
    ..setCssClass('TableCopyButton');

  Future<void> loadMore() async {
    final moreObjects = await repository.loadMore();
    moreObjects.forEach(createObjectRow);
    _onLoadMore.add(moreObjects.isNotEmpty);
  }

  @override
  void destroy() {
    super.destroy();
    _onLoadMore.close();
  }
}
