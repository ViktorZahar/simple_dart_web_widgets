import 'abstract_component.dart';
import 'labels/simple_label.dart';
import 'panel.dart';

class FormPanel extends PanelComponent {
  FormPanel() : super('FormPanel') {
    vertical = true;
  }

  List<Panel> rows = <Panel>[];

  void addComponent(String caption, Component component) {
    final simpleLabel = SimpleLabel()
      ..caption = caption
      ..width = _labelsWidth;
    final row = Panel()
      ..stride = _formStride
      ..add(simpleLabel)
      ..add(component);
    rows.add(row);
    add(row);
  }

  void addLabel(String caption, String label) {
    final simpleLabel = SimpleLabel()..caption = label;
    addComponent(caption, simpleLabel);
  }

  String _formStride = '';
  String _labelsWidth = '';

  set formStride(String value) {
    _formStride = value;
    for (final row in rows) {
      row.stride = _formStride;
    }
  }

  String get formStride => _formStride;

  set labelsWidth(String value) {
    _labelsWidth = value;
    for (final row in rows) {
      row.children.first.width = _labelsWidth;
    }
  }

  @override
  void clear() {
    rows.clear();
    super.clear();
  }

  String get labelsWidth => _labelsWidth;
}
