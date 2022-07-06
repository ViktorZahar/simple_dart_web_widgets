import 'dart:async';
import 'dart:html';

import 'abstract_component.dart';
import 'labels/simple_label.dart';
import 'mixins.dart';
import 'panel.dart';

class TabPanel extends PanelComponent implements UrlStateComponent<String> {
  TabPanel() : super('TabPanel') {
    vertical = true;
    add(tagsPanel);
  }

  final StreamController<TabTag> _onSelect =
      StreamController<TabTag>.broadcast();

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
    final _state = urlState;
    _onValueChange.add(ValueChangeEvent(_state, _state));
  }

  void dispose() {
    _onSelect.close();
    _onValueChange.close();
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
      add(_currentTag!.tabContent!);
      if (tabTag.lazyTabContent != null) {
        tabTag.lazyTabContent!.onShow();
      }
      fireOnSelect(tabTag);
    }
  }

  @override
  void clear() {
    tags.clear();
    tagsPanel.clear();
  }

  @override
  String get urlState {
    var res = currentTag.tabContent!.varName;
    if (res.isEmpty) {
      res = currentTag.caption;
    }
    return res;
  }

  @override
  set urlState(String newValue) {
    if (newValue.isEmpty) {
      if (tags.isNotEmpty) {
        currentTag = tags.first;
      }
      return;
    }
    final tabTag = tags.firstWhere((tag) {
      if (tag.tabContent == null || tag.tabContent!.varName.isEmpty) {
        return tag.caption == newValue;
      } else {
        return tag.tabContent!.varName == newValue;
      }
    }, orElse: () => tags.first);
    currentTag = tabTag;
  }

  final StreamController<ValueChangeEvent<String>> _onValueChange =
      StreamController<ValueChangeEvent<String>>.broadcast();

  @override
  Stream<ValueChangeEvent<String>> get onValueChange => _onValueChange.stream;
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
