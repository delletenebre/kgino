import 'package:flutter/material.dart';

class SliderTitle extends StatelessWidget {
  final String title;
  
  const SliderTitle(this.title, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
    );
  }
}