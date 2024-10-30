class FilmixToken {
  final String code;
  final String userCode;
  final int expire;

  const FilmixToken({
    this.code = '',
    this.userCode = '',
    this.expire = 0,
  });

  factory FilmixToken.fromJson(Map<String, dynamic> json) => FilmixToken(
        code: json['code'] as String? ?? '',
        userCode: json['user_code'] as String? ?? '',
        expire: int.tryParse('${json['expire']}') ?? 0,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'user_code': userCode,
        'expire': expire,
      };

  @override
  String toString() => toJson().toString();
}
