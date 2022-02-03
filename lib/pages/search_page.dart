import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgino/api/tskg/tskg_api.dart';
import 'package:kgino/ui/pages/app_page.dart';
import 'package:kgino/ui/sliders/slider_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final items = <Widget>[].obs;
  final focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            enabled: true,
            readOnly: false,

            onSubmitted: (text) {
              debugPrint('onSubmitted: $text');
              focusNode.requestFocus();
            },

            onChanged: (text) async {
              items.value = [];
              items.refresh();

              final result = await TskgApi.search(text);

              final shows = result.where((item) {
                return item.url.startsWith('/show/');
              });

              items.value = shows.take(20).map((item) {
                final showId = item.url.split('/').last;

                return SliderCard(
                  posterUrl: TskgApi.getPosterUrl(showId),
                  title: item.name,
                  onTap: () {
                    Get.toNamed('/tskg/show/$showId');
                  }
                );
              }).toList(); 

              items.refresh();
            },

            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
              ),

              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
              ),

              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
              ),

              prefixIcon: Icon(Icons.search),
              
            ),
            
          ),

          Focus(
            focusNode: focusNode,
            child: const SizedBox(height: 32.0),
          ),

          Obx(() {
            return Wrap(
              spacing: 12.0,
              children: items.value,
            );
          }),
        ],
      ),



    );
  }
}