class VoiceActing {
  final String id;
  final String name;

  const VoiceActing({
    this.id = '',
    this.name = '',
  });

  factory VoiceActing.fromJson(Map<String, dynamic> json) => VoiceActing(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };

  @override
  String toString() => toJson().toString();
}
