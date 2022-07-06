import 'dart:async';
import 'dart:html';

import '../fields/checkbox_field.dart';
import '../utils.dart';
import 'simple_table.dart';

typedef ObjectTableRowAdapter<T> = List<dynamic> Function(T object);

class ObjectTableSelectEvent<T> {
  ObjectTableSelectEvent(this.object, {this.selected = false});

  final T object;
  bool selected = false;
}

class ObjectTable<T> extends SimpleTable {
  ObjectTable(this.objectRowAdapter, {selectable = false}) {
    _selectable = selectable;
    if (_selectable) {
      final cell = SimpleCell()..width = '40px';
      headersRow.add(cell);
    }
  }

  List<T> objectList = <T>[];
  bool _selectable = false;

  late ObjectTableRowAdapter<T> objectRowAdapter;

  final StreamController<ObjectTableSelectEvent<T>> _onSelect =
      StreamController<ObjectTableSelectEvent<T>>.broadcast();

  SimpleTableRow createObjectRow(T object) {
    objectList.add(object);
    final rowData = objectRowAdapter(object)..add(object);
    final newRow = super.createRow(rowData);
    if (_selectable) {
      final checkboxField = CheckboxField()
        ..width = '40px'
        ..onValueChange.listen((event) {
          _onCheckBoxSelect(
              ObjectTableSelectEvent(object, selected: event.newValue));
        });
      final cell = SimpleCell.createComponentCell(checkboxField);
      newRow.insert(0, cell);
    }
    return newRow;
  }

  void _onCheckBoxSelect(ObjectTableSelectEvent<T> object) {
    _onSelect.sink.add(object);
  }

  Stream<ObjectTableSelectEvent<T>> get onSelect => _onSelect.stream;

  void dispose() {
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

  @override
  void sortData(int indexOf, String sortSymbol) {
    final rowData = <List<dynamic>>[];
    for (final row in rows) {
      rowData.add(row.data);
    }
    if (sortSymbol == '▼') {
      rowData.sort((a, b) {
        final data1 = a[indexOf];
        final data2 = b[indexOf];
        return compareDynamics(data2, data1);
      });
    } else {
      rowData.sort((a, b) {
        final data1 = a[indexOf];
        final data2 = b[indexOf];
        return compareDynamics(data1, data2);
      });
    }
    clear();
    rowData.forEach((row) {
      createObjectRow(row.last);
    });
  }
}
