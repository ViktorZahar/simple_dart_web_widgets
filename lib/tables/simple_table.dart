import 'dart:html';

import '../abstract_component.dart';
import '../buttons.dart';
import '../hv_panel.dart';
import '../labels/simple_label.dart';

class SimpleTable extends HVPanel {
  SimpleTable() {
    vertical = true;
    nodeRoot.style.flexShrink = '1';
    nameLabel.fillContent();
    btnCopyFull.onClick.listen((event) {
      _copyFull = true;
      window.getSelection()!.selectAllChildren(nodeRoot);
      document.execCommand('copy');
      window.getSelection()!.removeAllRanges();
      _copyFull = false;
    });
    namePanel
      ..add(nameLabel)
      ..add(btnCopyFull);
    addAll([namePanel, headersRow, scrollablePanel]);
    nodeRoot.onCopy.listen(copyToClipboard);
  }

  HVPanel namePanel = HVPanel();
  bool _copyFull = false;
  SimpleLabel nameLabel = SimpleLabel()..varName('nameLabel');
  SimpleTableRow headersRow = SimpleTableRow()..addCssClass('Header');
  List<SimpleTableRow> rows = <SimpleTableRow>[];
  List<SimpleTableColumn> columns = <SimpleTableColumn>[];
  SimpleButton btnCopyFull = SimpleButton()..caption = 'copy';
  HVPanel scrollablePanel = HVPanel()
    ..wrap = false
    ..vertical = true
    ..varName('scrollablePanel')
    ..scrollable = true
    ..fillContent()
    ..fullSize();

  Function(int columnIdx, String direction)? onSortListener;

  SimpleTableColumn createColumn(String headerCaption, int width,
      {bool sortable = false,
      String vAlign = 'left',
      int doublePrecision = 2}) {
    final column = SimpleTableColumn()
      .._width = width
      ..caption = headerCaption
      ..sortable = sortable
      ..doublePrecision = doublePrecision
      ..vAlign = vAlign;
    columns.add(column);
    final headerCell = headersRow.createColumnHeaderCell(column)
      ..width = '${width}px';
    if (sortable) {
      headerCell.nodeRoot.style.textDecoration = 'underline';
    }
    column.headerCell = headerCell;
    if (sortable) {
      headerCell.nodeRoot.onClick.listen((e) {
        if (onSortListener != null) {
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
          onSortListener!(columns.indexOf(column), sortSymbol);
        }
      });
    }
    return column;
  }

  SimpleTableRow createRow(List<dynamic> cellValues) {
    final row = SimpleTableRow();
    for (var i = 0; i < cellValues.length; i++) {
      final value = cellValues[i];
      final column = columns[i];
      SimpleCell? cell;
      if (value is SimpleTableHref) {
        cell = row.createHrefCell(value);
      } else if (value is SimpleTableImage) {
        cell = row.createImageCell(value);
      } else if (value is List) {
        cell = row.createMultiLineCell(value);
      } else {
        var valueStr = '';
        if (value == null) {
          valueStr = '';
        } else if (value is double) {
          valueStr = value.toStringAsFixed(column.doublePrecision);
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

  void copyToClipboard(ClipboardEvent event) {
    if (_copyFull) {
      final cpData = StringBuffer()
        ..writeln(nameLabel.caption)
        ..writeln(
            headersRow.cells.map((cell) => cell.text).toList().join('\t'));
      for (final row in rows) {
        cpData.writeln(row.cells.map((cell) => cell.text).toList().join('\t'));
      }
      event.clipboardData!.setData('text/plain', cpData.toString());
      event.preventDefault();
    }
  }
}

class SimpleCell extends Component {
  SimpleCell();

  SimpleCell.createLinkCell(String href) {
    nodeRoot = AnchorElement(href: href);
  }

  SimpleCell.createImageCell(
      String content, String imageWidth, String imageHeight) {
    final imageElement = ImageElement(src: content);
    imageElement.style
      ..width = imageWidth
      ..height = imageHeight
      ..border = '1px solid black';
    nodeRoot = DivElement();
    nodeRoot.children.add(imageElement);
  }

  SimpleCell.createMultiLineCell(List<dynamic> content) {
    final hvPanel = HVPanel()
      ..vertical = true
      ..nodeRoot.style.flexShrink = '1';
    for (final line in content) {
      final label = SimpleLabel()..caption = '${line.toString()} ';
      hvPanel.add(label);
    }
    nodeRoot = hvPanel.nodeRoot;
  }

  @override
  Element nodeRoot = DivElement()..style.overflowWrap = 'anywhere';

  String get text => nodeRoot.text ?? '';

  set text(String newText) => nodeRoot.text = newText;
}

class SimpleTableRow extends HVPanel {
  SimpleTableRow() {
    fullWidth();
  }

  List<SimpleCell> cells = <SimpleCell>[];

  SimpleCell createCell(String text) {
    final cell = SimpleCell()..text = text;
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createColumnHeaderCell(SimpleTableColumn column) {
    final cell = SimpleCell()..text = column.caption;
    if (column.sortable) {
      cell.nodeRoot.style
        ..cursor = 'pointer'
        ..fontWeight = 'bold';
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
}

class SimpleTableColumn {
  SimpleTableColumn();

  SimpleCell headerCell = SimpleCell();
  List<SimpleCell> cells = <SimpleCell>[];
  String caption = '';
  int _width = 0;
  bool sortable = false;
  String vAlign = 'left';
  int doublePrecision = 2;

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

  late String caption = '';
  late String url = '';
}

class SimpleTableImage {
  SimpleTableImage(this.url, this.width, this.height);

  late String url = '';
  late int width;
  late int height;
}
