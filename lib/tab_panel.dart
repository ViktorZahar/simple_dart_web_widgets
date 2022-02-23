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

  Panel tagsPanel = Panel()..addCssClass('TabTagsPanel');
  List<TabTag> tags = <TabTag>[];
  TabTag? _currentTag;

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

  TabTag get currentTag => _currentTag!;

  set currentTag(TabTag tabTag) {
    if (_currentTag != tabTag) {
      if (_currentTag != null) {
        _currentTag!.active = false;
        removeComponent(_currentTag!.tabContent!);
      }
      _currentTag = tabTag..fireOnSelect();
      _currentTag!.active = true;
      add(_currentTag!.tabContent!);
    }
  }
}

class TabTag extends SimpleLabel with MixinActivate {
  TabTag() {
    addCssClass('TabTag');
  }

  Component? tabContent;

  List<Function()> onSelectListeners = <Function()>[];

  void onSelect(Function() listener) {
    onSelectListeners.add(listener);
  }

  void fireOnSelect() {
    for (final listener in onSelectListeners) {
      listener();
    }
  }

  @override
  List<Element> get activate => [nodeRoot];
}
