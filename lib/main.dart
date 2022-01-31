import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kgino/app.dart';

void main() async {
  await GetStorage.init('ViewedEpisodes');

  await GetStorage.init('FavoriteShows');


  runApp(const App());
}
