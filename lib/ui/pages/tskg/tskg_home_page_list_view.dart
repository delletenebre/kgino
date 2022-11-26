import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/tskg/tskg_news_controller.dart';

class TskgHomePageListView extends StatelessWidget {
  const TskgHomePageListView({
    super.key,
  });

  @override
  Widget build(context) {
    return BlocProvider(
      create: (context) => TskgNewsController(),
      child: BlocBuilder(
        builder: (context, state) {
          return SizedBox();
        },
      ),
    );
  }
}