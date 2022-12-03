import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late final List<FocusNode> _focusNodes;
  int _currentFocusableIndex = 0;

  @override
  void initState() {
    _listObserverController = ListObserverController(
      controller: ScrollController(),
    );
    _focusNodes = List.generate(widget.itemCount, (index) => FocusNode());

    super.initState();
  }
  
  @override
  void dispose() {
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _listObserverController.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {

    return Focus(
      skipTraversal: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          if (_currentFocusableIndex > 0) {
            _focusNodes[_currentFocusableIndex--].requestFocus();
          }
        }

        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          _listObserverController.jumpTo(
            index: 0,
            isFixedHeight: true,
            offset: (offset) => 0.0,
          );
          _focusNodes[0].children.first.children.first.children.first.children.first.requestFocus();
        }
      },
      child: ListViewObserver(
        controller: _listObserverController,
        child: ListView.builder(
          clipBehavior: Clip.antiAlias,
          controller: _listObserverController.controller,
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          itemCount: widget.itemCount,
          
          /// разделитель
          // separatorBuilder: (context, index) {
          //   return const SizedBox(height: 24.0);
          // },

          /// основной контент
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Focus(
                focusNode: _focusNodes[index],
                skipTraversal: true,
                onFocusChange: (hasFocus) {
                  if (hasFocus) {
                    _currentFocusableIndex = index;
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
              ),
            );
          },
        ),
      ),
    );
  }
}
