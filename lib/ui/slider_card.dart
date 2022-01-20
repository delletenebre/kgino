import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kgino/resources/app_theme.dart';

class SliderCard extends StatefulWidget {
  final String posterUrl;
  final String description;

  const SliderCard({
    Key? key,
    this.posterUrl = '',
    this.description = '',
  }) : super(key: key);

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  bool _hasFocus = false;

  static const animationDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    

    return Stack(
      children: [
        AnimatedContainer(
          duration: animationDuration,
          width: AppTheme.sliderCardSize,
          height: AppTheme.sliderCardSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              width: 2.0,
              color: _hasFocus ? Colors.white : Colors.transparent
            ),
            color: _hasFocus ? theme.scaffoldBackgroundColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: _hasFocus ? Colors.red : Colors.transparent,
                blurRadius: 64.0,
                spreadRadius: 0.0
              )
            ],
            
            
          ),

          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.0),
            child: InkWell(
              focusColor: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),

              onFocusChange: (hasFocus) {
                debugPrint('hasFocus: $hasFocus');
                setState(() {
                  _hasFocus = hasFocus;
                });

              },
              onTap: () {

              },

              child: FittedBox(
                fit: BoxFit.none,
                child: AnimatedContainer(
                  duration: animationDuration,

                  width: _hasFocus
                    ? AppTheme.sliderCardSize - 16.0
                    : AppTheme.sliderCardSize * 0.7 - 16.0,

                  decoration: BoxDecoration(
                    //color: Colors.red,
                    //borderRadius: BorderRadius.circular(16.0),
                    
                  ),
                  clipBehavior: Clip.none,
                  
                  child: Center(
                    child: CachedNetworkImage(
                        imageUrl: widget.posterUrl,
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
                ),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(widget.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              shadows: [
                Shadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 1.0,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 2.0,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.0,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 6.0,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 8.0,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}