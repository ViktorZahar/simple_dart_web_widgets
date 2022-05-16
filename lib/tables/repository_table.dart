import 'dart:async';

import '../buttons.dart';
import '../labels/simple_label.dart';
import '../load_indicator.dart';
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
  }

  late Repository<T> repository;

  final StreamController<bool> _onLoadMore = StreamController<bool>();

  LoadIndicator loadIndicator = LoadIndicator();

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
    loadIndicator.show(this);
    final moreObjects = await repository.loadMore();
    moreObjects.forEach(createObjectRow);
    _onLoadMore.add(moreObjects.isNotEmpty);
    loadIndicator.hide();
  }

  @override
  void destroy() {
    super.destroy();
    _onLoadMore.close();
  }
}
