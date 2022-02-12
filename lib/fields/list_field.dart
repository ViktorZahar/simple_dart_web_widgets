import 'dart:html';

import '../abstract_component.dart';
import '../buttons.dart';
import '../hv_panel.dart';
import '../labels/simple_label.dart';
import 'text_field.dart';

typedef FilterFunc = bool Function(List<String> oldValues, String newRow);

class ListField extends HVPanel with Field<List<String>> {
  ListField() {
    vertical = true;
    stride = '3px';
    addButton.onClick.listen((event) {
      final newRow = addField.value;
      if (newRow.isEmpty) {
        return;
      }
      final oldValue = value;
      var valid = true;
      if (filter != null) {
        valid = filter!(oldValue, newRow);
      }
      if (valid) {
        addRow(newRow);
        addField.value = '';
        fireValueChange(oldValue, value);
      }
    });
    addPanel.addAll([addField, addButton]);

    addAll([valueListPanel, addPanel]);
  }

  bool _disabled = false;

  bool get disabled => _disabled;

  set disabled(bool newVal) {
    _disabled = newVal;
    for (final row in valueListPanel.children) {
      if (row is ListFieldRow) {
        row.removeButton.visible = !newVal;
      }
    }
    addPanel.visible = !newVal;
  }

  @override
  void focus() {
    addField.focus();
  }

  FilterFunc? filter;

  TextField addField = TextField()
    ..fullWidth()
    ..fillContent();
  SimpleButton addButton = SimpleButton()..caption = 'Add';
  HVPanel addPanel = HVPanel()..stride = '5px';
  HVPanel valueListPanel = HVPanel()..vertical = true;

  @override
  List<String> get value => valueListPanel.children.map((e) {
        if (e is ListFieldRow) {
          return e.value;
        } else {
          return '';
        }
      }).toList();

  @override
  set value(List<String> newValue) {
    final oldValue = value;
    if (newValue.length < valueListPanel.children.length) {
      for (var i = newValue.length; i < valueListPanel.children.length; i++) {
        valueListPanel.remove(valueListPanel.children[i]);
      }
    }
    var i = 0;
    for (final valuePanel in valueListPanel.children) {
      if (valuePanel is ListFieldRow) {
        valuePanel.value = newValue[i];
      }
      i++;
    }
    if (newValue.length > valueListPanel.children.length) {
      for (; i < newValue.length; i++) {
        addRow(newValue[i]);
      }
    }
    fireValueChange(oldValue, newValue);
  }

  void addRow(String row) {
    final newRowPanel = ListFieldRow()..value = row;
    newRowPanel.onRemove = (e) {
      final oldValue = value;
      valueListPanel.remove(newRowPanel);
      fireValueChange(oldValue, value);
    };
    valueListPanel.add(newRowPanel);
  }
}

class ListFieldRow extends HVPanel {
  ListFieldRow() {
    stride = '3px';
    removeButton.onClick.listen((event) {
      if (onRemove != null) {
        onRemove!(event);
      }
    });
    align = 'center';
    add(removeButton);
    add(valueLabel);
  }

  SimpleLabel removeButton = SimpleLabel()
    ..width = '20px'
    ..height = '20px'
    ..addCssClass('RemoveButton')
    ..caption = '';

  SimpleLabel valueLabel = SimpleLabel()
    ..fillContent()
    ..fullWidth();

  Function(MouseEvent event)? onRemove;

  set value(String newValue) {
    valueLabel.caption = newValue;
  }

  String get value => valueLabel.caption;
}
