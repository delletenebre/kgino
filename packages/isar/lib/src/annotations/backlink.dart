part of isar;

/// Annotation to create a backlink to an existing link.
@Target({TargetKind.field})
class Backlink {
  /// The Dart name of the target link.
  final String to;

  /// Annotation to create a backlink to an existing link.
  const Backlink({required this.to});
}
