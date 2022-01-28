import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kgino/app.dart';

void main() async {
  await GetStorage.init('viewedEpisodes');

  runApp(const App());
}
