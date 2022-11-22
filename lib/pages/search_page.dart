import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('build SearchPage');
    
    return Center(
      child: OutlinedButton(
        onPressed: () {

        },
        child: Text('Найти'),
      ),
    );
  }
}