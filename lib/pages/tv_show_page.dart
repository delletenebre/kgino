import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg.dart';
import 'package:kgino/ui/pages/app_page.dart';

class TvShowPage extends StatelessWidget {
  final String id;
  final String heroTag;

  const TvShowPage({
    Key? key,
    this.id = '',
    this.heroTag = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        children: [
          Hero(
            tag: heroTag,
            child: CachedNetworkImage(
              imageUrl: Tskg.getPosterUrl(id),
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return CircularProgressIndicator(
                  value: downloadProgress.progress
                );
              },
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
            ),
          ),

          Text(heroTag)
        ],
      ),
    );
  }
}