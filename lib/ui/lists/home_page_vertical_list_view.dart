import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../utils.dart';

class HomePageVerticalListView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const HomePageVerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<HomePageVerticalListView> createState() => _HomePageVerticalListViewState();
}

class _HomePageVerticalListViewState extends State<HomePageVerticalListView> {
  late final ListObserverController _listObserverController;
  int _currentFocusableIndex = 0;

  final _focusNode = FocusNode();

  @override
  void initState() {
    _listObserverController = ListObserverController(
      controller: ScrollController(),
    );

    super.initState();
  }
  
  @override
  void dispose() {
    _focusNode.dispose();
    
    _listObserverController.controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomePageVerticalListView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(context) {
    
    return Focus(
      focusNode: _focusNode,
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          if (_currentFocusableIndex > 0) {
            _currentFocusableIndex--;

            _listObserverController.animateTo(
              index: _currentFocusableIndex,
              isFixedHeight: true,
              offset: (offset) => 0.0,
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeIn
            );

            _focusNode.focusableChildAt(_currentFocusableIndex)?.requestFocus();

            return KeyEventResult.handled;
          }
        }

        if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          if (_currentFocusableIndex < widget.itemCount - 1) {
            _currentFocusableIndex++;

            _listObserverController.animateTo(
              index: _currentFocusableIndex,
              isFixedHeight: true,
              offset: (offset) => 0.0,
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeIn
            );

            _focusNode.focusableChildAt(_currentFocusableIndex)?.requestFocus();

            return KeyEventResult.handled;
          }
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          try {
            _listObserverController.jumpTo(
              index: _currentFocusableIndex,
              isFixedHeight: true,
              offset: (offset) => 0.0,
            );
            
            /// берём в фокус первый элемент в списке
            _focusNode.focusableChildAt(_currentFocusableIndex)?.requestFocus();

          } catch (exception) {
            debugPrint('exception: $exception');
          }
          
        }
      },
      child: ListViewObserver(
        controller: _listObserverController,
        child: ListView(
          controller: _listObserverController.controller,
          children: List.generate(widget.itemCount, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: widget.itemBuilder(context, index),
            );
          }),
        ),
        // child: ListView.builder(
        //   clipBehavior: Clip.antiAlias,
        //   controller: _listObserverController.controller,
        //   padding: const EdgeInsets.symmetric(vertical: 32.0),
        //   itemCount: widget.itemCount,
          
        //   /// разделитель
        //   // separatorBuilder: (context, index) {
        //   //   return const SizedBox(height: 24.0);
        //   // },

        //   /// основной контент
        //   itemBuilder: (context, index) {
        //     return Padding(
        //       padding: const EdgeInsets.only(bottom: 24.0),
        //       child: Focus(
        //         canRequestFocus: false,
        //         skipTraversal: true,
        //         onFocusChange: (hasFocus) {
        //           if (hasFocus) {
        //             _currentFocusableIndex = index;
        //             _listObserverController.animateTo(
        //               index: index,
        //               isFixedHeight: true,
        //               offset: (offset) => 0.0,
        //               duration: const Duration(milliseconds: 50),
        //               curve: Curves.easeIn
        //             );
        //           }
        //         },
        //         child: widget.itemBuilder(context, index),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
