import 'dart:async';
import 'dart:html';

import 'abstract_component.dart';
import 'labels/simple_label.dart';
import 'mixins.dart';
import 'panel.dart';

class TabPanel extends PanelComponent {
  TabPanel() : super('TabPanel') {
    vertical = true;
    add(tagsPanel);
  }

  final StreamController<TabTag> _onSelect = StreamController<TabTag>();

  Stream<TabTag> get onSelect => _onSelect.stream;

  Panel tagsPanel = Panel()
    ..addCssClass('TabTagsPanel')
    ..stride = '1px'
    ..wrap = true;
  List<TabTag> tags = <TabTag>[];
  TabTag? _currentTag;
  Panel contentPanel = Panel()
    ..addCssClass('TabContentPanel')
    ..fullSize()
    ..vertical = true
    ..fillContent = true;

  void fireOnSelect(TabTag tabTag) {
    _onSelect.add(tabTag);
  }

  void destroy() {
    _onSelect.close();
  }

  TabTag addTab(String caption, Component tabComponent) {
    final newTabTag = TabTag()
      ..caption = caption
      ..tabContent = tabComponent;
    tagsPanel.add(newTabTag);
    tags.add(newTabTag);
    newTabTag.nodeRoot.onClick.listen((event) {
      currentTag = newTabTag;
    });
    return newTabTag;
  }

  TabTag addLazyTab(String caption, LazyTabComponent lazyTabComponent) {
    final newTabTag = TabTag()
      ..caption = caption
      ..tabContent = lazyTabComponent
      ..lazyTabContent = lazyTabComponent;
    tagsPanel.add(newTabTag);
    tags.add(newTabTag);
    newTabTag.nodeRoot.onClick.listen((event) {
      currentTag = newTabTag;
    });
    return newTabTag;
  }

  TabTag get currentTag => _currentTag!;

  set currentTag(TabTag tabTag) {
    if (_currentTag != tabTag) {
      if (_currentTag != null) {
        _currentTag!.active = false;
        removeComponent(_currentTag!.tabContent!);
      }
      _currentTag = tabTag;
      _currentTag!.active = true;
      fireOnSelect(tabTag);
      if (tabTag.lazyTabContent != null) {
        tabTag.lazyTabContent!.onShow();
      }

      add(_currentTag!.tabContent!);
    }
  }

  @override
  void clear() {
    tags.clear();
    tagsPanel.clear();
  }
}

class TabTag extends SimpleLabel with MixinActivate {
  TabTag() {
    addCssClass('TabTag');
  }

  Component? tabContent;
  LazyTabComponent? lazyTabContent;

  @override
  List<Element> get activate => [nodeRoot];
}

class LazyTabComponent extends PanelComponent {
  LazyTabComponent() : super('LazyTabComponent') {
    fullSize();
    vertical = true;
    fillContent = true;
  }

  Future<void> onShow() async {}
}
