import 'dart:io' show Platform;

/// время ожидания ответа от сервера
const requestTimeout = Duration(seconds: 20);

/// время хранения запросов в кэше
const cacheMaxAge = Duration(minutes: 1);

/// заголовок User-Agent
final userAgent = 'KGino/${Platform.operatingSystem} ${Platform.operatingSystemVersion}';