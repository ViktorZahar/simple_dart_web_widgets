import 'abstract_component.dart';
import 'labels/simple_label.dart';
import 'panel.dart';

class HeadedPanel extends PanelComponent {
  HeadedPanel() : super('HeadedPanel') {
    vertical = true;
    stride = '8px';
    padding = '10px';
    addAll([header, contentPanel]);
  }

  HeadedPanel.withCaption(String caption, List<Component> childs)
      : super('HeadedPanel') {
    vertical = true;
    stride = '8px';
    padding = '10px';
    addAll([header, contentPanel]);
    this.caption = caption;
    contentPanel.addAll(childs);
  }

  SimpleLabel header = SimpleLabel()
    ..addCssClass('HeadedPanelHeader')
    ..visible = false
    ..width = '100%';

  Panel contentPanel = Panel()
    ..stride = '5px'
    ..vertical = true
    ..fillContent = true;

  String get caption => header.caption;

  set caption(String value) {
    header.caption = value;
    if (value.isEmpty) {
      header.visible = false;
    }
    else {
      header.visible = true;
    }
  }
}
