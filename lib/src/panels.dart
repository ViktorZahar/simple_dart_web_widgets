import 'dart:html';

import '../widgets.dart';

class HVPanel extends Component implements Composite {
  HVPanel() {
    nodeRoot.style
      ..display = 'flex'
      ..flexShrink = '0'
      ..flexGrow = '0'
      ..flexDirection = 'row';
    dartClassName('HVPanel');
    fullWidth();
  }

  HVPanel.addLabelToComponent(String caption, Component comp) {
    final label = SimpleLabel()
      ..caption = caption
      ..width = '50%';
    addAll([label, comp]);
  }

  SimpleImage? loadIndicator;

  @override
  DivElement nodeRoot = DivElement();

  DivElement? headerLabel;
  @override
  List<Component> children = [];
  int _spaceBetweenItems = 0;
  bool _vertical = false;
  bool _scrollable = false;
  String _header = '';
  String _align = '';

  @override
  void add(Component component) {
    children.add(component);
    nodeRoot.children.add(component.nodeRoot);
    setSpaceBetweenItems(_spaceBetweenItems);
  }

  @override
  void addAll(List<Component> components) {
    for (final comp in components) {
      children.add(comp);
      nodeRoot.children.add(comp.nodeRoot);
    }
    setSpaceBetweenItems(_spaceBetweenItems);
  }

  void remove(Component component) {
    children.remove(component);
    nodeRoot.children.remove(component.nodeRoot);
    setSpaceBetweenItems(_spaceBetweenItems);
  }

  void clear() {
    nodeRoot.children.clear();
    children.clear();
  }

  void vertical() {
    _vertical = true;
    nodeRoot.style.flexDirection = 'column';
    setSpaceBetweenItems(_spaceBetweenItems);
    if (_scrollable) {
      scrollable();
    }
  }

  void setSpaceBetweenItems(int space) {
    if (space == 0 && _spaceBetweenItems == 0) {
      return;
    }
    _spaceBetweenItems = space;
    for (final child in children) {
      if (_vertical) {
        child.nodeRoot.style.marginBottom = '${space}px';
        if (nodeRoot.style.flexWrap == 'wrap') {
          child.nodeRoot.style.marginRight = '${space}px';
        } else {
          child.nodeRoot.style.marginRight = '0';
        }
      } else {
        child.nodeRoot.style.marginRight = '${space}px';
        if (nodeRoot.style.flexWrap == 'wrap') {
          child.nodeRoot.style.marginBottom = '${space}px';
        } else {
          child.nodeRoot.style.marginBottom = '0';
        }
      }
    }
  }

  void setPadding(int padding) {
    nodeRoot.style.padding = '${padding}px';
  }

  void setPaddings(String paddings) => nodeRoot.style.padding = paddings;

  void scrollable() {
    _scrollable = true;
    if (_vertical) {
      nodeRoot.style.overflowY = 'scroll';
    } else {
      nodeRoot.style.overflowX = 'scroll';
    }
  }

  void noScrollable() {
    _scrollable = false;
    if (_vertical) {
      nodeRoot.style.overflowY = 'hidden';
    } else {
      nodeRoot.style.overflowX = 'hidden';
    }
  }

  void loadIndicatorShow() {
    loadIndicator ??= SimpleImage()
      ..source = 'images/load_indicator.gif'
      ..addCssClasses(['loadIndicator']);
    nodeRoot.style.alignItems = 'center';
    nodeRoot.style.justifyContent = 'center';
    add(loadIndicator!);
    loadIndicator!.nodeRoot.style.display = 'flex';
  }

  void loadIndicatorHide() {
    if (loadIndicator != null) {
      nodeRoot.style.alignItems = _align;
      nodeRoot.style.justifyContent = 'normal';
      loadIndicator!.nodeRoot.style.display = 'none';
    }
  }

  set border(String border) {
    nodeRoot.style.border = border;
  }

  String get border => nodeRoot.style.border;

  set header(String newHeader) {
    _header = newHeader;
    if (_header.isEmpty) {
      headerLabel?.style.display = 'none';
    } else {
      headerLabel ??= DivElement()..classes.add('hvPanelHeader');
      headerLabel!
        ..text = header
        ..style.display = 'block';
      nodeRoot.children.insert(0, headerLabel!);
    }
  }

  String get header => _header;

  String get align => _align;

  set align(String newAlign) {
    _align = newAlign;
    nodeRoot.style.alignItems = newAlign;
  }

  String get background => nodeRoot.style.background;

  set background(String newBackground) {
    nodeRoot.style.backgroundColor = newBackground;
  }

  @override
  set borderRadius(String borderRadius) {
    nodeRoot.style.borderRadius = borderRadius;
  }
}
