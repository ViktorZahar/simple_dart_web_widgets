import 'dart:html';
import 'dart:math';

import 'abstract_component.dart';
import 'labels/simple_label.dart';
import 'panel.dart';

String formatDate(DateTime date) => '${date.year.toString()}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

String formatDateTime(DateTime date) => '${date.year.toString()}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')} '
    '${date.hour.toString().padLeft(2, '0')}:'
    '${date.minute.toString().padLeft(2, '0')}:'
    '${date.second.toString().padLeft(2, '0')}';

String formatDateHum(DateTime date) => '${date.day.toString().padLeft(2, '0')}.'
    '${date.month.toString().padLeft(2, '0')}.'
    '${date.year.toString()}';

String formatDateTimeHum(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}.'
    '${date.month.toString().padLeft(2, '0')}.'
    '${date.year.toString()} '
    '${date.hour.toString().padLeft(2, '0')}:'
    '${date.minute.toString().padLeft(2, '0')}:'
    '${date.second.toString().padLeft(2, '0')}';

Uri createUri(String path, Map<String, String> queryParameters) {
  final protocol = window.location.protocol;
  Uri uri;
  if (protocol == 'https:') {
    uri = Uri.https(window.location.host, path, queryParameters);
  } else {
    uri = Uri.http(window.location.host, path, queryParameters);
  }
  return uri;
}

String formatDateTimeText(DateTime date) =>
    date.toIso8601String().substring(0, 16);

String convertError(Object e) {
  if (e is String) {
    return e;
  } else if (e is ProgressEvent) {
    final t = e.target;
    if (t is HttpRequest) {
      return t.response;
    }
    return t.toString();
  } else {
    return e.toString();
  }
}

Panel labelComponent(String caption, Component comp) => Panel()
  ..fullWidth()
  ..addAll([
    SimpleLabel()
      ..caption = caption
      ..width = '50%',
    comp..width = '50%'
  ]);

int compareDynamics(dynamic a, dynamic b) {
  if (a == null && b == null) {
    return 0;
  }
  if (a == null) {
    return 1;
  }
  if (b == null) {
    return -1;
  }
  if (a is num && b is num) {
    return a.compareTo(b);
  }
  if (a is num && b is! num) {
    return 1;
  }
  if (a is! num && b is num) {
    return -1;
  }
  if (a is DateTime && b is DateTime) {
    return a.compareTo(b);
  }
  final aStr = a.toString();
  final bStr = b.toString();
  return aStr.compareTo(bStr);
}

List<String> listFromJson(List listObject) {
  final ret = <String>[];
  for (final val in listObject) {
    ret.add(val.toString());
  }
  return ret;
}

double roundDouble(double value, int places) {
  final mod = pow(10, places);
  return (value * mod).round().toDouble() / mod;
}
