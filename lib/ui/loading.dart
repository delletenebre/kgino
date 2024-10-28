import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  final double size;

  const Loading({super.key, this.size = 16.0});

  @override
  Widget build(context) {
    return Center(
      child: CupertinoActivityIndicator(radius: size),
    );
  }
}
