import 'package:flutter/material.dart';
import 'package:kgino/ui/pages/app_page.dart';

class TvShowPage extends StatelessWidget {
  final String id;

  const TvShowPage({
    Key? key,
    this.id = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Container(
        child: Text(id)
      ),
    );
  }
}