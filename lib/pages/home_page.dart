import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../controllers/tabs_cubit.dart';
import 'cameras_page.dart';
import 'error_page.dart';
import 'movies_page.dart';
import 'search_page.dart';
import 'shows_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tabsCubit = GetIt.instance<TabsCubit>();

    return BlocProvider(
      create: (_) => tabsCubit,
      child: BlocBuilder<TabsCubit, int>(
        builder: (context, selectedIndex) {
          switch (selectedIndex) {
            case 0:
              return const SearchPage();
            case 1:
              return const MoviesPage();
            case 2:
              return const ShowsPage();
            case 3:
              return const CamerasPage();
              
            default:
              return const ErrorPage();
          }
        },
      ),
    );
  }
}