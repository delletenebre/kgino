import 'package:flutter/material.dart';

class KrsScrollView extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Function(ScrollMetrics scrollMetrics)? onStartScroll;
  final Function(ScrollMetrics scrollMetrics)? onUpdateScroll;
  final Function(ScrollMetrics scrollMetrics)? onEndScroll;

  const KrsScrollView({
    Key? key,
    required this.children,
    this.padding,
    this.physics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
    this.scrollController,
    this.onStartScroll,
    this.onUpdateScroll,
    this.onEndScroll,
  }) : super(key: key);

  @override
  State<KrsScrollView> createState() => _KrsScrollViewState();
}

class _KrsScrollViewState extends State<KrsScrollView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollStartNotification) {
          widget.onStartScroll?.call(scrollNotification.metrics);
        } else if (scrollNotification is ScrollUpdateNotification) {
          widget.onUpdateScroll?.call(scrollNotification.metrics);
        } else if (scrollNotification is ScrollEndNotification) {
          widget.onEndScroll?.call(scrollNotification.metrics);
        }
        return false;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: widget.padding,
        physics: widget.physics,
        child: Column(
          children: widget.children,
        ),
      ),
    );
  }
}