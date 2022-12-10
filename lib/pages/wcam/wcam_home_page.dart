// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../constants.dart';
// import '../../controllers/tskg/tskg_show_details_controller.dart';
// import '../../models/category_list_item.dart';
// import '../../models/movie_item.dart';
// import '../../ui/lists/krs_vertical_list_view.dart';

// class WcamHomePage extends StatelessWidget {
//   const WcamHomePage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TskgNewsController(),
//       child: Builder(
//         builder: (context) {
//           final state = context.watch<TskgNewsController>().state;

//           if (state.isLoading) {
//             return const LoadingIndicator();
//           }

//           final showList = <CategoryListItem<MovieItem>>[];

//           if (seenShows.isNotEmpty) {
//             showList.add(
//               CategoryListItem<MovieItem>(
//                 title: locale.continueWatching,
//                 items: seenShows,
//               )
//             );
//           }

//           if (favoriteShows.isNotEmpty) {
//             showList.add(
//               CategoryListItem<MovieItem>(
//                 title: locale.favorites,
//                 items: favoriteShows,
//               )
//             );
//           }

//           if (state.isSuccess) {
//             final news = state.data;

//             /// за сколько дней показывать последние добавления
//             const lastAddedDays = 2;
            
//             /// сериалы сгруппированные по дате добавления
//             final showsGroupedByDate = groupBy(
//               news,
//               (item) => item.updatedAt,
//             );

//             for (int index = 0; index < lastAddedDays; index++) {
//               final date = showsGroupedByDate.keys.elementAt(index);
                
//               late final String titleText;
//               if (date.isToday) {
//                 titleText = locale.addedDate('today');
//               } else if (date.isYesterday) {
//                 titleText = locale.addedDate('yesterday');
//               } else {
//                 titleText = locale.addedDate(Jiffy(date).MMMMd);
//               }

//               final shows = showsGroupedByDate.values.elementAt(index);

//               showList.add(
//                 CategoryListItem<MovieItem>(
//                   title: titleText,
//                   items: shows,
//                 )
//               );

//             }
//           }

//           if (showList.isNotEmpty) {
//             return KrsVerticalListView(
//               itemCount: showList.length,
//               itemBuilder: (context, focusNode, index) {
//                 final showItem = showList[index];

//                 return SizedBox.fromSize(
//                   size: const Size.fromHeight(tskgListViewHeight + 16.0),
//                   child: KrsHorizontalListView(
//                     focusNode: focusNode,
//                     onItemFocused: (index) {
//                       context.read<TskgShowDetailsController>().getShowById(
//                         showItem.items[index].id,
//                       );
//                     },
//                     titleText: showItem.title,
//                     itemCount: showItem.items.length,
//                     itemBuilder: (context, focusNode, index) {
//                       final show = showItem.items.elementAt(index);
                      
//                       return KrsListItemCard(
//                         focusNode: focusNode,
//                         item: show,
                        
//                         /// при выб оре элемента
//                         onTap: () {
//                           /// переходим на страницу деталей о сериале
//                           context.goNamed('tskgShowDetails',
//                             params: {
//                               'id': show.id,
//                             },
//                           );

//                         },
//                       );
//                     },
//                   ),
//                 );
//               },
              
//             );
//           }

//           return const LoadingIndicator();
//         },
//       ),
//     );
//   }
// }