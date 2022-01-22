import 'package:flutter/material.dart';
import 'package:kgino/ui/pages/app_page.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Text('404 not found'),
    );
  }
}