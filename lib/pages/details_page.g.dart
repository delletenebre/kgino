// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detailsHash() => r'0958e076f904b46430c3ca8eb030c6940ae78365';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Details extends BuildlessAutoDisposeAsyncNotifier<MediaItem?> {
  late final MediaItem? mediaItem;

  Future<MediaItem?> build(
    MediaItem? mediaItem,
  );
}

/// See also [Details].
@ProviderFor(Details)
const detailsProvider = DetailsFamily();

/// See also [Details].
class DetailsFamily extends Family<AsyncValue<MediaItem?>> {
  /// See also [Details].
  const DetailsFamily();

  /// See also [Details].
  DetailsProvider call(
    MediaItem? mediaItem,
  ) {
    return DetailsProvider(
      mediaItem,
    );
  }

  @override
  DetailsProvider getProviderOverride(
    covariant DetailsProvider provider,
  ) {
    return call(
      provider.mediaItem,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'detailsProvider';
}

/// See also [Details].
class DetailsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Details, MediaItem?> {
  /// See also [Details].
  DetailsProvider(
    MediaItem? mediaItem,
  ) : this._internal(
          () => Details()..mediaItem = mediaItem,
          from: detailsProvider,
          name: r'detailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detailsHash,
          dependencies: DetailsFamily._dependencies,
          allTransitiveDependencies: DetailsFamily._allTransitiveDependencies,
          mediaItem: mediaItem,
        );

  DetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mediaItem,
  }) : super.internal();

  final MediaItem? mediaItem;

  @override
  Future<MediaItem?> runNotifierBuild(
    covariant Details notifier,
  ) {
    return notifier.build(
      mediaItem,
    );
  }

  @override
  Override overrideWith(Details Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailsProvider._internal(
        () => create()..mediaItem = mediaItem,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mediaItem: mediaItem,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Details, MediaItem?> createElement() {
    return _DetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailsProvider && other.mediaItem == mediaItem;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mediaItem.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DetailsRef on AutoDisposeAsyncNotifierProviderRef<MediaItem?> {
  /// The parameter `mediaItem` of this provider.
  MediaItem? get mediaItem;
}

class _DetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Details, MediaItem?>
    with DetailsRef {
  _DetailsProviderElement(super.provider);

  @override
  MediaItem? get mediaItem => (origin as DetailsProvider).mediaItem;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
