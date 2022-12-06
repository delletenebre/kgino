import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../controllers/list_cubit/focusable_list_cubit.dart';
import '../../controllers/list_cubit/focusable_list_state.dart';

class HomePageVerticalListView2 extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, FocusNode focusNode, int index) itemBuilder;

  const HomePageVerticalListView2({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<HomePageVerticalListView2> createState() => _HomePageVerticalListView2State();
}

class _HomePageVerticalListView2State extends State<HomePageVerticalListView2> {
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
              if (hasFocus) {
                listCubit.jumpToCurrent();
              }
            },
            child: ListViewObserver(
              controller: focusableListState.listObserverController,
              child: ListView.builder(
                clipBehavior: Clip.antiAlias,
                controller: focusableListState.scrollController,
                padding: const EdgeInsets.symmetric(vertical: 32.0),
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
