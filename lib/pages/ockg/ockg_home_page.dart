import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../api/ockg_api_provider.dart';
import '../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../models/request_state.dart';
import '../../resources/krs_theme.dart';
import '../../ui/loading_indicator.dart';

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
    return BlocProvider(
      create: (BuildContext context) => OckgBestsellersController(),
      child: BlocBuilder<OckgBestsellersController, RequestState>(
        builder: (context, state) {
          if (state.success) {
            return SizedBox.square(
              dimension: 300,
              child: ColoredBox(color: Colors.red),
            );
          }

          return const LoadingIndicator(
            color: Colors.lightBlueAccent
          );
        }
      ),
    );
    
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextButton(
          onPressed: () {

          },
          child: Text('Новинки'),
        ),

        // ElevatedButton(
        //   onPressed: () {
        //     print(1);
        //   },
        //   child: Text('test'),
        // ),

        // ElevatedButton(
        //   style: KrsTheme.filledButtonStyleOf(context),
        //   onPressed: () {
        //     print(2);
        //   },
        //   child: Text('test 2'),
        // ),

        // ElevatedButton(
        //   style: KrsTheme.filledTonalButtonStyleOf(context),
        //   onPressed: () {
        //     print(3);
        //   },
        //   child: Text('test 3'),
        // ),
      ],
    );
  }
}