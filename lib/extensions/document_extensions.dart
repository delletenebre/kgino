import 'package:html/dom.dart';

extension DocumentExtensions on Document {
  String getTextByClassName(String className) {
    final elements = getElementsByClassName(className);
    if (elements.isNotEmpty) {
      return elements.first.text.trim();
    }

    return '';
  }
}
