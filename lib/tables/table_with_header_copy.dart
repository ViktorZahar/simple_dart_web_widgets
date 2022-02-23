import '../buttons.dart';
import '../labels/simple_label.dart';
import '../panel.dart';
import 'simple_table.dart';

class TableWithHeaderCopy extends SimpleTable {
  TableWithHeaderCopy() : super() {
    copyButton.onClick.listen((event) {
      copyToClipboard();
    });
    headerPanel.addAll([headerLabel, copyButton]);
    insert(0, headerPanel);
  }

  Panel headerPanel = Panel()
    ..fullWidth()
    ..addCssClass('TableHeaderPanel');

  SimpleLabel headerLabel = SimpleLabel()
    ..addCssClass('TableHeaderLabel')
    ..fillContent = true;
  SimpleButton copyButton = SimpleButton()
    ..caption = 'copy'
    ..setCssClass('TableCopyButton');
}
