// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serach_questions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchQuestionsControllerHash() =>
    r'd661bdceb33e6308fd6b6cf2f2d1b6fa0364e81d';

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

abstract class _$SearchQuestionsController
    extends BuildlessAutoDisposeAsyncNotifier<List<QuestionCardDto>?> {
  late final String searchTerm;

  FutureOr<List<QuestionCardDto>?> build(
    String searchTerm,
  );
}

/// See also [SearchQuestionsController].
@ProviderFor(SearchQuestionsController)
const searchQuestionsControllerProvider = SearchQuestionsControllerFamily();

/// See also [SearchQuestionsController].
class SearchQuestionsControllerFamily
    extends Family<AsyncValue<List<QuestionCardDto>?>> {
  /// See also [SearchQuestionsController].
  const SearchQuestionsControllerFamily();

  /// See also [SearchQuestionsController].
  SearchQuestionsControllerProvider call(
    String searchTerm,
  ) {
    return SearchQuestionsControllerProvider(
      searchTerm,
    );
  }

  @override
  SearchQuestionsControllerProvider getProviderOverride(
    covariant SearchQuestionsControllerProvider provider,
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
  String? get name => r'searchQuestionsControllerProvider';
}

/// See also [SearchQuestionsController].
class SearchQuestionsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SearchQuestionsController,
        List<QuestionCardDto>?> {
  /// See also [SearchQuestionsController].
  SearchQuestionsControllerProvider(
    String searchTerm,
  ) : this._internal(
          () => SearchQuestionsController()..searchTerm = searchTerm,
          from: searchQuestionsControllerProvider,
          name: r'searchQuestionsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchQuestionsControllerHash,
          dependencies: SearchQuestionsControllerFamily._dependencies,
          allTransitiveDependencies:
              SearchQuestionsControllerFamily._allTransitiveDependencies,
          searchTerm: searchTerm,
        );

  SearchQuestionsControllerProvider._internal(
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
  FutureOr<List<QuestionCardDto>?> runNotifierBuild(
    covariant SearchQuestionsController notifier,
  ) {
    return notifier.build(
      searchTerm,
    );
  }

  @override
  Override overrideWith(SearchQuestionsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchQuestionsControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SearchQuestionsController,
      List<QuestionCardDto>?> createElement() {
    return _SearchQuestionsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchQuestionsControllerProvider &&
        other.searchTerm == searchTerm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchTerm.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchQuestionsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<QuestionCardDto>?> {
  /// The parameter `searchTerm` of this provider.
  String get searchTerm;
}

class _SearchQuestionsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SearchQuestionsController,
        List<QuestionCardDto>?> with SearchQuestionsControllerRef {
  _SearchQuestionsControllerProviderElement(super.provider);

  @override
  String get searchTerm =>
      (origin as SearchQuestionsControllerProvider).searchTerm;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
