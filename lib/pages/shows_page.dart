import 'package:flutter/material.dart';

import '../ui/lists/horizontal_list_view.dart';

class ShowsPage extends StatelessWidget {
  const ShowsPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: HorizontalListView(
            itemCount: 20,
          ),
        ),
        SizedBox(
          height: 120,
          child: HorizontalListView(
            itemCount: 20,
          ),
        ),
        SizedBox(
          height: 120,
          child: HorizontalListView(
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
