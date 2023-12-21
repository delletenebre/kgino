import 'package:collection/collection.dart';
import 'package:html/parser.dart';

import '../enums/online_service.dart';
import '../extensions/string_extensions.dart';
import '../models/media_item_episode.dart';
import '../models/media_item_season.dart';
import '../models/tskg/tskg_item.dart';
import '../models/voice_acting.dart';
import 'tskg_api_provider.dart';

Future<TskgItem> parseDetails(html) async {
  /// парсим html
  final document = parse(html);

  /// парсим идентификатор сериала
  final showIdUrl = document
      .getElementsByClassName('episode')
      .firstOrNull
      ?.attributes['href'];
  final showId = TskgItem.getShowIdFromUrl(showIdUrl ?? '');

  /// парсим название сериала
  final title = document.getElementById('h-show-title')?.text ?? '';

  /// парсим название на языке оригинала
  final originalTitle =
      TskgApi.getTextByClassName(document, 'app-show-header-title-original');

  /// парсим года выпуска сериала
  /// убираем 'завершён/закрыт' из '2001-2010, завершён/закрыт'
  final years = TskgApi.getTextByClassName(document, 'app-show-header-years')
      .split(', ')
      .first;

  /// парсим страны, жанры
  final tags = document
      .getElementsByClassName('app-show-tags')
      .last
      .getElementsByTagName('a');

  final genres = tags
      .where((element) {
        /// получаем атрибут href
        final href = element.attributes['href'] ?? '';

        /// находим только те элементы, которые указывают жанр сериала
        return href.startsWith('/genre');
      })
      .map((element) => element.text)
      .toList();

  /// формируем список стран
  final countries =
      document.getElementsByClassName('app-show-tags-flag').map((element) {
    /// получаем название страны
    final countryName = element.attributes['title'] ?? '';

    if (countryName == 'Российская Федерация') {
      return 'Россия';
    }

    return countryName;
  }).toList();

  /// парсим описание сериала
  final description =
      TskgApi.getTextByClassName(document, 'app-show-description');

  /// парсим список сезонов
  final seasonElements =
      document.getElementsByClassName('app-show-seasons-section-full');

  /// формируем сезоны сериала
  final seasonCount = seasonElements.length;

  /// текущая озвучка
  VoiceActing voiceActing = const VoiceActing();

  /// список доступных озвучек
  final voiceActings = <VoiceActing>[];

  /// парсим список доступных озвучек
  final voiceActingElements =
      document.getElementsByClassName('btn-group btn-group-sm');
  if (voiceActingElements.isNotEmpty) {
    /// ^ если есть доступные озвучки

    /// парсим кнопки с озвучками
    final items = voiceActingElements.first.children;
    for (final item in items) {
      if (item.attributes['disabled'] != null) {
        /// обновляем текущую озвучку
        voiceActing = VoiceActing(
          id: showId,
          name: item.text.trim(),
        );
      } else {
        final url = item.attributes['href'] ?? '';

        final id = TskgItem.getShowIdFromUrl(url);

        /// формируем список доступных озвучек
        voiceActings.add(VoiceActing(
          id: id,
          name: item.text,
        ));
      }
    }
  }

  return TskgItem(
    id: showId,
    title: title,
    // seasons: seasons,
    // originalTitle: originalTitle,
    overview: description,
    year: years,
    genres: genres,
    countries: countries,
    seasonCount: seasonCount,
    // voice: voiceActing,
    // voices: voiceActings,
  );
}

Future<TskgItem> parseDetails1(html) async {
  /// парсим html
  final document = parse(html);

  /// парсим идентификатор сериала
  final showIdUrl = document
      .getElementsByClassName('episode')
      .firstOrNull
      ?.attributes['href'];
  final showId = TskgItem.getShowIdFromUrl(showIdUrl ?? '');

  /// парсим название сериала
  final title = document.getElementById('h-show-title')?.text ?? '';

  /// парсим название на языке оригинала
  final originalTitle =
      TskgApi.getTextByClassName(document, 'app-show-header-title-original');

  /// парсим года выпуска сериала
  /// убираем 'завершён/закрыт' из '2001-2010, завершён/закрыт'
  final years = TskgApi.getTextByClassName(document, 'app-show-header-years')
      .split(', ')
      .first;

  /// парсим страны, жанры
  final tags = document
      .getElementsByClassName('app-show-tags')
      .last
      .getElementsByTagName('a');

  final genres = tags
      .where((element) {
        /// получаем атрибут href
        final href = element.attributes['href'] ?? '';

        /// находим только те элементы, которые указывают жанр сериала
        // return href.startsWith('/category') || href.startsWith('/genre');
        return href.startsWith('/genre');
      })
      .map((element) => element.text)
      .toList();
  // debugPrint('show genres: $genres');

  /// формируем список стран
  final countries =
      document.getElementsByClassName('app-show-tags-flag').map((element) {
    /// получаем название страны
    final countryName = element.attributes['title'] ?? '';

    if (countryName == 'Российская Федерация') {
      return 'Россия';
    }

    return countryName;
  }).toList();

  /// парсим описание сериала
  final description =
      TskgApi.getTextByClassName(document, 'app-show-description');

  /// парсим список сезонов
  final seasonElements =
      document.getElementsByClassName('app-show-seasons-section-full');

  /// формируем сезоны сериала
  final seasons = seasonElements.mapIndexed((seasonIndex, season) {
    /// парсим заголовок названия сезона
    final seasonTitleTable =
        season.getElementsByClassName('app-show-season-title-table').first;

    /// получаем название сезона
    final seasonTitle = seasonTitleTable.getElementsByTagName('a').first.text;

    /// парсим список эпизодов сезона
    final seasonEpisodesTable =
        season.getElementsByClassName('app-show-season-collapse').first;
    final seasonEpisodeRows = seasonEpisodesTable.getElementsByTagName('tr');

    /// формируем эпизоды сезона
    final episodes = seasonEpisodeRows.mapIndexed((episodeIndex, episodeRow) {
      /// парсим качество записи SD|HD
      //final episodeQuality = episodeRow.getElementsByClassName('btn btn-default btn-xs').first.text;

      /// парсим название и id эпизода
      final episodeTitleElement =
          episodeRow.getElementsByClassName('text-primary').first;
      String episodeTitle = episodeTitleElement.text;

      final regExp = RegExp(r'^\d+?\: (.+?)$');

      if (regExp.hasMatch(episodeTitle)) {
        episodeTitle = regExp.firstMatch(episodeTitle)?.group(1) ?? '';
      }

      // final episodeUrl = episodeTitleElement.attributes['href'] ?? '';
      final episodeIdAttribute = episodeTitleElement.attributes['id'] ?? '-';
      final episodeId = int.tryParse(episodeIdAttribute.split('-').last) ?? 0;

      /// парсим продолжительность эпизода
      final episodeDurationString =
          episodeTitleElement.nextElementSibling?.text.trim() ?? '';
      Duration episodeDuration = Duration.zero;
      if (episodeDurationString.isNotEmpty) {
        /// ^ если указана продолжительность эпизода

        episodeDuration = episodeDurationString.substring(2).toDuration();
      }

      /// парсим описание эпизода (перевод, обычно)
      // final episodeDescription = episodeRow.getElementsByClassName('text-muted clearfix').first.text.trim().replaceAll('⠀', '');

      return MediaItemEpisode(
        id: '${OnlineService.tskg.name}|$showId@$episodeId',
        name: episodeTitle,
        seasonNumber: seasonIndex + 1,
        episodeNumber: episodeIndex + 1,
        duration: episodeDuration.inSeconds,
      );
    }).toList();

    return MediaItemSeason(
      name: seasonTitle,
      episodes: episodes,
    );
  }).toList();

  /// текущая озвучка
  VoiceActing voiceActing = const VoiceActing();

  /// список доступных озвучек
  final voiceActings = <VoiceActing>[];

  /// парсим список доступных озвучек
  final voiceActingElements =
      document.getElementsByClassName('btn-group btn-group-sm');
  if (voiceActingElements.isNotEmpty) {
    /// ^ если есть доступные озвучки

    /// парсим кнопки с озвучками
    final items = voiceActingElements.first.children;
    for (final item in items) {
      if (item.attributes['disabled'] != null) {
        /// обновляем текущую озвучку
        voiceActing = VoiceActing(
          id: showId,
          name: item.text.trim(),
        );
      } else {
        final url = item.attributes['href'] ?? '';

        final id = TskgItem.getShowIdFromUrl(url);

        /// формируем список доступных озвучек
        voiceActings.add(VoiceActing(
          id: id,
          name: item.text,
        ));
      }
    }
  }

  return TskgItem(
    id: showId,
    title: title,
    // seasons: seasons,
    // originalTitle: originalTitle,
    // overview: description,
    // year: years,
    genres: genres,
    countries: countries,
    // voice: voiceActing,
    // voices: voiceActings,
  );
}
