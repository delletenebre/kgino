import 'dart:io' show Platform;
import 'dart:ui';

import 'package:flutter/foundation.dart';

/// время ожидания ответа от сервера
const requestTimeout = Duration(seconds: 10);

/// время хранения запросов в кэше
const cacheMaxAge = Duration(minutes: 1);

/// заголовок User-Agent
final userAgent = 'KGino/${kIsWeb ? 'Web' : Platform.operatingSystem} ${kIsWeb ? 'Web' : Platform.operatingSystemVersion}';


/// oc.kg размер постера
const ockgPosterSize = Size(100.0, 140.0);
const ockgListViewHeight = 140.0 + 40.0 + 47.0;


/// ts.kg размер постера
const tskgPosterSize = Size(126.0, 102.0);
/// title height
const tskgCategoryTitleHeight = 47.0;
/// poster + name
const tskgItemHeight = 104.0 + 40.0;
/// height = title + poster + name
const tskgListViewHeight = tskgCategoryTitleHeight + tskgItemHeight;