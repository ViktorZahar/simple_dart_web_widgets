import 'buttons.dart';
import 'fields/num_field.dart';
import 'labels/simple_label.dart';
import 'panel.dart';

class Pager extends PanelComponent {
  Pager() : super('Pager') {
    add(btnFirst);
    add(btnPrev);
    add(numField);
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
    numField.onValueChange.listen((e) {
      try {
        final newPageNum = numField.value.toInt();
        pagable!.openPage(newPageNum);
        refreshDisplay();
      } on Exception catch (_) {}
    });
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

  NumField numField = NumField()
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

  Pageable? pagable;

  void bind(Pageable pagable) {
    this.pagable = pagable;
    refreshDisplay();
  }

  void refreshDisplay() {
    if (pagable != null) {
      numField.value = pagable!.currentPage;
      lblCount.caption = '/ ${pagable!.pageCount}';
      btnFirst.disabled = pagable!.currentPage == 1;
      btnLast.disabled = pagable!.currentPage >= pagable!.pageCount;
      btnPrev.disabled = btnFirst.disabled;
      btnNext.disabled = btnLast.disabled;
    }
  }
}

abstract class Pageable {
  int get pageCount;

  int get currentPage;

  void openPage(int i);
}
