// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_answer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAnswerControllerHash() =>
    r'7d2d4efdd49a2d125b7cc5008be85a71af3efe58';

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

abstract class _$GetAnswerController
    extends BuildlessAutoDisposeAsyncNotifier<List<AnswerDto>> {
  late final QuestionId questionId;

  FutureOr<List<AnswerDto>> build(
    QuestionId questionId,
  );
}

/// See also [GetAnswerController].
@ProviderFor(GetAnswerController)
const getAnswerControllerProvider = GetAnswerControllerFamily();

/// See also [GetAnswerController].
class GetAnswerControllerFamily extends Family<AsyncValue<List<AnswerDto>>> {
  /// See also [GetAnswerController].
  const GetAnswerControllerFamily();

  /// See also [GetAnswerController].
  GetAnswerControllerProvider call(
    QuestionId questionId,
  ) {
    return GetAnswerControllerProvider(
      questionId,
    );
  }

  @override
  GetAnswerControllerProvider getProviderOverride(
    covariant GetAnswerControllerProvider provider,
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
  String? get name => r'getAnswerControllerProvider';
}

/// See also [GetAnswerController].
class GetAnswerControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetAnswerController, List<AnswerDto>> {
  /// See also [GetAnswerController].
  GetAnswerControllerProvider(
    QuestionId questionId,
  ) : this._internal(
          () => GetAnswerController()..questionId = questionId,
          from: getAnswerControllerProvider,
          name: r'getAnswerControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAnswerControllerHash,
          dependencies: GetAnswerControllerFamily._dependencies,
          allTransitiveDependencies:
              GetAnswerControllerFamily._allTransitiveDependencies,
          questionId: questionId,
        );

  GetAnswerControllerProvider._internal(
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
  FutureOr<List<AnswerDto>> runNotifierBuild(
    covariant GetAnswerController notifier,
  ) {
    return notifier.build(
      questionId,
    );
  }

  @override
  Override overrideWith(GetAnswerController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetAnswerControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetAnswerController, List<AnswerDto>>
      createElement() {
    return _GetAnswerControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAnswerControllerProvider &&
        other.questionId == questionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, questionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAnswerControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<AnswerDto>> {
  /// The parameter `questionId` of this provider.
  QuestionId get questionId;
}

class _GetAnswerControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetAnswerController,
        List<AnswerDto>> with GetAnswerControllerRef {
  _GetAnswerControllerProviderElement(super.provider);

  @override
  QuestionId get questionId =>
      (origin as GetAnswerControllerProvider).questionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
