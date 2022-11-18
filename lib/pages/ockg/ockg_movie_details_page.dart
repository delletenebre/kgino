import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/ockg/ockg_movie.dart';


class OckgMovieDetailsPage extends StatelessWidget {
  final String movieId;

  const OckgMovieDetailsPage(this.movieId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        child: Text('test'),
      ),
    );
  }
}
