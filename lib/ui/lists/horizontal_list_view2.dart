// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:scrollview_observer/scrollview_observer.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
// import '../../models/media_item.dart';
// import '../../resources/krs_theme.dart';
// import '../cards/media_item_card.dart';
//
// // @riverpod
// // Object? focusNodes(ExampleRef ref) async {
// //   // Wait for a user to be available, and listen to only the "firstName" property
// //   final firstName = await ref.watch(
// //     userProvider.selectAsync((it) => it.firstName),
// //   );
// //
// //   // TODO use "firstName" to fetch something else
// // }
//
// class HorizontalListView<T> extends StatefulHookWidget {
//   final ListObserverController? listObserverController;
//   final Future<List<T>>? asyncItems;
//   final Widget Function(BuildContext context, T item) itemBuilder;
//   const HorizontalListView({
//     super.key,
//     this.listObserverController,
//     this.asyncItems,
//     required this.itemBuilder,
//   });
//
//   @override
//   State<HorizontalListView<T>> createState() => _HorizontalListViewState<T>();
// }
//
// class _HorizontalListViewState<T> extends State<HorizontalListView<T>> {
//   late final ListObserverController observerController;
//
//   final padding =
//       EdgeInsets.symmetric(horizontal: KrsTheme.safeArea.horizontal);
//
//   List<FocusNode> focusNodes = [];
//   int lastFocusedItem = 0;
//
//   int itemCount = 0;
//
//   @override
//   void initState() {
//     observerController = widget.listObserverController ??
//         ListObserverController(controller: ScrollController());
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     observerController.controller?.dispose();
//     for (final focusNode in focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   /// переходим к предыдущему элементу
//   void goPrevious() {
//     if (lastFocusedItem > 0) {
//       lastFocusedItem--;
//       animateToCurrent();
//     }
//   }
//
//   /// переходим к следующему элементу
//   void goNext() {
//     if (lastFocusedItem < itemCount - 1) {
//       lastFocusedItem++;
//       animateToCurrent();
//     }
//   }
//
//   /// переход к элементу без анимации
//   void jumpTo(int index) {
//     observerController.jumpTo(
//       index: index,
//       isFixedHeight: true,
//       offset: (offset) => padding.left,
//       padding: padding,
//     );
//     requestFocus(index);
//   }
//
//   /// переход к последнему выделенному элементу без анимации
//   void jumpToCurrent() => jumpTo(lastFocusedItem);
//
//   /// плавный переход к элементу
//   void animateTo(int index) {
//     requestFocus(index);
//     observerController.animateTo(
//       index: index,
//       isFixedHeight: true,
//       offset: (offset) => padding.left,
//       duration: const Duration(milliseconds: 180),
//       curve: Curves.easeIn,
//       padding: padding,
//     );
//   }
//
//   /// плавный переход к последнему выделенному элементу
//   void animateToCurrent() => animateTo(lastFocusedItem);
//
//   void requestFocus(int index) {
//     focusNodeAt(index).children.firstOrNull?.requestFocus();
//   }
//
//   FocusNode focusNodeAt(int index) => focusNodes[index];
//
//   @override
//   Widget build(context) {
//     final asyncItemsReader = useMemoized(() => widget.asyncItems);
//     final snapshot = useFuture(asyncItemsReader);
//
//     if (!snapshot.hasData && !snapshot.hasError) {
//       return Skeletonizer(
//         enabled: true,
//         child: ListView.separated(
//           padding: padding,
//           clipBehavior: Clip.none,
//           scrollDirection: Axis.horizontal,
//           separatorBuilder: (context, index) => const SizedBox(width: 20.0),
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             return MediaItemCard(
//               mediaItem: MediaItem.skeleton(),
//               onTap: () {},
//             );
//           },
//         ),
//       );
//     }
//
//     List<T> items = snapshot.data ?? [];
//
//     if (items.isEmpty) {
//       return const SizedBox();
//     }
//
//     itemCount = items.length;
//     focusNodes = List.generate(
//       itemCount,
//       (index) => FocusNode(),
//     );
//
//     return Focus(
//       skipTraversal: true,
//       onKey: (node, event) {
//         if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
//           goPrevious();
//           return KeyEventResult.handled;
//         }
//
//         if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
//           goNext();
//           return KeyEventResult.handled;
//         }
//
//         return KeyEventResult.ignored;
//       },
//       onFocusChange: (hasFocus) {
//         if (hasFocus) {
//           jumpToCurrent();
//         }
//       },
//       child: ListViewObserver(
//         controller: observerController,
//         triggerOnObserveType: ObserverTriggerOnObserveType.directly,
//         child: ScrollConfiguration(
//           behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
//           child: ListView.separated(
//             controller: observerController.controller,
//             padding: padding,
//             clipBehavior: Clip.none,
//             scrollDirection: Axis.horizontal,
//             separatorBuilder: (context, index) => const SizedBox(width: 20.0),
//             itemCount: itemCount,
//             itemBuilder: (context, index) {
//               return Focus(
//                 focusNode: focusNodeAt(index),
//                 child: widget.itemBuilder(context, items[index]),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
