import 'dart:html';

import '../abstract_component.dart';
import '../panels.dart';

class SimpleTable extends HVPanel {
  SimpleTable() {
    vertical();
    add(headersRow);
  }

  SimpleTableRow headersRow = SimpleTableRow();
  List<SimpleTableRow> rows = <SimpleTableRow>[];
  List<SimpleTableColumn> columns = <SimpleTableColumn>[];

  void createColumn(String headerCaption, int width) {
    final column = SimpleTableColumn()
      .._width = width
      ..headerCell = headersRow.createCell(headerCaption, width);
    columns.add(column);
  }

  void createRow(List<String> cellTexts, String href) {
    final row = SimpleTableRow();
    add(row);
    row.createHrefCell(cellTexts[0], href, columns[0].width);
    for (var i = 1; i < columns.length; i++) {
      row.createCell(cellTexts[i], columns[i].width);
    }
  }

  @override
  void clear() {
    super.clear();
    rows.clear();
    add(headersRow);
  }
}

class SimpleCell extends Component {
  SimpleCell() {
    nodeRoot = DivElement();
    height = '30px';
  }

  SimpleCell.createLinkCell(String href) {
    nodeRoot = AnchorElement(href: href);
    height = '30px';
  }

  SimpleCell.createImageCell(String content, String width, String height) {
    nodeRoot = ImageElement(src: content);
    this.height = height;
    this.width = width;
    nodeRoot.style.border = '1px solid black';
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

  SimpleCell createCell(String text, int width) {
    final cell = SimpleCell()
      ..text = text
      ..width = '${width}px';
    cells.add(cell);
    add(cell);
    return cell;
  }

  SimpleCell createHrefCell(String text, String href, int width) {
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

  int get width => _width;

  set width(int newWidth) {
    for (final cell in cells) {
      cell.width = '${newWidth}px';
    }
    _width = newWidth;
  }
}
