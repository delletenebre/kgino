import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TskgApi.getNews();

    return Scaffold(
      body: Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
    );
  }
}