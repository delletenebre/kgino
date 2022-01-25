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
    final scrollController = ScrollController();
    
    /// слайдер
    Widget child = SizedBox(
      height: AppTheme.sliderCardSize,
      child: RawScrollbar(
        thumbColor: theme.colorScheme.primary.withOpacity(0.5),
        controller: scrollController,
        thickness: 1.0,
        radius: const Radius.circular(2.0),
        isAlwaysShown: true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,

            /// убираем срезание вне элемента для эффекта свечения элемента,
            /// который находится в фокусе
            clipBehavior: Clip.none,
            
            children: items,
          ),
        ),
      ),
    );
  
    if (title.isNotEmpty) {
      /// ^ если был передан заголовок
      
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          /// название списка
          Text(title,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),

          child,
          
        ],
      );
    }


    return child;
  }
}