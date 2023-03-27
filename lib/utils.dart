import 'package:flutter/material.dart';

import 'ui/krs_bottom_sheet_content.dart';

class Utils {
  static Future<T?> showModal<T>({
    required BuildContext context,
    String titleText = '',
    required Widget child,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      constraints: const BoxConstraints(
        minWidth: 480.0,
        maxWidth: 480.0,
      ),
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.2,
          maxChildSize: 0.75,
          expand: false,
          builder: (_, controller) => KrsBottomSheetContent(
            titleText: titleText,
            child: child,
          ),
        );
      },
    );
  }
}