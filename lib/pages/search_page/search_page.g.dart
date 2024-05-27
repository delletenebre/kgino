// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchHash() => r'56f059aa8f19206453fb06474944cd37a4ba7d58';

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

abstract class _$Search
    extends BuildlessAutoDisposeAsyncNotifier<List<CategoryListItem>> {
  late final String searchQuery;

  FutureOr<List<CategoryListItem>> build(
    String searchQuery,
  );
}

/// See also [Search].
@ProviderFor(Search)
const searchProvider = SearchFamily();

/// See also [Search].
class SearchFamily extends Family {
  /// See also [Search].
  const SearchFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchProvider';

  /// See also [Search].
  SearchProvider call(
    String searchQuery,
  ) {
    return SearchProvider(
      searchQuery,
    );
  }

  @visibleForOverriding
  @override
  SearchProvider getProviderOverride(
    covariant SearchProvider provider,
  ) {
    return call(
      provider.searchQuery,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(Search Function() create) {
    return _$SearchFamilyOverride(this, create);
  }
}

class _$SearchFamilyOverride implements FamilyOverride {
  _$SearchFamilyOverride(this.overriddenFamily, this.create);

  final Search Function() create;

  @override
  final SearchFamily overriddenFamily;

  @override
  SearchProvider getProviderOverride(
    covariant SearchProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [Search].
class SearchProvider extends AutoDisposeAsyncNotifierProviderImpl<Search,
    List<CategoryListItem>> {
  /// See also [Search].
  SearchProvider(
    String searchQuery,
  ) : this._internal(
          () => Search()..searchQuery = searchQuery,
          from: searchProvider,
          name: r'searchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchHash,
          dependencies: SearchFamily._dependencies,
          allTransitiveDependencies: SearchFamily._allTransitiveDependencies,
          searchQuery: searchQuery,
        );

  SearchProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchQuery,
  }) : super.internal();

  final String searchQuery;

  @override
  FutureOr<List<CategoryListItem>> runNotifierBuild(
    covariant Search notifier,
  ) {
    return notifier.build(
      searchQuery,
    );
  }

  @override
  Override overrideWith(Search Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchProvider._internal(
        () => create()..searchQuery = searchQuery,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchQuery: searchQuery,
      ),
    );
  }

  @override
  (String,) get argument {
    return (searchQuery,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Search, List<CategoryListItem>>
      createElement() {
    return _SearchProviderElement(this);
  }

  SearchProvider _copyWith(
    Search Function() create,
  ) {
    return SearchProvider._internal(
      () => create()..searchQuery = searchQuery,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      searchQuery: searchQuery,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SearchProvider && other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchQuery.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchRef on AutoDisposeAsyncNotifierProviderRef<List<CategoryListItem>> {
  /// The parameter `searchQuery` of this provider.
  String get searchQuery;
}

class _SearchProviderElement extends AutoDisposeAsyncNotifierProviderElement<
    Search, List<CategoryListItem>> with SearchRef {
  _SearchProviderElement(super.provider);

  @override
  String get searchQuery => (origin as SearchProvider).searchQuery;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
