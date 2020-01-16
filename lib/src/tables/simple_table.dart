import 'dart:html';

import '../abstract_component.dart';
import '../panels.dart';

class SimpleTable extends HVPanel {
  SimpleTable() {
    vertical();
    addRow(headersRow);
  }

  SimpleTableRow headersRow = SimpleTableRow();
  List<SimpleTableRow> rows = <SimpleTableRow>[];
  List<SimpleTableColumn> columns = <SimpleTableColumn>[];

  void createColumn(String headerCaption, int width) {
    final column = SimpleTableColumn().._width = width;
    columns.add(column);
    headersRow.createCell(headerCaption).width='${width}px';
  }

  void createRow(List<String> cellTexts, String href) {
    final row = SimpleTableRow()..createHrefCell(cellTexts[0], href);
    for (var i = 1; i < columns.length; i++) {
      row.createCell(cellTexts[i]);
    }
    addRow(row);
  }

  void addRow(SimpleTableRow simpleTableRow) {
    for (var i = 0; i < columns.length; i++) {
      simpleTableRow.cells[i].width = '${columns[i].width}px';
    }
    rows.add(simpleTableRow);
    add(simpleTableRow);
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

  int get width => _width;

  set width(int newWidth) {
    for (final cell in cells) {
      cell.width = '${newWidth}px';
    }
    _width = newWidth;
  }
}
