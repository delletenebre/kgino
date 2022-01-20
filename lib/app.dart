import 'package:flutter/material.dart';
import 'package:kgino/pages/home_page.dart';
import 'package:kgino/resources/app_theme.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: AppTheme.dark,
    );
  }
}