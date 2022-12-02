import 'package:flutter/material.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class KrsVerticalListView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const KrsVerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<KrsVerticalListView> createState() => _KrsVerticalListViewState();
}

class _KrsVerticalListViewState extends State<KrsVerticalListView> {
  late final ListObserverController _listObserverController;

  @override
  void initState() {
    _listObserverController = ListObserverController(
      controller: ScrollController(),
    );

    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(context) {

    return ListViewObserver(
      controller: _listObserverController,
      child: ListView.separated(
        clipBehavior: Clip.antiAlias,
        controller: _listObserverController.controller,
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        scrollDirection: Axis.vertical,
        itemCount: widget.itemCount,
        
        /// разделитель
        separatorBuilder: (context, index) {
          return const SizedBox(height: 24.0);
        },

        /// основной контент
        itemBuilder: (context, index) {
          return Focus(
            skipTraversal: true,
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                _listObserverController.animateTo(
                  index: index,
                  isFixedHeight: true,
                  offset: (offset) => 0.0,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.easeIn
                );
              }
            },
            child: widget.itemBuilder(context, index),
          );
        },
      ),
    );
  }
}
