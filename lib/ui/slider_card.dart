import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg.dart';
import 'package:kgino/resources/app_theme.dart';
import 'package:kgino/ui/slider_card_badge.dart';

class SliderCard extends StatefulWidget {
  final String posterUrl;
  final String description;
  final List<TskgBagdeType> badges;

  const SliderCard({
    Key? key,
    this.posterUrl = '',
    this.description = '',
    this.badges = const [],
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

    final _badges = widget.badges.map((badge) {
      return SliderCardBadge(
        icon: badge.icon(),
        color: badge.color(),
        size: _hasFocus ? 12.0 : 8.0,
      );
    }).toList();
    

    return Stack(
      children: [

        /// основной контент (постер)
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

              child: Center(
                child: AnimatedContainer(
                  duration: animationDuration,

                  width: _hasFocus
                    ? AppTheme.sliderCardSize - 16.0
                    : AppTheme.sliderCardSize * 0.7 - 16.0,

                  decoration: BoxDecoration(
                    //color: Colors.red,
                    //borderRadius: BorderRadius.circular(16.0),
                    
                  ),
                  
                  child: Stack(
                    clipBehavior: Clip.none,

                      children: [

                        CachedNetworkImage(
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
                      
                        Positioned(
                          top: -12.0,
                          left: 0.0,
                          right: 0.0,
                          child: Wrap(
                            spacing: 4.0,
                            children: _badges,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ),
        ),

        /// верхняя строка (значки (badges))
        // Positioned(
        //   top: 8.0,
        //   left: 8.0,
        //   right: 8.0,
        //   child: widget.topLine,
        // ),
        

        /// нижняя подпись (название, номер серии)
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(widget.description,
            style: TextStyle(
              fontSize: 10.0,
              shadows: [
                Shadow(
                  color: theme.bottomAppBarColor,
                ),
                Shadow(
                  blurRadius: 2.0,
                  color: theme.bottomAppBarColor,
                ),
                Shadow(
                  blurRadius: 4.0,
                  color: theme.bottomAppBarColor,
                ),
                Shadow(
                  blurRadius: 6.0,
                  color: theme.bottomAppBarColor,
                ),
                Shadow(
                  blurRadius: 8.0,
                  color: theme.bottomAppBarColor,
                ),
                Shadow(
                  blurRadius: 10.0,
                  color: theme.bottomAppBarColor,
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}