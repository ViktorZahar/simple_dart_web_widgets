import 'dart:async';

import 'package:simple_dart_web_charts/chart.dart';

import 'panel.dart';
import 'theme_controller.dart';

class ChartWidget extends PanelComponent {
  ChartWidget() : super('ChartWidget');

  // This method is called when the component is added to the DOM.
  void init() {
    chart = Chart(nodeRoot);
    if (styleFromTheme) {
      final newStyle = loadStyleFromCss();
      if (newStyle) {
        chart!.rerender();
      }
    }
  }

  StreamSubscription<String>? themeControllerSubscription;

  Chart? chart;

  bool _styleForTheme = false;

  bool get styleFromTheme => _styleForTheme;

  set styleFromTheme(bool value) {
    _styleForTheme = value;
    onThemeChangeChartRender(this);
    if (value) {
      themeControllerSubscription =
          themeController.onThemeChange.listen((theme) {
        onThemeChangeChartRender(this);
      });
    } else {
      themeControllerSubscription?.cancel();
      themeControllerSubscription = null;
    }
  }

  void dispose() {
    themeControllerSubscription?.cancel();
  }

  @override
  void clear() {
    chart?.clear();
  }

  void renderCandleChart(List<CandleRow> data) {
    if (chart == null) {
      init();
    }
    if (styleFromTheme) {
      loadStyleFromCss();
    }
    chart?.renderCandleChart(data);
  }

  void renderLineChart(List<LineRow> data) {
    if (chart == null) {
      init();
    }
    if (styleFromTheme) {
      loadStyleFromCss();
    }
    chart?.renderLineChart(data);
  }

  // return false if node not has style
  bool loadStyleFromCss() {
    final computedMap = nodeRoot.getComputedStyle(null);

    final font = computedMap.font;
    final color = computedMap.color;
    if (font == '') {
      return false;
    }
    chart!.style
      ..font = font
      ..fontColor = color;
    return true;
  }
}

void onThemeChangeChartRender(ChartWidget chartWidget) {
  chartWidget.waitForReady().then((_) {
    if (chartWidget.chart != null) {
      final newStyle = chartWidget.loadStyleFromCss();
      if (newStyle) {
        chartWidget.chart!.rerender();
      }
    }
  });
}
