import 'buttons.dart';
import 'fields/text_field.dart';
import 'hv_panel.dart';
import 'labels/simple_label.dart';

class Pager extends HVPanel {
  Pager() {
    add(btnFirst);
    add(btnPrev);
    add(textElement);
    add(lblCount);
    add(btnNext);
    add(btnLast);
    stride = '1px';
    align = 'center';
    btnFirst.onClick.listen((e) {
      pagable!.openPage(1);
      refreshDisplay();
    });
    btnPrev.onClick.listen((e) {
      if (pagable!.currentPage > 1) {
        pagable!.openPage(pagable!.currentPage - 1);
        refreshDisplay();
      }
    });
    btnNext.onClick.listen((e) {
      if (pagable!.currentPage < pagable!.pageCount) {
        pagable!.openPage(pagable!.currentPage + 1);
        refreshDisplay();
      }
    });
    btnLast.onClick.listen((e) {
      pagable!.openPage(pagable!.pageCount);
      refreshDisplay();
    });
    textElement.onChange((e) {
      try {
        final newPageNum = int.parse(textElement.value);
        pagable!.openPage(newPageNum);
        refreshDisplay();
      } on Exception catch (_) {}
    });
    height = '25px';
  }

  SimpleButton btnFirst = SimpleButton()
    ..fullHeight()
    ..caption = '<<';
  SimpleButton btnPrev = SimpleButton()
    ..fullHeight()
    ..caption = ' <';
  SimpleButton btnNext = SimpleButton()
    ..fullHeight()
    ..caption = '> ';
  SimpleButton btnLast = SimpleButton()
    ..fullHeight()
    ..caption = '>>';

  TextField textElement = TextField()
    ..width = '35px'
    ..height = '19px'
    ..textAlign = 'center'
    ..nodeRoot.style.marginLeft = '5px'
    ..nodeRoot.style.marginRight = '5px';
  SimpleLabel lblCount = SimpleLabel()
    ..height = '25px'
    ..caption = '/ 0'
    ..nodeRoot.style.paddingLeft = '5px'
    ..nodeRoot.style.paddingRight = '5px';

  Pagable? pagable;

  void bind(Pagable pagable) {
    this.pagable = pagable;
    refreshDisplay();
  }

  void refreshDisplay() {
    if (pagable != null) {
      textElement.value = pagable!.currentPage.toString();
      lblCount.caption = '/ ${pagable!.pageCount}';
      btnFirst.enabled = pagable!.currentPage != 1;
      btnLast.enabled = pagable!.currentPage < pagable!.pageCount;
      btnPrev.enabled = btnFirst.enabled;
      btnNext.enabled = btnLast.enabled;
    }
  }
}

abstract class Pagable {
  int get pageCount;

  int get currentPage;

  void openPage(int i);
}
