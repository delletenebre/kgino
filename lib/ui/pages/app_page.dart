import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const AppPage({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: padding,
          child: Column(
            children: [

              /// невидимый элемент для возврата фокуса в начало страницы
              // const Focus(
              //   child: SizedBox(height: 16.0),
              // ),

              child,
            ],
          ),
        ),
      ),
    );
  }
}