import 'dart:html';

import '../abstract_component.dart';
import '../labels/simple_label.dart';
import '../panel.dart';
import '../utils.dart';

class SimpleTable extends PanelComponent {
  SimpleTable() : super('SimpleTable') {
    vertical = true;
    nodeRoot.style.flexShrink = '1';
    addAll([headersRow, scrollablePanel]);
    nodeRoot.onCopy.listen(copyToClipboardListener);
  }

  bool _copyFull = false;
  SimpleTableRow headersRow = SimpleTableRow()..addCssClass('Header');
  List<SimpleTableRow> rows = <SimpleTableRow>[];
  List<SimpleTableColumn> columns = <SimpleTableColumn>[];

  PanelComponent scrollablePanel = Panel()
    ..wrap = false
    ..vertical = true
    ..varName('scrollablePanel')
    ..scrollable = true
    ..fillContent = true
    ..fullSize();

  SimpleTableColumn createColumn(String headerCaption, int width,
      {bool sortable = false, String vAlign = 'left', int precision = 0}) {
    final column = SimpleTableColumn()
      .._width = width
      ..caption = headerCaption
      ..sortable = sortable
      ..precision = precision
      ..vAlign = vAlign;
    columns.add(column);
    final headerCell = headersRow.createColumnHeaderCell(column);
    column.headerCell = headerCell;
    if (sortable) {
      headerCell.nodeRoot.onClick.listen((e) {
        var sortSymbol = '';
        if (headerCell.text == column.caption) {
          sortSymbol = '▲';
        } else if (headerCell.text.endsWith('▲')) {
          sortSymbol = '▼';
        }
        for (final col in columns) {
          col.headerCell.text = col.caption;
        }
        headerCell.text = '${column.caption} $sortSymbol'.trim();
        sortData(columns.indexOf(column), sortSymbol);
      });
    }
    return column;
  }

  SimpleTableRow createRow(List<dynamic> cellValues) {
    final row = SimpleTableRow()..data = cellValues;
    for (var i = 0; i < columns.length; i++) {
      final column = columns[i];
      final value = cellValues[i];
      SimpleCell? cell;
      if (value is SimpleTableHref) {
        cell = row.createHrefCell(value);
      } else if (value is SimpleTableImage) {
        cell = row.createImageCell(value);
      } else if (value is Component) {
        cell = row.createComponentCell(value);
      } else if (value is List) {
        cell = row.createMultiLineCell(value);
      } else {
        var valueStr = '';
        if (value == null) {
          valueStr = '';
        } else if (value is num) {
          valueStr = value.toStringAsFixed(column.precision);
        } else if (value is DateTime) {
          valueStr = formatDateHum(value);
        } else {
          valueStr = value.toString();
        }
        cell = row.createCell(valueStr);
      }

      final vAlign = column.vAlign;
      if (vAlign == 'center') {
        cell.nodeRoot.style.justifyContent = 'center';
      }
      if (vAlign == 'right') {
        cell.nodeRoot.style.justifyContent = 'flex-end';
      }
    }
    addRow(row);
    return row;
  }

  void addRow(SimpleTableRow simpleTableRow) {
    if (simpleTableRow.cells.length < columns.length) {
      for (var colNum = simpleTableRow.cells.length;
          colNum < columns.length;
          colNum++) {
        simpleTableRow.createCell('');
      }
    }
    if (columns.length == simpleTableRow.cells.length) {
      for (var i = 0; i < simpleTableRow.cells.length; i++) {
        simpleTableRow.cells[i].width = '${columns[i].width}px';
      }
    }
    rows.add(simpleTableRow);
    final isEven = rows.length % 2 == 0;
    if (isEven) {
      simpleTableRow.addCssClass('Even');
    } else {
      simpleTableRow.addCssClass('Odd');
    }
    scrollablePanel.add(simpleTableRow);
  }

  @override
  void clear() {
    scrollablePanel.clear();
    rows.clear();
  }

  void applyCellStyle(
      Function(int rowIdx, int colIdx, SimpleCell cell) styleFunction) {
    var r = 0;
    for (final row in rows) {
      var c = 0;
      for (final cell in row.cells) {
        styleFunction(r, c, cell);
        c++;
      }
      r++;
    }
  }

  void copyToClipboard() {
    _copyFull = true;
    window.getSelection()!.selectAllChildren(nodeRoot);
    document.execCommand('copy');
    window.getSelection()!.removeAllRanges();
    _copyFull = false;
  }

  void copyToClipboardListener(ClipboardEvent event) {
    if (_copyFull) {
      final cpData = StringBuffer()
        ..writeln(
            headersRow.cells.map((cell) => cell.text).toList().join('\t'));
      for (final row in rows) {
        for (var i = 0; i < columns.length; i++) {
          final value = row.data[i];
          final column = columns[i];
          var formattedValue = '';
          if (value is SimpleTableHref) {
            formattedValue = value.caption;
          } else if (value is SimpleTableImage) {
            formattedValue = value.url;
          } else if (value is List) {
            formattedValue = value.join(';');
          } else if (value == null) {
            formattedValue = '';
          } else if (value is num) {
            formattedValue =
                value.toStringAsFixed(column.precision).replaceAll('.', ',');
          } else {
            formattedValue = value.toString();
          }
          cpData.write('$formattedValue\t');
        }
        cpData.write('\n');
      }
      event.clipboardData!.setData('text/plain', cpData.toString());
      event.preventDefault();
    }
  }

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
    rowData.forEach(createRow);
  }
}

class SimpleCell extends Component {
  SimpleCell() : super('SimpleCell');

  SimpleCell.createLinkCell(String href) : super('SimpleCell') {
    nodeRoot = AnchorElement(href: href);
  }

  SimpleCell.createImageCell(
      String content, String imageWidth, String imageHeight)
      : super('SimpleCell') {
    final imageElement = ImageElement(src: content);
    imageElement.style
      ..width = imageWidth
      ..height = imageHeight
      ..border = '1px solid black';
    nodeRoot = DivElement();
    nodeRoot.children.add(imageElement);
  }

  SimpleCell.createMultiLineCell(List<dynamic> content) : super('SimpleCell') {
    final hvPanel = Panel()
      ..vertical = true
      ..nodeRoot.style.flexShrink = '1';
    for (final line in content) {
      final label = SimpleLabel()..caption = '${line.toString()} ';
      hvPanel.add(label);
    }
    nodeRoot = hvPanel.nodeRoot;
  }

  SimpleCell.createComponentCell(Component comp) : super('SimpleCell') {
    nodeRoot = comp.nodeRoot;
  }

  @override
  Element nodeRoot = DivElement()..style.overflowWrap = 'anywhere';

  String get text => nodeRoot.text ?? '';

  set text(String newText) => nodeRoot.text = newText;
}

class SimpleTableRow extends PanelComponent {
  SimpleTableRow() : super('SimpleTableRow') {
    fullWidth();
  }

  List<SimpleCell> cells = <SimpleCell>[];
  late List<dynamic> data;

  SimpleCell createCell(String text) {
    final cell = SimpleCell()..text = text;
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createColumnHeaderCell(SimpleTableColumn column) {
    final cell = SimpleCell()
      ..text = column.caption
      ..width = '${column.width}px';
    if (column.sortable) {
      cell.addCssClass('Sortable');
    }
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createHrefCell(SimpleTableHref href) {
    final cell = SimpleCell.createLinkCell(href.url)..text = href.caption;
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createImageCell(SimpleTableImage img) {
    final cell = SimpleCell.createImageCell(
        img.url, '${img.width}px', '${img.height}px');
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createMultiLineCell(List<dynamic> content) {
    final cell = SimpleCell.createMultiLineCell(content);
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createComponentCell(Component comp) {
    final cell = SimpleCell.createComponentCell(comp);
    cells.add(cell);
    add(cell);
    return cell;
  }
}

class SimpleTableColumn {
  SimpleTableColumn();

  SimpleCell headerCell = SimpleCell();
  List<SimpleCell> cells = <SimpleCell>[];
  String caption = '';
  int _width = 0;
  bool sortable = false;
  String vAlign = 'left';
  int precision = 0;

  int get width => _width;

  set width(int newWidth) {
    for (final cell in cells) {
      cell.width = '${newWidth}px';
    }
    _width = newWidth;
  }
}

class SimpleTableHref {
  SimpleTableHref(this.caption, this.url);

  @override
  String toString() => caption;

  late String caption = '';
  late String url = '';
}

class SimpleTableImage {
  SimpleTableImage(this.url, this.width, this.height);

  late String url = '';
  late int width;
  late int height;
}
