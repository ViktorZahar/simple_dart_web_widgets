import 'dart:async';
import 'dart:html';

final themeController = ThemeController();

class ThemeController {
  String currentTheme = '';

  List<String> themeList = ['default', 'dark', 'blue'];

  final StreamController<String> _onThemeChange =
      StreamController<String>.broadcast();

  Stream<String> get onThemeChange => _onThemeChange.stream;

  void loadLocalTheme() {
    final theme = window.localStorage['theme'];
    if (theme != null) {
      switchTheme(theme);
    }
  }

  void switchTheme(String themeName) {
    currentTheme = themeName;
    window.localStorage['theme'] = themeName;
    final linkElements = querySelectorAll('link');
    final headElement = querySelector('head')!;
    final themeElement = linkElements.singleWhere((element) {
      if (element is LinkElement) {
        if (element.href.endsWith('_theme.css')) {
          return true;
        }
      }
      return false;
    }, orElse: () {
      final newElem = LinkElement()..rel = 'stylesheet';
      headElement.children.add(newElem);
      return newElem;
    });
    if (themeElement is LinkElement) {
      themeElement.href = '${themeName}_theme.css';
      _onThemeChange.sink.add(themeName);
    }
  }

  void dispose() {
    _onThemeChange.close();
  }
}
