// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_teacher_evaluation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTeacherEvaluationControllerHash() =>
    r'98925c505644756f6f9524c5453b0f43dd5d76b7';

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

abstract class _$GetTeacherEvaluationController
    extends BuildlessAutoDisposeAsyncNotifier<List<GetTeacherEvaluationDto>> {
  late final TeacherId teacherId;

  FutureOr<List<GetTeacherEvaluationDto>> build(
    TeacherId teacherId,
  );
}

/// See also [GetTeacherEvaluationController].
@ProviderFor(GetTeacherEvaluationController)
const getTeacherEvaluationControllerProvider =
    GetTeacherEvaluationControllerFamily();

/// See also [GetTeacherEvaluationController].
class GetTeacherEvaluationControllerFamily
    extends Family<AsyncValue<List<GetTeacherEvaluationDto>>> {
  /// See also [GetTeacherEvaluationController].
  const GetTeacherEvaluationControllerFamily();

  /// See also [GetTeacherEvaluationController].
  GetTeacherEvaluationControllerProvider call(
    TeacherId teacherId,
  ) {
    return GetTeacherEvaluationControllerProvider(
      teacherId,
    );
  }

  @override
  GetTeacherEvaluationControllerProvider getProviderOverride(
    covariant GetTeacherEvaluationControllerProvider provider,
  ) {
    return call(
      provider.teacherId,
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
  String? get name => r'getTeacherEvaluationControllerProvider';
}

/// See also [GetTeacherEvaluationController].
class GetTeacherEvaluationControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetTeacherEvaluationController,
        List<GetTeacherEvaluationDto>> {
  /// See also [GetTeacherEvaluationController].
  GetTeacherEvaluationControllerProvider(
    TeacherId teacherId,
  ) : this._internal(
          () => GetTeacherEvaluationController()..teacherId = teacherId,
          from: getTeacherEvaluationControllerProvider,
          name: r'getTeacherEvaluationControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTeacherEvaluationControllerHash,
          dependencies: GetTeacherEvaluationControllerFamily._dependencies,
          allTransitiveDependencies:
              GetTeacherEvaluationControllerFamily._allTransitiveDependencies,
          teacherId: teacherId,
        );

  GetTeacherEvaluationControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teacherId,
  }) : super.internal();

  final TeacherId teacherId;

  @override
  FutureOr<List<GetTeacherEvaluationDto>> runNotifierBuild(
    covariant GetTeacherEvaluationController notifier,
  ) {
    return notifier.build(
      teacherId,
    );
  }

  @override
  Override overrideWith(GetTeacherEvaluationController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetTeacherEvaluationControllerProvider._internal(
        () => create()..teacherId = teacherId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teacherId: teacherId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetTeacherEvaluationController,
      List<GetTeacherEvaluationDto>> createElement() {
    return _GetTeacherEvaluationControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTeacherEvaluationControllerProvider &&
        other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teacherId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetTeacherEvaluationControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<GetTeacherEvaluationDto>> {
  /// The parameter `teacherId` of this provider.
  TeacherId get teacherId;
}

class _GetTeacherEvaluationControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        GetTeacherEvaluationController,
        List<GetTeacherEvaluationDto>> with GetTeacherEvaluationControllerRef {
  _GetTeacherEvaluationControllerProviderElement(super.provider);

  @override
  TeacherId get teacherId =>
      (origin as GetTeacherEvaluationControllerProvider).teacherId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
