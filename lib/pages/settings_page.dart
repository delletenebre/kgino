import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kgino/ui/lists/home_page_vertical_list_view.dart';
import 'package:kgino/ui/lists/krs_horizontal_list_view2.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<List<int>> _verticalItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            _verticalItems.add(List.generate(Random().nextInt(10), (index) => index));
            setState(() {
              
            });
          },
          child: Text('+1'),
        ),

        Expanded(
          child: SizedBox(
            child: HomePageVerticalListView(
              itemCount: _verticalItems.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  child: KrsHorizontalListView2(
                    itemCount: _verticalItems[index].length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        focusColor: Colors.red,
                        onTap: () {

                        },
                        child: Container(
                          width: 100,
                          height: 120,
                          color: Colors.transparent,
                          child: Text('$index'),
                        ),
                      );
                    }
                  ),
                );
              }
            ),
          ),
        )
      ],
    );
  }
}