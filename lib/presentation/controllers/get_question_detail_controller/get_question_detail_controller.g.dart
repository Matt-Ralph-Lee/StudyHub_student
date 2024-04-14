// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_question_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getQuestionDetailControllerHash() =>
    r'df6248c0d38dd65167a1ee888f22b8c2a6be5fe5';

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

abstract class _$GetQuestionDetailController
    extends BuildlessAutoDisposeAsyncNotifier<QuestionDetailDto> {
  late final QuestionId questionId;

  FutureOr<QuestionDetailDto> build(
    QuestionId questionId,
  );
}

/// See also [GetQuestionDetailController].
@ProviderFor(GetQuestionDetailController)
const getQuestionDetailControllerProvider = GetQuestionDetailControllerFamily();

/// See also [GetQuestionDetailController].
class GetQuestionDetailControllerFamily
    extends Family<AsyncValue<QuestionDetailDto>> {
  /// See also [GetQuestionDetailController].
  const GetQuestionDetailControllerFamily();

  /// See also [GetQuestionDetailController].
  GetQuestionDetailControllerProvider call(
    QuestionId questionId,
  ) {
    return GetQuestionDetailControllerProvider(
      questionId,
    );
  }

  @override
  GetQuestionDetailControllerProvider getProviderOverride(
    covariant GetQuestionDetailControllerProvider provider,
  ) {
    return call(
      provider.questionId,
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
  String? get name => r'getQuestionDetailControllerProvider';
}

/// See also [GetQuestionDetailController].
class GetQuestionDetailControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetQuestionDetailController,
        QuestionDetailDto> {
  /// See also [GetQuestionDetailController].
  GetQuestionDetailControllerProvider(
    QuestionId questionId,
  ) : this._internal(
          () => GetQuestionDetailController()..questionId = questionId,
          from: getQuestionDetailControllerProvider,
          name: r'getQuestionDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getQuestionDetailControllerHash,
          dependencies: GetQuestionDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              GetQuestionDetailControllerFamily._allTransitiveDependencies,
          questionId: questionId,
        );

  GetQuestionDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.questionId,
  }) : super.internal();

  final QuestionId questionId;

  @override
  FutureOr<QuestionDetailDto> runNotifierBuild(
    covariant GetQuestionDetailController notifier,
  ) {
    return notifier.build(
      questionId,
    );
  }

  @override
  Override overrideWith(GetQuestionDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetQuestionDetailControllerProvider._internal(
        () => create()..questionId = questionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        questionId: questionId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetQuestionDetailController,
      QuestionDetailDto> createElement() {
    return _GetQuestionDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetQuestionDetailControllerProvider &&
        other.questionId == questionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, questionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetQuestionDetailControllerRef
    on AutoDisposeAsyncNotifierProviderRef<QuestionDetailDto> {
  /// The parameter `questionId` of this provider.
  QuestionId get questionId;
}

class _GetQuestionDetailControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetQuestionDetailController,
        QuestionDetailDto> with GetQuestionDetailControllerRef {
  _GetQuestionDetailControllerProviderElement(super.provider);

  @override
  QuestionId get questionId =>
      (origin as GetQuestionDetailControllerProvider).questionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
