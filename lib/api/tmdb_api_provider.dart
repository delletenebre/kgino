import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tmdb_api/tmdb_api.dart';

part 'tmdb_api_provider.g.dart';

@Riverpod(keepAlive: true)
TmdbApi tmdbApi(TmdbApiRef ref) => TmdbApi(ref);

class TmdbApi {
  final TmdbApiRef ref;
  late final TMDB tmdb;

  TmdbApi(this.ref) {
    tmdb = TMDB(
      ApiKeys(
        '5e2d902fe9f3d1307e3f2e742b52e631',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZTJkOTAyZmU5ZjNkMTMwN2UzZjJlNzQyYjUyZTYzMSIsIm5iZiI6MTcyMzU0MzU0MC40ODQzMjksInN1YiI6IjYzNzkyMmQ1OTc2ZTQ4MDBkY2Q5NDBhNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rujgHr1qBSJ9gnevLd_1wOr-f5ZkN3Mkqw-LM1tDUWA',
      ),
      defaultLanguage: 'ru-RU',
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
        showInfoLogs: true,
        showUrlLogs: true,
      ),
    );
  }
}
