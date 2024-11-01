// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_for_teachers_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchForTeachersControllerHash() =>
    r'92cf587837533414bcb99c866b2d2e90160ec366';

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

abstract class _$SearchForTeachersController
    extends BuildlessAutoDisposeAsyncNotifier<List<SearchForTeacherDto>?> {
  late final String searchTerm;

  FutureOr<List<SearchForTeacherDto>?> build(
    String searchTerm,
  );
}

/// See also [SearchForTeachersController].
@ProviderFor(SearchForTeachersController)
const searchForTeachersControllerProvider = SearchForTeachersControllerFamily();

/// See also [SearchForTeachersController].
class SearchForTeachersControllerFamily
    extends Family<AsyncValue<List<SearchForTeacherDto>?>> {
  /// See also [SearchForTeachersController].
  const SearchForTeachersControllerFamily();

  /// See also [SearchForTeachersController].
  SearchForTeachersControllerProvider call(
    String searchTerm,
  ) {
    return SearchForTeachersControllerProvider(
      searchTerm,
    );
  }

  @override
  SearchForTeachersControllerProvider getProviderOverride(
    covariant SearchForTeachersControllerProvider provider,
  ) {
    return call(
      provider.searchTerm,
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
  String? get name => r'searchForTeachersControllerProvider';
}

/// See also [SearchForTeachersController].
class SearchForTeachersControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SearchForTeachersController,
        List<SearchForTeacherDto>?> {
  /// See also [SearchForTeachersController].
  SearchForTeachersControllerProvider(
    String searchTerm,
  ) : this._internal(
          () => SearchForTeachersController()..searchTerm = searchTerm,
          from: searchForTeachersControllerProvider,
          name: r'searchForTeachersControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchForTeachersControllerHash,
          dependencies: SearchForTeachersControllerFamily._dependencies,
          allTransitiveDependencies:
              SearchForTeachersControllerFamily._allTransitiveDependencies,
          searchTerm: searchTerm,
        );

  SearchForTeachersControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchTerm,
  }) : super.internal();

  final String searchTerm;

  @override
  FutureOr<List<SearchForTeacherDto>?> runNotifierBuild(
    covariant SearchForTeachersController notifier,
  ) {
    return notifier.build(
      searchTerm,
    );
  }

  @override
  Override overrideWith(SearchForTeachersController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchForTeachersControllerProvider._internal(
        () => create()..searchTerm = searchTerm,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchTerm: searchTerm,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SearchForTeachersController,
      List<SearchForTeacherDto>?> createElement() {
    return _SearchForTeachersControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchForTeachersControllerProvider &&
        other.searchTerm == searchTerm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchTerm.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchForTeachersControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<SearchForTeacherDto>?> {
  /// The parameter `searchTerm` of this provider.
  String get searchTerm;
}

class _SearchForTeachersControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SearchForTeachersController,
        List<SearchForTeacherDto>?> with SearchForTeachersControllerRef {
  _SearchForTeachersControllerProviderElement(super.provider);

  @override
  String get searchTerm =>
      (origin as SearchForTeachersControllerProvider).searchTerm;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
