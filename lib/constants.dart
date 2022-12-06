import 'dart:io' show Platform;
import 'dart:ui';

/// время ожидания ответа от сервера
const requestTimeout = Duration(seconds: 10);

/// время хранения запросов в кэше
const cacheMaxAge = Duration(minutes: 1);

/// заголовок User-Agent
final userAgent = 'KGino/${Platform.operatingSystem} ${Platform.operatingSystemVersion}';


/// oc.kg размер постера
const ockgPosterSize = Size(100.0, 140.0);


/// title height
const tskgCategoryTitleHeight = 47.0;
/// poster + name
const tskgItemHeight = 104.0 + 40.0;
/// height = title + poster + name
const tskgListViewHeight = tskgCategoryTitleHeight + tskgItemHeight;