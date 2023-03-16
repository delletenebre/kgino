import 'package:flutter/material.dart';

import 'ui/krs_bottom_sheet_content.dart';

class Utils {
  static Duration parseDuration(String time) {
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    final parts = time.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    seconds = int.parse(parts[parts.length - 1]);
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

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

extension DateUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}

extension DurationUtils on Duration {
  String get formatted {
    var seconds = inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds~/Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    int minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];

    if (days != 0) {
      tokens.add('$days д');
    }

    if (tokens.isNotEmpty || hours != 0){
      tokens.add('$hours ч');
    }

    if (tokens.isNotEmpty || minutes != 0) {
      if (seconds > 30) {
        minutes++;
      }
      if (tokens.isNotEmpty) {
        tokens.add('$minutes м');
      } else {
        tokens.add('$minutes мин');
      }
      
    }

    // if (hours == 0 && seconds > 0) {
    //   tokens.add('$seconds с');
    // }

    if (tokens.isEmpty) {
      tokens.add('$seconds с');
    }

    return tokens.join(' ');
  }

}
