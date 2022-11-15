import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/ockg/ockg_bestsellers_controller.dart';
import '../../models/ockg/ockg_bestsellers_category.dart';
import '../../ui/loading_indicator.dart';

class OckgHomePage extends StatelessWidget {
  const OckgHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (BuildContext context) => OckgBestsellersController(),
      child: BlocBuilder<OckgBestsellersController, RequestState<List<OckgBestsellersCategory>>>(
        builder: (context, state) {
          if (state.success) {
            return ListView.separated(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final bestsellersCategory = state.data[index];
                return Column(
                  children: [
                    TextButton(
                      onPressed: () {

                      },
                      child: Text(bestsellersCategory.name),
                    ),

                    SizedBox.fromSize(
                      size: const Size.fromHeight(168.0 + 8.0),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: bestsellersCategory.movies.length,
                        itemBuilder: (context, index) {
                          final movie = bestsellersCategory.movies[index];
                          return Card(
                            child: Column(
                              children: [
                                Image.network('https://oc.kg${movie.cover}',
                                  width: 120.0,
                                  height: 168.0,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 24.0);
                        },
                        
                      ),
                    ),

                  ],
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
    );
  }
}
