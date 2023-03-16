import 'package:collection/collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import '../models/episode_item.dart';
import '../models/movie_item.dart';
import '../models/season_item.dart';
import '../models/tskg/tskg_show.dart';
import '../utils.dart';



String getTextByClassName(Document document, String className) {
  final elements = document.getElementsByClassName(className);
  if (elements.isNotEmpty) {
    return elements.first.text.trim();
  }

  return '';
}

Future<List<TskgMovieItem>> newsIsolate(String html) async {
  final items = <TskgMovieItem>[];

  /// парсим html
  final document = parse(html);
  
  /// получаем элементы списка новых поступлений
  final elements = document.getElementsByClassName('app-news-block');

  for (final element in elements) {

    /// парсим дату добавления
    /// <div class="app-news-date"><strong>22.12.2021</strong></div>
    final dateText = element
      .getElementsByClassName('app-news-date').first.text;
    final date = DateFormat('dd.MM.yyyy').parse(dateText);

    /// парсим элементы новых поступлений
    /*
      <div class="app-news-list-item">
          <div class="clearfix news">
            <i class="fas fa-caret-right"></i>
          <span class="label label-default"><span class="fas fa-sync-alt" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Обновлено"></span></span>
          <a class="news-link app-news-link" href="/show/zhenskii_stand_up/3/16" data-toggle="tooltip" data-placement="top" title="ТВ-шоу (российские), Стендап, Юмористическое шоу">Женский стендап</a>
          <span class="text-muted clearfix"><small>3 сезон, 16 серия</small></span>
        </div>
      </div>
    */
    final listItems = element.getElementsByClassName('app-news-list-item');
    for (final listItem in listItems) {
      //debugPrint('date: $DateFormat');

      final tagsA = listItem.getElementsByClassName('app-news-link');
      if (tagsA.isNotEmpty) {
        /// ^ если в новостях найден элемент <a></a>
        
        final tagA = tagsA.first;

        final tagSmall = listItem.getElementsByTagName('small');

        /// ссылка на сериал/подборку/серию
        final link = tagA.attributes['href'] ?? '';
        //debugPrint('link: $link');
        
        /// название сериала или подборки
        final title = tagA.text;
        //debugPrint('title: $title');

        /// дополнительная информация (например, сезон и номер серии)
        String subtitle = '';
        if (tagSmall.isNotEmpty) {
          subtitle = tagSmall.first.text;
        }
        //debugPrint('subtitle: $subtitle');

        /// жанры
        final genres = (tagA.attributes['title'] ?? '').split(', ');
        // debugPrint('genres: $genres');

        // /// значки (badges)
        // final badges = listItem.getElementsByClassName('label').map((badge) {
          
        //   if (badge.text.isEmpty) {
        //     /// ^ если значок в виде иконки
        //     return badge.firstChild?.attributes['title'] ?? '';

        //   } else {
        //     /// ^ если значок подписан
            
        //     return badge.text;
            
        //   }

        // });

        items.add(
          TskgMovieItem(
            id: TskgShow.getShowIdFromUrl(link),
            name: title,
            updatedAt: date,
            subtitle: subtitle,
            genres: genres,
            //badges: badges.toList(),
          )
        );
      }

    }

  }

  return items;
}



/// получение списка популярных
Future<List<MovieItem>> popularSectionIsolate(String html) async {
  
  /// список элементов
  final items = <MovieItem>[];

  /// ^ если запрос выполнен успешно
  /// парсим html
  final document = parse(html);
  
  /// получаем элементы списка популярных
  final elements = document.getElementById('index-top-tab')
      ?.getElementsByClassName('show') ?? [];

  for (final element in elements) {
    // <div class="show">
    //   <a href="/show/wednesday_rezka">
    //     <img src="/posters/wednesday_rezka.png" srcset="/posters2/wednesday_rezka.png 2x" alt="Уэнздей (Уэнсдей)" class="poster poster-lazy" data-toggle="tooltip" data-placement="top" title="Зарубежные сериалы, Комедия">
    //     <p class="show-title"><img class="app-shows-show-flag" src="https://www.ts.kg/img/flags/svg/4x3/us.svg" alt="США">Уэнздей (Уэнсдей)</p>
    //   </a>
    // </div>

    /// парсим ссылку
    final link = element.getElementsByTagName('a').first;
    final src = link.attributes['href'] ?? '';
    final id = TskgShow.getShowIdFromUrl(src);

    /// парсим название
    final title = link.getElementsByClassName('show-title').first.text;

    items.add(
      TskgMovieItem(
        id: id,
        name: title,
      )
    );

  }

  return items;
}



/// получение списка новых
List<MovieItem> newSectionIsolate(String html) {
  
  /// список элементов
  final items = <MovieItem>[];

  /// ^ если запрос выполнен успешно
  /// парсим html
  final document = parse(html);
  
  /// получаем элементы списка популярных
  final elements = document.getElementById('index-news-poster-tab')
      ?.getElementsByClassName('app-shows-item-full') ?? [];

  for (final element in elements) {
    // <div class="show">
    //   <a href="/show/wednesday_rezka">
    //     <img src="/posters/wednesday_rezka.png" srcset="/posters2/wednesday_rezka.png 2x" alt="Уэнздей (Уэнсдей)" class="poster poster-lazy" data-toggle="tooltip" data-placement="top" title="Зарубежные сериалы, Комедия">
    //     <p class="show-title"><img class="app-shows-show-flag" src="https://www.ts.kg/img/flags/svg/4x3/us.svg" alt="США">Уэнздей (Уэнсдей)</p>
    //   </a>
    // </div>

    /// парсим ссылку
    final link = element.getElementsByTagName('a').first;
    final src = link.attributes['href'] ?? '';
    final id = TskgShow.getShowIdFromUrl(src);

    /// парсим название
    final title = link.getElementsByClassName('app-shows-card-title').first.text;

    items.add(
      TskgMovieItem(
        id: id,
        name: title,
      )
    );

  }

  return items;
}



/// получение информации о сериале
TskgMovieItem showIsolate(String html) {

  /// парсим html
  final document = parse(html);

  /// парсим название сериала
  final title = document.getElementById('h-show-title')?.text ?? '';

  /// парсим название на языке оригинала
  final originalTitle = getTextByClassName(document, 'app-show-header-title-original');

  /// парсим года выпуска сериала
  /// убираем 'завершён/закрыт' из '2001-2010, завершён/закрыт'
  final years = getTextByClassName(document, 'app-show-header-years')
      .split(', ').first;

  /// парсим страны, жанры
  final tags = document.getElementsByClassName('app-show-tags')
    .last
    .getElementsByTagName('a');
  
  final genres = tags.where((element) {
    /// получаем атрибут href
    final href = element.attributes['href'] ?? '';

      /// находим только те элементы, которые указывают жанр сериала
    // return href.startsWith('/category') || href.startsWith('/genre');
    return href.startsWith('/genre');
  }).map((element) => element.text).toList();
  // debugPrint('show genres: $genres');
  
  /// формируем список стран
  final countries = document.getElementsByClassName('app-show-tags-flag')
  // tags.where((element) {
  //   /// получаем атрибут href
  //   final href = element.attributes['href'] ?? '';
  //   /// находим только те элементы, которые указывают на страну
  //   return href.startsWith('/show?country');
  // })
    .map((element) {
      /// получаем название страны
      final countryName = element.attributes['title'] ?? '';

      /// получаем атрибут стиля элемента (изображение как background-image)
      // String countryImageUrl = element.attributes['style'] ?? '';
      // if (countryImageUrl.startsWith('background-image: url(')) {
      //   /// ^ если ссылка на изображение страны не пустая
        
      //   /// вырезаем [background-image: url(https://www.ts.kg/img/flags/svg/4x3/ru.svg)]
      //   countryImageUrl = countryImageUrl
      //     .substring(22, countryImageUrl.length - 1);
      // }

      if (countryName == 'Российская Федерация') {
        return 'Россия';
      }
    

      return countryName;
      // return TskgCountry(
      //   name: countryName,
      //   imageUrl: countryImageUrl,
      // );
    }).toList();

  /// парсим описание сериала
  final description = getTextByClassName(document, 'app-show-description');

  /// парсим список сезонов
  final seasonElements = document.getElementsByClassName('app-show-seasons-section-full');
  
  /// формируем сезоны сериала
  final seasons = seasonElements.mapIndexed((seasonIndex, season) {
    /// парсим заголовок названия сезона
    final seasonTitleTable = season.getElementsByClassName('app-show-season-title-table').first;
    
    /// получаем название сезона
    final seasonTitle = seasonTitleTable.getElementsByTagName('a').first.text;

    /// парсим список эпизодов сезона
    final seasonEpisodesTable = season.getElementsByClassName('app-show-season-collapse').first;
    final seasonEpisodeRows = seasonEpisodesTable.getElementsByTagName('tr');
    
    /// формируем эпизоды сезона
    final episodes = seasonEpisodeRows.mapIndexed((episodeIndex, episodeRow) {
      /// парсим качество записи SD|HD
      //final episodeQuality = episodeRow.getElementsByClassName('btn btn-default btn-xs').first.text;
      
      /// парсим название и id эпизода
      final episodeTitleElement = episodeRow.getElementsByClassName('text-primary').first;
      String episodeTitle = episodeTitleElement.text;


      final regExp = RegExp(r'^\d+?\: (.+?)$');
      
      if (regExp.hasMatch(episodeTitle)) {
        episodeTitle = regExp.firstMatch(episodeTitle)?.group(1) ?? '';
      }

      // final episodeUrl = episodeTitleElement.attributes['href'] ?? '';
      final episodeIdAttribute = episodeTitleElement.attributes['id'] ?? '-';
      final episodeId = int.tryParse(episodeIdAttribute.split('-').last) ?? 0;
      
      /// парсим продолжительность эпизода
      final episodeDurationString = episodeTitleElement.nextElementSibling?.text.trim() ?? '';
      Duration episodeDuration = Duration.zero;
      if (episodeDurationString.isNotEmpty) {
        /// ^ если указана продолжительность эпизода
        
        episodeDuration = Utils.parseDuration(episodeDurationString.substring(2));
      }
      
      /// парсим описание эпизода (перевод, обычно)
      // final episodeDescription = episodeRow.getElementsByClassName('text-muted clearfix').first.text.trim().replaceAll('⠀', '');

      return EpisodeItem(
        id: '$episodeId',
        name: episodeTitle ,
        seasonNumber: seasonIndex + 1,
        episodeNumber: episodeIndex + 1,
        duration: episodeDuration.inSeconds,
        // quality: episodeQuality,
        
      );
    }).toList();

    return SeasonItem(
      name: seasonTitle,
      episodes: episodes,
    );
  }).toList();

  
  /// текущая озвучка
  String voiceActing = '';
  
  /// список доступных озвучек
  final voiceActings = <MovieItem>[];
  
  /// парсим список доступных озвучек
  final voiceActingElements = document.getElementsByClassName('btn-group btn-group-sm');
  if (voiceActingElements.isNotEmpty) {
    /// ^ если есть доступные озвучки
    
    /// парсим кнопки с озвучками
    final items = voiceActingElements.first.children;
    for (final item in items) {
      if (item.attributes['disabled'] != null) {

        /// обновляем текущую озвучку
        voiceActing = item.text.trim();
      
      } else {

        final url = item.attributes['href'] ?? '';
        
        /// формируем список доступных озвучек
        voiceActings.add(
          TskgMovieItem(
            id: TskgShow.getShowIdFromUrl(url),
            name: item.text,
          )
        );

      }
      
    }
  }

  final showIdUrl = document.getElementsByClassName('episode as1').firstOrNull?.attributes['href'];
  final showId = TskgShow.getShowIdFromUrl(showIdUrl ?? '');

  return TskgMovieItem(
    id: showId,
    name: title,
    seasons: seasons,

    originalName: originalTitle,
    description: description,
    year: years,
    genres: genres,
    countries: countries,
    
    voiceActing: voiceActing,
    voiceActings: voiceActings,
  );

}