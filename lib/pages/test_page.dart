import 'package:flutter/material.dart';
import 'package:kgino/ui/pages/app_page.dart';

class TestPage extends StatelessWidget {
  final String id;

  const TestPage({
    Key? key,
    this.id = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Center(
        child: Hero(
          tag: id,
          child: Image.network('https://www.ts.kg/posters/$id.png'),
        ),
      )
    );
  }
}