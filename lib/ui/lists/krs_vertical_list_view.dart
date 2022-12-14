import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../controllers/list_cubit/focusable_list_cubit.dart';
import '../../controllers/list_cubit/focusable_list_state.dart';

class KrsVerticalListView extends StatefulWidget {
  final int itemCount;
  final Widget Function(
    BuildContext context, FocusNode focusNode, int index) itemBuilder;
  final void Function(bool hasFocus)? onFocusChange;

  const KrsVerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onFocusChange,
  });

  @override
  State<KrsVerticalListView> createState() => _KrsVerticalListViewState();
}

class _KrsVerticalListViewState extends State<KrsVerticalListView> {
 @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  

  @override
  Widget build(context) {
    
    return BlocProvider(
      key: ValueKey(widget.itemCount),
      create: (context) => FocusableListCubit(
        itemCount: widget.itemCount,
      ),
      child: BlocBuilder<FocusableListCubit, FocusableListState>(
        builder: (context, focusableListState) {
          final listCubit = context.read<FocusableListCubit>();

          return Focus(
            skipTraversal: true,
            onKey: (node, event) {
              if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
                return listCubit.goPrevious();
              }

              if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                return listCubit.goNext();
              }

              return KeyEventResult.ignored;
            },
            onFocusChange: (hasFocus) {
              widget.onFocusChange?.call(hasFocus);

              if (hasFocus) {
                listCubit.jumpToCurrent(null);
              }
            },
            child: ListViewObserver(
              controller: focusableListState.listObserverController,
              child: ListView.builder(
                clipBehavior: Clip.antiAlias,
                controller: focusableListState.scrollController,
                itemCount: widget.itemCount,

                /// основной контент
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: widget.itemBuilder(
                      context, listCubit.focusNodeAt(index), index),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
