import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kgino/ui/lists/home_page_vertical_list_view.dart';
import 'package:kgino/ui/lists/krs_horizontal_list_view2.dart';

import '../ui/lists/home_page_vertical_list_view2.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<List<int>> _items = [
    [1, 4, 7, 8, 4, 6, 7, 8, 8 , 2, 3, 4],
    [2, 3, 5, 9, 1, 2, 2, 5],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            _items.insert(0, [4]);
            setState(() {
              
            });
          },
          child: Text('+1'),
        ),

        TextButton(
          onPressed: () {
            _items.removeAt(0);
            setState(() {
              
            });
          },
          child: Text('-1'),
        ),

        // Expanded(
        //   child: SizedBox(
        //     child: HomePageVerticalListView2(
        //       itemCount: _items.length,
        //       itemBuilder: (context, index) {
        //         return Container(
        //           height: 50,
        //           child: KrsHorizontalListView2(
        //             key: ValueKey(index),
        //             itemCount: _items[index].length,
        //             itemBuilder: (context, index) {
        //               return InkWell(
        //                 focusColor: Colors.red,
        //                 onTap: () {

        //                 },
        //                 child: Container(
        //                   width: 100,
        //                   height: 120,
        //                   color: Colors.transparent,
        //                   child: Text('$index'),
        //                 ),
        //               );
        //             }
        //           ),
        //         );
        //       }
        //     ),
        //   ),
        // )
      ],
    );
  }
}