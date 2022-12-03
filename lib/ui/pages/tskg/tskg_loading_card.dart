import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class TskgLoadingCard extends StatelessWidget {
  final Size posterSize;

  const TskgLoadingCard({
    super.key,
    this.posterSize = const Size(126.0, 102.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Focus(
      child: SizedBox(
        width: posterSize.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            /// постер сериала
            SizedBox.fromSize(
              size: posterSize,
              child: Center(
                child: SizedBox(
                  width: posterSize.width,
                  height: posterSize.height,
                  
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.outline.withOpacity(0.36),
                      highlightColor: Theme.of(context).colorScheme.outline,
                      child: const FittedBox(
                        child: Icon(Icons.folder,
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
