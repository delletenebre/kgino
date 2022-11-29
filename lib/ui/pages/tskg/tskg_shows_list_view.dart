// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';

// import '../../../constants.dart';
// import '../../../models/tskg/tskg_show.dart';
// import '../../lists/krs_list_view.dart';
// import 'tskg_show_card.dart';

// class TskgShowsListView extends StatefulWidget {
//   final bool autofocus;
//   final List<TskgShow> shows;
//   final List<FocusNode>? focusNodes;
//   final void Function(TskgShow show) onShowFocused;
//   final void Function() onScrollEnd;
//   final EdgeInsetsGeometry? padding;
//   final String titleText;

//   const TskgShowsListView({
//     super.key,
//     this.autofocus = false,
//     this.focusNodes,
//     required this.shows,
//     required this.onShowFocused,
//     required this.onScrollEnd,
//     this.padding = const EdgeInsets.symmetric(horizontal: 32.0),
//     this.titleText = '',
//   });

//   @override
//   State<TskgShowsListView> createState() => _TskgShowsListViewState();
// }

// class _TskgShowsListViewState extends State<TskgShowsListView> {

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return SizedBox.fromSize(
//       size: const Size.fromHeight(tskgListViewHeight),
//       child: KrsListView(
//         onItemFocused: (index) {
//           widget.onShowFocused.call(widget.shows[index]);
//         },
//         titleText: widget.titleText,
//         itemCount: widget.shows.length,
//         itemBuilder: (context, index) {
//           final show = widget.shows[index];

//           return TskgShowCard(
//             show: show,
            
//             /// при выборе элемента
//             onTap: () {
//               /// переходим на страницу деталей о фильме
//               context.goNamed('tskgShowDetails', params: {
//                 'id': show.showId,
//               });

//             },
//           );
//         },
//       ),
//     );
//   }
// }
