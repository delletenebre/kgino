import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/resources/app_theme.dart';
import 'package:kgino/ui/sliders/slider_card_badge.dart';
import 'package:kgino/ui/sliders/slider_text.dart';

class SliderCard extends StatefulWidget {
  final String posterUrl;
  final String title;
  final String description;
  final List<TskgBagdeType> badges;
  final Function()? onTap;
  final FocusNode? focusNode;

  const SliderCard({
    Key? key,
    this.posterUrl = '',
    this.title = '',
    this.description = '',
    this.badges = const [],
    this.onTap,
    this.focusNode,
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
        child: badge.content(
          size: _hasFocus ? 14.0 : 12.0,
        ),
        color: badge.color(),
        size: _hasFocus ? 14.0 : 12.0,
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
              focusNode: widget.focusNode,
              focusColor: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),

              /// действие при смене состояния фокуса
              onFocusChange: (hasFocus) {
                setState(() {
                  _hasFocus = hasFocus;
                });
              },

              /// обработчик нажатия на карточку слайдера
              onTap: widget.onTap,

              child: Center(
                child: AnimatedContainer(
                  duration: animationDuration,

                  width: _hasFocus
                    ? AppTheme.sliderCardSize - 16.0
                    : AppTheme.sliderCardSize * 0.7 - 16.0,
                  
                  child: Stack(
                    alignment: Alignment.center,
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


        /// нижняя подпись (название, номер серии)
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SliderText(
                text: widget.description,
                fontSize: 12.0,
              ),

              SliderText(
                text: widget.title,
                fontSize: 14.0,
              ),

            ],
          )
        ),

      ],
    );
  }
}