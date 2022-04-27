import 'dart:async';
import 'dart:html';

import '../abstract_component.dart';
import '../fields/checkbox_field.dart';
import 'simple_table.dart';

class ObjectTable<T> extends SimpleTable {
  ObjectTable() {
    final cell = SimpleCell()..width = '40px';
    headersRow.add(cell);
  }

  List<T> objectList = <T>[];

  final StreamController<bool> _onSelect = StreamController<bool>();

  @override
  SimpleTableRow createRow(List<dynamic> cellValues) {
    final object = cellValues[0];
    objectList.add(object);
    final newRow = super.createRow(cellValues.sublist(1));
    final checkboxField = CheckboxField()
      ..width = '40px'
      ..onValueChange.listen(_onCheckBoxSelect);
    final cell = SimpleCell.createComponentCell(checkboxField);
    newRow.insert(0, cell);
    return newRow;
  }

  void _onCheckBoxSelect(ValueChangeEvent<bool> event) {
    _onSelect.sink.add(event.newValue);
  }

  Stream<bool> get onSelect => _onSelect.stream;

  void destroy() {
    _onSelect.close();
  }

  List<T> getSelected() {
    final ret = <T>[];
    for (var i = 0; i < objectList.length; i++) {
      final row = rows[i];
      final obj = objectList[i];
      final checkBox = row.children[0].nodeRoot.children[0];
      if (checkBox is CheckboxInputElement) {
        if (checkBox.checked ?? false) {
          ret.add(obj);
        }
      }
    }
    return ret;
  }

  @override
  void clear() {
    super.clear();
    objectList.clear();
  }
}
