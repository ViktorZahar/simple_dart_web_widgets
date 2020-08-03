import 'dart:html';

import '../../widgets.dart';

class SimpleTable extends HVPanel {
  SimpleTable() {
    vertical();
    nodeRoot.style.flexShrink = '1';
    addAll([nameLabel, headersRow, scrollablePanel]);
    nodeRoot.onCopy.listen(copyToClipboard);
  }
  bool copyFull = false;
  SimpleLabel nameLabel = SimpleLabel()..varName('nameLabel');
  SimpleTableRow headersRow = SimpleTableRow()..varName('headersRow');
  List<SimpleTableRow> rows = <SimpleTableRow>[];
  List<SimpleTableColumn> columns = <SimpleTableColumn>[];
  HVPanel scrollablePanel = HVPanel()
    ..vertical()
    ..varName('scrollablePanel')
    ..scrollable()
    ..fillContent()
    ..fullSize();

  Function(int columnIdx, String direction) onSortListener;

  void createColumn(String headerCaption, int width, {bool sortable = false}) {
    final column = SimpleTableColumn()
      .._width = width
      ..caption = headerCaption
      ..sortable = sortable;
    columns.add(column);
    final headerCell = headersRow.createColumnHeaderCell(column)
      ..width = '${width}px';
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
          onSortListener(columns.indexOf(column), sortSymbol);
        }
      });
    }
  }

  SimpleTableRow createRow(List<String> cellTexts, String href) {
    final row = SimpleTableRow();
    if (href.isNotEmpty) {
      row.createHrefCell(cellTexts[0], href);
    } else {
      row.createCell(cellTexts[0]);
    }
    for (var i = 1; i < cellTexts.length; i++) {
      row.createCell(cellTexts[i]);
    }
    addRow(row);
    return row;
  }

  void addRow(SimpleTableRow simpleTableRow) {
    if (columns.length == simpleTableRow.cells.length) {
      for (var i = 0; i < simpleTableRow.cells.length; i++) {
        simpleTableRow.cells[i].width = '${columns[i].width}px';
      }
    }
    rows.add(simpleTableRow);
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
    if (copyFull) {
      var cpData = nameLabel.caption + '\n';
      cpData +=
          headersRow.cells.map((cell) => cell.text).toList().join('\t') + '\n';
      for (final row in rows) {
        cpData += row.cells
                .map((cell) => cell.text.replaceAll('.', ','))
                .toList()
                .join('\t') +
            '\n';
      }
      event.clipboardData.setData('text/plain', cpData);
      event.preventDefault();
    }
  }
}

class SimpleCell extends Component {
  SimpleCell() {
    nodeRoot = DivElement();
  }

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

  @override
  Element nodeRoot;

  String get text => nodeRoot.text;

  set text(String newText) => nodeRoot.text = newText;
}

class SimpleTableRow extends HVPanel {
  SimpleTableRow() {
    fullWidth();
  }

  List<SimpleCell> cells = <SimpleCell>[];

  SimpleCell createCell(String text) {
    final cell = SimpleCell()
      ..text = text
      ..width = '${width}px';
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createColumnHeaderCell(SimpleTableColumn column) {
    final cell = SimpleCell()
      ..text = column.caption
      ..width = '${width}px';
    if (column.sortable) {
      cell.nodeRoot.style
        ..cursor = 'pointer'
        ..fontWeight = 'bold';
    }
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createHrefCell(String text, String href) {
    final cell = SimpleCell.createLinkCell(href)
      ..text = text
      ..width = '${width}px';
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createImageCell(String content, int width, int height) {
    final cell =
        SimpleCell.createImageCell(content, '${width}px', '${height}px');
    cells.add(cell);
    add(cell);
    return cell;
  }
}

class SimpleTableColumn {
  SimpleTableColumn();
  SimpleCell headerCell;
  List<SimpleCell> cells = <SimpleCell>[];
  String caption = '';
  int _width = 0;
  bool sortable = false;

  int get width => _width;

  set width(int newWidth) {
    for (final cell in cells) {
      cell.width = '${newWidth}px';
    }
    _width = newWidth;
  }
}
