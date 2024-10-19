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

    final shadowColor = theme.colorScheme.surfaceContainerHighest;

    return Text(
      _timeString,
      style: TextStyle(
        color: theme.colorScheme.onPrimaryContainer.withAlpha(100),
        fontFeatures: const [FontFeature.tabularFigures()],
        shadows: [
          Shadow(color: shadowColor, blurRadius: 16.0),
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

  String _formatDateTime(DateTime dateTime) =>
      DateFormat('HH:mm').format(dateTime);
}
