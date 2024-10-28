// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_card.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemHash() => r'cd7867125bd1b666b4fec9e0b6f7d9d0e50723e5';

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

abstract class _$Item
    extends BuildlessAutoDisposeAsyncNotifier<MediaItemEpisode> {
  late final MediaItemEpisode episode;

  FutureOr<MediaItemEpisode> build(
    MediaItemEpisode episode,
  );
}

/// See also [Item].
@ProviderFor(Item)
const itemProvider = ItemFamily();

/// See also [Item].
class ItemFamily extends Family {
  /// See also [Item].
  const ItemFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itemProvider';

  /// See also [Item].
  ItemProvider call(
    MediaItemEpisode episode,
  ) {
    return ItemProvider(
      episode,
    );
  }

  @visibleForOverriding
  @override
  ItemProvider getProviderOverride(
    covariant ItemProvider provider,
  ) {
    return call(
      provider.episode,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(Item Function() create) {
    return _$ItemFamilyOverride(this, create);
  }
}

class _$ItemFamilyOverride implements FamilyOverride {
  _$ItemFamilyOverride(this.overriddenFamily, this.create);

  final Item Function() create;

  @override
  final ItemFamily overriddenFamily;

  @override
  ItemProvider getProviderOverride(
    covariant ItemProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [Item].
class ItemProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Item, MediaItemEpisode> {
  /// See also [Item].
  ItemProvider(
    MediaItemEpisode episode,
  ) : this._internal(
          () => Item()..episode = episode,
          from: itemProvider,
          name: r'itemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$itemHash,
          dependencies: ItemFamily._dependencies,
          allTransitiveDependencies: ItemFamily._allTransitiveDependencies,
          episode: episode,
        );

  ItemProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.episode,
  }) : super.internal();

  final MediaItemEpisode episode;

  @override
  FutureOr<MediaItemEpisode> runNotifierBuild(
    covariant Item notifier,
  ) {
    return notifier.build(
      episode,
    );
  }

  @override
  Override overrideWith(Item Function() create) {
    return ProviderOverride(
      origin: this,
      override: ItemProvider._internal(
        () => create()..episode = episode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        episode: episode,
      ),
    );
  }

  @override
  (MediaItemEpisode,) get argument {
    return (episode,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Item, MediaItemEpisode>
      createElement() {
    return _ItemProviderElement(this);
  }

  ItemProvider _copyWith(
    Item Function() create,
  ) {
    return ItemProvider._internal(
      () => create()..episode = episode,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      episode: episode,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ItemProvider && other.episode == episode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, episode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemRef on AutoDisposeAsyncNotifierProviderRef<MediaItemEpisode> {
  /// The parameter `episode` of this provider.
  MediaItemEpisode get episode;
}

class _ItemProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Item, MediaItemEpisode>
    with ItemRef {
  _ItemProviderElement(super.provider);

  @override
  MediaItemEpisode get episode => (origin as ItemProvider).episode;
}

String _$detailsHash() => r'f3dfd91dbba29f2740cd61c088643c4f50d7812c';

abstract class _$Details extends BuildlessAutoDisposeAsyncNotifier<Map?> {
  late final int? tvId;
  late final int season;
  late final int episode;

  FutureOr<Map?> build(
    int? tvId,
    int season,
    int episode,
  );
}

/// See also [Details].
@ProviderFor(Details)
const detailsProvider = DetailsFamily();

/// See also [Details].
class DetailsFamily extends Family {
  /// See also [Details].
  const DetailsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'detailsProvider';

  /// See also [Details].
  DetailsProvider call(
    int? tvId,
    int season,
    int episode,
  ) {
    return DetailsProvider(
      tvId,
      season,
      episode,
    );
  }

  @visibleForOverriding
  @override
  DetailsProvider getProviderOverride(
    covariant DetailsProvider provider,
  ) {
    return call(
      provider.tvId,
      provider.season,
      provider.episode,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(Details Function() create) {
    return _$DetailsFamilyOverride(this, create);
  }
}

class _$DetailsFamilyOverride implements FamilyOverride {
  _$DetailsFamilyOverride(this.overriddenFamily, this.create);

  final Details Function() create;

  @override
  final DetailsFamily overriddenFamily;

  @override
  DetailsProvider getProviderOverride(
    covariant DetailsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [Details].
class DetailsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Details, Map?> {
  /// See also [Details].
  DetailsProvider(
    int? tvId,
    int season,
    int episode,
  ) : this._internal(
          () => Details()
            ..tvId = tvId
            ..season = season
            ..episode = episode,
          from: detailsProvider,
          name: r'detailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detailsHash,
          dependencies: DetailsFamily._dependencies,
          allTransitiveDependencies: DetailsFamily._allTransitiveDependencies,
          tvId: tvId,
          season: season,
          episode: episode,
        );

  DetailsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tvId,
    required this.season,
    required this.episode,
  }) : super.internal();

  final int? tvId;
  final int season;
  final int episode;

  @override
  FutureOr<Map?> runNotifierBuild(
    covariant Details notifier,
  ) {
    return notifier.build(
      tvId,
      season,
      episode,
    );
  }

  @override
  Override overrideWith(Details Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailsProvider._internal(
        () => create()
          ..tvId = tvId
          ..season = season
          ..episode = episode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tvId: tvId,
        season: season,
        episode: episode,
      ),
    );
  }

  @override
  (
    int?,
    int,
    int,
  ) get argument {
    return (
      tvId,
      season,
      episode,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Details, Map?> createElement() {
    return _DetailsProviderElement(this);
  }

  DetailsProvider _copyWith(
    Details Function() create,
  ) {
    return DetailsProvider._internal(
      () => create()
        ..tvId = tvId
        ..season = season
        ..episode = episode,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      tvId: tvId,
      season: season,
      episode: episode,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DetailsProvider &&
        other.tvId == tvId &&
        other.season == season &&
        other.episode == episode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tvId.hashCode);
    hash = _SystemHash.combine(hash, season.hashCode);
    hash = _SystemHash.combine(hash, episode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DetailsRef on AutoDisposeAsyncNotifierProviderRef<Map?> {
  /// The parameter `tvId` of this provider.
  int? get tvId;

  /// The parameter `season` of this provider.
  int get season;

  /// The parameter `episode` of this provider.
  int get episode;
}

class _DetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Details, Map?>
    with DetailsRef {
  _DetailsProviderElement(super.provider);

  @override
  int? get tvId => (origin as DetailsProvider).tvId;
  @override
  int get season => (origin as DetailsProvider).season;
  @override
  int get episode => (origin as DetailsProvider).episode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
