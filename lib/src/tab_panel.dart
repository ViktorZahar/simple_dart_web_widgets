import 'package:simple_dart_web_widgets/src/panels.dart';
import 'package:simple_dart_web_widgets/widgets.dart';

class TabPanel extends HVPanel {
  TabPanel() {
    dartClassName('TabPanel');
    vertical();
    add(tagsPanel);
  }

  HVPanel tagsPanel = HVPanel()
    ..varName('tagsPanel')
    ..height = '30px';
  List<TabTag> tags = <TabTag>[];
  TabTag _currentTag;

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

  TabTag get currentTag => _currentTag;

  set currentTag(TabTag tabTag) {
    if (_currentTag != tabTag) {
      if (_currentTag != null) {
        _currentTag
          ..clearClasses()
          ..addCssClasses([WidgetsTheme.tabTag]);
        remove(_currentTag.tabContent);
      }
      _currentTag = tabTag
        ..clearClasses()
        ..addCssClasses([WidgetsTheme.tabTagCurrent])
        ..fireOnSelect();
      add(_currentTag.tabContent);
    }
  }
}

class TabTag extends SimpleLabel {
  TabTag() {
    dartClassName('TabTag');
    clearClasses();
    addCssClasses([WidgetsTheme.tabTag]);
  }
  Component tabContent;
  List<Function()> onSelectListeners = <Function()>[];

  void onSelect(listener()) {
    onSelectListeners.add(listener);
  }

  void fireOnSelect() {
    for (var listener in onSelectListeners) {
      listener();
    }
  }
}
