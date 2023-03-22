import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import 'focusable_list_cubit/focusable_list_cubit.dart';
import 'focusable_list_cubit/focusable_list_state.dart';

class VerticalListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(
    BuildContext context, FocusNode focusNode, int index) itemBuilder;
  final void Function(bool hasFocus)? onFocusChange;

  const VerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onFocusChange,
  });

  @override
  Widget build(context) {
    return BlocProvider(
      key: ValueKey(itemCount),
      create: (context) => FocusableListCubit(
        itemCount: itemCount,
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
              onFocusChange?.call(hasFocus);

              if (hasFocus) {
                listCubit.jumpToCurrent(null);
              }
            },

            child: ListViewObserver(
              controller: focusableListState.listObserverController,
              child: ListView.builder(
                clipBehavior: Clip.antiAlias,
                controller: focusableListState.scrollController,
                itemCount: itemCount,

                /// основной контент
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: itemBuilder(
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
