class FilmixProfile {
  final FilmixProfileData userData;

  const FilmixProfile({
    required this.userData,
  });

  factory FilmixProfile.fromJson(Map<String, dynamic> json) => FilmixProfile(
        userData: FilmixProfileData.fromJson(
            json['user_data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_data': userData,
      };

  @override
  String toString() => toJson().toString();
}

class FilmixProfileData {
  final String login;
  final bool isPro;
  final bool isProPlus;
  final String displayName;
  final String videoserver;

  const FilmixProfileData({
    this.login = '',
    this.isPro = false,
    this.isProPlus = false,
    this.displayName = '',
    this.videoserver = '',
  });

  factory FilmixProfileData.fromJson(Map<String, dynamic> json) =>
      FilmixProfileData(
        login: json['login'] as String? ?? '',
        isPro: json['is_pro'] as bool? ?? false,
        isProPlus: json['is_pro_plus'] as bool? ?? false,
        displayName: json['display_name'] as String? ?? '',
        videoserver: json['videoserver'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'login': login,
        'is_pro': isPro,
        'is_pro_plus': isProPlus,
        'display_name': displayName,
        'videoserver': videoserver,
      };

  @override
  String toString() => toJson().toString();
}
