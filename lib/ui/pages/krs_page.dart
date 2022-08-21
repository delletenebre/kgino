import 'package:flutter/material.dart';

class KrsPage extends StatelessWidget {
  final Widget child;
  
  const KrsPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}