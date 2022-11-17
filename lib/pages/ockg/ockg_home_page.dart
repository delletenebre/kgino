import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../models/ockg/ockg_bestsellers_category.dart';
import '../../ui/loading_indicator.dart';
import '../../ui/pages/ockg/ockg_bestsellers_category_list.dart';

class OckgHomePage extends StatelessWidget {
  const OckgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.black.withOpacity(0.12),
          ),
        ),

        SizedBox(
          height: 252.0,
          child: BlocProvider(
            create: (BuildContext context) => OckgBestsellersController(),
            child: BlocBuilder<OckgBestsellersController, RequestState<List<OckgBestsellersCategory>>>(
              builder: (context, state) {
                if (state.success) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final bestsellersCategory = state.data[index];
                      
                      return OckgBestsellersCategoryList(
                        category: bestsellersCategory,
                        onMovieFocused: (movie) {
                          
                        }
                      );
                      
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 24.0);
                    },
                    
                  );
                }

                return const LoadingIndicator(
                  color: Colors.lightBlueAccent
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}
