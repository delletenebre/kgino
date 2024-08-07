// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_card.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$focusedMediaItemHash() => r'1a11556f51bf5df51c6a34bae7f8f74bf6374218';

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

abstract class _$FocusedMediaItem
    extends BuildlessAutoDisposeAsyncNotifier<MediaItem?> {
  late final MediaItem mediaItem;

  FutureOr<MediaItem?> build(
    MediaItem mediaItem,
  );
}

/// See also [FocusedMediaItem].
@ProviderFor(FocusedMediaItem)
const focusedMediaItemProvider = FocusedMediaItemFamily();

/// See also [FocusedMediaItem].
class FocusedMediaItemFamily extends Family {
  /// See also [FocusedMediaItem].
  const FocusedMediaItemFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'focusedMediaItemProvider';

  /// See also [FocusedMediaItem].
  FocusedMediaItemProvider call(
    MediaItem mediaItem,
  ) {
    return FocusedMediaItemProvider(
      mediaItem,
    );
  }

  @visibleForOverriding
  @override
  FocusedMediaItemProvider getProviderOverride(
    covariant FocusedMediaItemProvider provider,
  ) {
    return call(
      provider.mediaItem,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FocusedMediaItem Function() create) {
    return _$FocusedMediaItemFamilyOverride(this, create);
  }
}

class _$FocusedMediaItemFamilyOverride implements FamilyOverride {
  _$FocusedMediaItemFamilyOverride(this.overriddenFamily, this.create);

  final FocusedMediaItem Function() create;

  @override
  final FocusedMediaItemFamily overriddenFamily;

  @override
  FocusedMediaItemProvider getProviderOverride(
    covariant FocusedMediaItemProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [FocusedMediaItem].
class FocusedMediaItemProvider
    extends AutoDisposeAsyncNotifierProviderImpl<FocusedMediaItem, MediaItem?> {
  /// See also [FocusedMediaItem].
  FocusedMediaItemProvider(
    MediaItem mediaItem,
  ) : this._internal(
          () => FocusedMediaItem()..mediaItem = mediaItem,
          from: focusedMediaItemProvider,
          name: r'focusedMediaItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$focusedMediaItemHash,
          dependencies: FocusedMediaItemFamily._dependencies,
          allTransitiveDependencies:
              FocusedMediaItemFamily._allTransitiveDependencies,
          mediaItem: mediaItem,
        );

  FocusedMediaItemProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mediaItem,
  }) : super.internal();

  final MediaItem mediaItem;

  @override
  FutureOr<MediaItem?> runNotifierBuild(
    covariant FocusedMediaItem notifier,
  ) {
    return notifier.build(
      mediaItem,
    );
  }

  @override
  Override overrideWith(FocusedMediaItem Function() create) {
    return ProviderOverride(
      origin: this,
      override: FocusedMediaItemProvider._internal(
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
  (MediaItem,) get argument {
    return (mediaItem,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FocusedMediaItem, MediaItem?>
      createElement() {
    return _FocusedMediaItemProviderElement(this);
  }

  FocusedMediaItemProvider _copyWith(
    FocusedMediaItem Function() create,
  ) {
    return FocusedMediaItemProvider._internal(
      () => create()..mediaItem = mediaItem,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      mediaItem: mediaItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FocusedMediaItemProvider && other.mediaItem == mediaItem;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mediaItem.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FocusedMediaItemRef on AutoDisposeAsyncNotifierProviderRef<MediaItem?> {
  /// The parameter `mediaItem` of this provider.
  MediaItem get mediaItem;
}

class _FocusedMediaItemProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FocusedMediaItem,
        MediaItem?> with FocusedMediaItemRef {
  _FocusedMediaItemProviderElement(super.provider);

  @override
  MediaItem get mediaItem => (origin as FocusedMediaItemProvider).mediaItem;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
