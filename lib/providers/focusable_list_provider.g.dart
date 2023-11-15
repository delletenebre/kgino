// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focusable_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$focusableListHash() => r'8b23405bd7216462f651825be71c5e438a64e129';

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

abstract class _$FocusableList extends BuildlessAutoDisposeNotifier<int> {
  late final Key? key;
  late final int itemCount;
  late final double offset;
  late final KeyEventResult keyEventResult;
  late final ListObserverController? controller;

  int build({
    Key? key,
    int itemCount = 0,
    double offset = 0.0,
    KeyEventResult keyEventResult = KeyEventResult.ignored,
    ListObserverController? controller,
  });
}

/// See also [FocusableList].
@ProviderFor(FocusableList)
const focusableListProvider = FocusableListFamily();

/// See also [FocusableList].
class FocusableListFamily extends Family {
  /// See also [FocusableList].
  const FocusableListFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'focusableListProvider';

  /// See also [FocusableList].
  FocusableListProvider call({
    Key? key,
    int itemCount = 0,
    double offset = 0.0,
    KeyEventResult keyEventResult = KeyEventResult.ignored,
    ListObserverController? controller,
  }) {
    return FocusableListProvider(
      key: key,
      itemCount: itemCount,
      offset: offset,
      keyEventResult: keyEventResult,
      controller: controller,
    );
  }

  @visibleForOverriding
  @override
  FocusableListProvider getProviderOverride(
    covariant FocusableListProvider provider,
  ) {
    return call(
      key: provider.key,
      itemCount: provider.itemCount,
      offset: provider.offset,
      keyEventResult: provider.keyEventResult,
      controller: provider.controller,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(FocusableList Function() create) {
    return _$FocusableListFamilyOverride(this, create);
  }
}

class _$FocusableListFamilyOverride implements FamilyOverride {
  _$FocusableListFamilyOverride(this.overriddenFamily, this.create);

  final FocusableList Function() create;

  @override
  final FocusableListFamily overriddenFamily;

  @override
  FocusableListProvider getProviderOverride(
    covariant FocusableListProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [FocusableList].
class FocusableListProvider
    extends AutoDisposeNotifierProviderImpl<FocusableList, int> {
  /// See also [FocusableList].
  FocusableListProvider({
    Key? key,
    int itemCount = 0,
    double offset = 0.0,
    KeyEventResult keyEventResult = KeyEventResult.ignored,
    ListObserverController? controller,
  }) : this._internal(
          () => FocusableList()
            ..key = key
            ..itemCount = itemCount
            ..offset = offset
            ..keyEventResult = keyEventResult
            ..controller = controller,
          from: focusableListProvider,
          name: r'focusableListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$focusableListHash,
          dependencies: FocusableListFamily._dependencies,
          allTransitiveDependencies:
              FocusableListFamily._allTransitiveDependencies,
          key: key,
          itemCount: itemCount,
          offset: offset,
          keyEventResult: keyEventResult,
          controller: controller,
        );

  FocusableListProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
    required this.itemCount,
    required this.offset,
    required this.keyEventResult,
    required this.controller,
  }) : super.internal();

  final Key? key;
  final int itemCount;
  final double offset;
  final KeyEventResult keyEventResult;
  final ListObserverController? controller;

  @override
  int runNotifierBuild(
    covariant FocusableList notifier,
  ) {
    return notifier.build(
      key: key,
      itemCount: itemCount,
      offset: offset,
      keyEventResult: keyEventResult,
      controller: controller,
    );
  }

  @override
  Override overrideWith(FocusableList Function() create) {
    return ProviderOverride(
      origin: this,
      override: FocusableListProvider._internal(
        () => create()
          ..key = key
          ..itemCount = itemCount
          ..offset = offset
          ..keyEventResult = keyEventResult
          ..controller = controller,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
        itemCount: itemCount,
        offset: offset,
        keyEventResult: keyEventResult,
        controller: controller,
      ),
    );
  }

  @override
  ({
    Key? key,
    int itemCount,
    double offset,
    KeyEventResult keyEventResult,
    ListObserverController? controller,
  }) get argument {
    return (
      key: key,
      itemCount: itemCount,
      offset: offset,
      keyEventResult: keyEventResult,
      controller: controller,
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FocusableList, int> createElement() {
    return _FocusableListProviderElement(this);
  }

  FocusableListProvider _copyWith(
    FocusableList Function() create,
  ) {
    return FocusableListProvider._internal(
      () => create()
        ..key = key
        ..itemCount = itemCount
        ..offset = offset
        ..keyEventResult = keyEventResult
        ..controller = controller,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      key: key,
      itemCount: itemCount,
      offset: offset,
      keyEventResult: keyEventResult,
      controller: controller,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FocusableListProvider &&
        other.key == key &&
        other.itemCount == itemCount &&
        other.offset == offset &&
        other.keyEventResult == keyEventResult &&
        other.controller == controller;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);
    hash = _SystemHash.combine(hash, itemCount.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, keyEventResult.hashCode);
    hash = _SystemHash.combine(hash, controller.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FocusableListRef on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `key` of this provider.
  Key? get key;

  /// The parameter `itemCount` of this provider.
  int get itemCount;

  /// The parameter `offset` of this provider.
  double get offset;

  /// The parameter `keyEventResult` of this provider.
  KeyEventResult get keyEventResult;

  /// The parameter `controller` of this provider.
  ListObserverController? get controller;
}

class _FocusableListProviderElement
    extends AutoDisposeNotifierProviderElement<FocusableList, int>
    with FocusableListRef {
  _FocusableListProviderElement(super.provider);

  @override
  Key? get key => (origin as FocusableListProvider).key;
  @override
  int get itemCount => (origin as FocusableListProvider).itemCount;
  @override
  double get offset => (origin as FocusableListProvider).offset;
  @override
  KeyEventResult get keyEventResult =>
      (origin as FocusableListProvider).keyEventResult;
  @override
  ListObserverController? get controller =>
      (origin as FocusableListProvider).controller;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
