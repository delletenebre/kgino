import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeView extends StatefulWidget {
  const TimeView({super.key});

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  String _timeString = '';
  late Timer _timer;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _getTime());
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    return Text(
      _timeString,
      style: TextStyle(
        color: theme.colorScheme.onSurfaceVariant,
        fontFeatures: const [
          FontFeature.tabularFigures(),
        ],
        shadows: [
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 4.0,
          ),
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 8.0,
          ),
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 12.0,
          ),
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 24.0,
          ),
          Shadow(
            color: theme.colorScheme.surfaceContainerHighest,
            blurRadius: 48.0,
          ),
        ],
      ),
    );
  }

  void _getTime() {
    final now = DateTime.now();
    final formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
