import 'package:flutter/material.dart';
import 'package:kgino/resources/app_theme.dart';

class TskgSlider extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const TskgSlider({
    Key? key,
    this.title = '',
    this.items = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    /// слайдер
    Widget child = SizedBox(
      height: AppTheme.sliderCardSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items,
        clipBehavior: Clip.none,
      ),
    );
  
    if (title.isNotEmpty) {
      /// ^ если был передан заголовок
      
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: theme.textTheme.headline6,
          ),
          child,
        ],
      );
    }


    return child;
  }
}