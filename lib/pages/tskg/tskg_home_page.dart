import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../controllers/tskg/tskg_show_details_controller.dart';
import '../../models/tskg/tskg_show.dart';
import '../../ui/pages/tskg/tskg_home_page_list_view.dart';
import '../../ui/pages/tskg/tskg_show_details.dart';

class TskgHomePage extends StatelessWidget {
  const TskgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TskgShowDetailsController(),
      child: Column(
        children: [
          /// детали фильма, при фокусе на каком-либо фильме
          /// или первый популярный фильм, если ничего не выбрано
          Expanded(
            child: BlocBuilder<TskgShowDetailsController, RequestState<TskgShow>>(
              builder: (context, state) {
                if (state.isSuccess) {
                  final show = state.data;

                  return TskgShowDetais(
                    show: show,
                  );

                }

                return const SizedBox();
              }
            ),
          ),

          /// список фильмов внизу страницы
          SizedBox.fromSize(
            size: const Size.fromHeight(tskgListViewHeight + 80.0),
            child: const TskgHomePageListView(),
          )
        ],
      ),
    );
  }
}