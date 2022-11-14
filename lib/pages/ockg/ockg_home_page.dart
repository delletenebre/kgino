import 'package:flutter/material.dart';

import '../../resources/krs_theme.dart';

class OckgHomePage extends StatelessWidget {
  const OckgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    // return ListView(
    //   children: List.generate(10, (index) {
    //     return InkWell(
    //       child: Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15.0),
    //         ),
    //         elevation: 10,
    //         child: SizedBox(
    //           width: 200,
    //           height: 60,
    //           child: Center(
    //             child: Text(
    //               'Test $index',
    //             ),
    //           ),
    //         ),
    //       ),
    //       onTap: () {},
    //     );
    //   }),
    // );
    return Column(
      children: [
        InkWell(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: const SizedBox(
              width: 200,
              height: 60,
              child: Center(
                child: Text(
                  'Test 1',
                ),
              ),
            ),
          ),
          onTap: () {},
        ),

        ElevatedButton(
          onPressed: () {
            print(1);
          },
          child: Text('test'),
        ),

        ElevatedButton(
          style: KrsTheme.filledButtonStyleOf(context),
          onPressed: () {
            print(2);
          },
          child: Text('test 2'),
        ),

        ElevatedButton(
          style: KrsTheme.filledTonalButtonStyleOf(context),
          onPressed: () {
            print(3);
          },
          child: Text('test 3'),
        ),
      ],
    );
  }
}