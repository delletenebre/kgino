import 'package:flutter/material.dart';

class KikaScrollView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final ScrollController scrollController;
  final Function(ScrollMetrics scrollMetrics)? onStartScroll;
  final Function(ScrollMetrics scrollMetrics)? onUpdateScroll;
  final Function(ScrollMetrics scrollMetrics)? onEndScroll;

  const KikaScrollView({
    super.key,
    required this.children,
    this.padding,
    this.physics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
    required this.scrollController,
    this.onStartScroll,
    this.onUpdateScroll,
    this.onEndScroll,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (scrollNotification is ScrollStartNotification) {
            onStartScroll?.call(scrollNotification.metrics);
          } else if (scrollNotification is ScrollUpdateNotification) {
            onUpdateScroll?.call(scrollNotification.metrics);
          } else if (scrollNotification is ScrollEndNotification) {
            onEndScroll?.call(scrollNotification.metrics);
          }
        });

        return false;
      },
      child: SingleChildScrollView(
        controller: scrollController,
        padding: padding,
        physics: physics,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
