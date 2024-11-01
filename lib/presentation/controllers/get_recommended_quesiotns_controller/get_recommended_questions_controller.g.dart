// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_recommended_questions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRecommendedQuestionsControllerHash() =>
    r'1d368b6470e0d84646dc6f0625abd69c9e6c08a9';

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

abstract class _$GetRecommendedQuestionsController
    extends BuildlessAutoDisposeAsyncNotifier<List<QuestionCardDto>> {
  late final Subject? subject;

  FutureOr<List<QuestionCardDto>> build(
    Subject? subject,
  );
}

/// See also [GetRecommendedQuestionsController].
@ProviderFor(GetRecommendedQuestionsController)
const getRecommendedQuestionsControllerProvider =
    GetRecommendedQuestionsControllerFamily();

/// See also [GetRecommendedQuestionsController].
class GetRecommendedQuestionsControllerFamily
    extends Family<AsyncValue<List<QuestionCardDto>>> {
  /// See also [GetRecommendedQuestionsController].
  const GetRecommendedQuestionsControllerFamily();

  /// See also [GetRecommendedQuestionsController].
  GetRecommendedQuestionsControllerProvider call(
    Subject? subject,
  ) {
    return GetRecommendedQuestionsControllerProvider(
      subject,
    );
  }

  @override
  GetRecommendedQuestionsControllerProvider getProviderOverride(
    covariant GetRecommendedQuestionsControllerProvider provider,
  ) {
    return call(
      provider.subject,
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
  String? get name => r'getRecommendedQuestionsControllerProvider';
}

/// See also [GetRecommendedQuestionsController].
class GetRecommendedQuestionsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        GetRecommendedQuestionsController, List<QuestionCardDto>> {
  /// See also [GetRecommendedQuestionsController].
  GetRecommendedQuestionsControllerProvider(
    Subject? subject,
  ) : this._internal(
          () => GetRecommendedQuestionsController()..subject = subject,
          from: getRecommendedQuestionsControllerProvider,
          name: r'getRecommendedQuestionsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRecommendedQuestionsControllerHash,
          dependencies: GetRecommendedQuestionsControllerFamily._dependencies,
          allTransitiveDependencies: GetRecommendedQuestionsControllerFamily
              ._allTransitiveDependencies,
          subject: subject,
        );

  GetRecommendedQuestionsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subject,
  }) : super.internal();

  final Subject? subject;

  @override
  FutureOr<List<QuestionCardDto>> runNotifierBuild(
    covariant GetRecommendedQuestionsController notifier,
  ) {
    return notifier.build(
      subject,
    );
  }

  @override
  Override overrideWith(GetRecommendedQuestionsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetRecommendedQuestionsControllerProvider._internal(
        () => create()..subject = subject,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subject: subject,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetRecommendedQuestionsController,
      List<QuestionCardDto>> createElement() {
    return _GetRecommendedQuestionsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetRecommendedQuestionsControllerProvider &&
        other.subject == subject;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subject.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetRecommendedQuestionsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<QuestionCardDto>> {
  /// The parameter `subject` of this provider.
  Subject? get subject;
}

class _GetRecommendedQuestionsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        GetRecommendedQuestionsController,
        List<QuestionCardDto>> with GetRecommendedQuestionsControllerRef {
  _GetRecommendedQuestionsControllerProviderElement(super.provider);

  @override
  Subject? get subject =>
      (origin as GetRecommendedQuestionsControllerProvider).subject;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
