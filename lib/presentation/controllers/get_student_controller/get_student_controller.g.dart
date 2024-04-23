// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_student_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getStudentControllerHash() =>
    r'8363fe9f2fc190d4a4a14302169121503b87f379';

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

abstract class _$GetStudentController
    extends BuildlessAutoDisposeAsyncNotifier<GetStudentDto> {
  late final StudentId studentId;

  FutureOr<GetStudentDto> build(
    StudentId studentId,
  );
}

/// See also [GetStudentController].
@ProviderFor(GetStudentController)
const getStudentControllerProvider = GetStudentControllerFamily();

/// See also [GetStudentController].
class GetStudentControllerFamily extends Family<AsyncValue<GetStudentDto>> {
  /// See also [GetStudentController].
  const GetStudentControllerFamily();

  /// See also [GetStudentController].
  GetStudentControllerProvider call(
    StudentId studentId,
  ) {
    return GetStudentControllerProvider(
      studentId,
    );
  }

  @override
  GetStudentControllerProvider getProviderOverride(
    covariant GetStudentControllerProvider provider,
  ) {
    return call(
      provider.studentId,
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
  String? get name => r'getStudentControllerProvider';
}

/// See also [GetStudentController].
class GetStudentControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetStudentController, GetStudentDto> {
  /// See also [GetStudentController].
  GetStudentControllerProvider(
    StudentId studentId,
  ) : this._internal(
          () => GetStudentController()..studentId = studentId,
          from: getStudentControllerProvider,
          name: r'getStudentControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getStudentControllerHash,
          dependencies: GetStudentControllerFamily._dependencies,
          allTransitiveDependencies:
              GetStudentControllerFamily._allTransitiveDependencies,
          studentId: studentId,
        );

  GetStudentControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final StudentId studentId;

  @override
  FutureOr<GetStudentDto> runNotifierBuild(
    covariant GetStudentController notifier,
  ) {
    return notifier.build(
      studentId,
    );
  }

  @override
  Override overrideWith(GetStudentController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetStudentControllerProvider._internal(
        () => create()..studentId = studentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetStudentController, GetStudentDto>
      createElement() {
    return _GetStudentControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetStudentControllerProvider &&
        other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetStudentControllerRef
    on AutoDisposeAsyncNotifierProviderRef<GetStudentDto> {
  /// The parameter `studentId` of this provider.
  StudentId get studentId;
}

class _GetStudentControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetStudentController,
        GetStudentDto> with GetStudentControllerRef {
  _GetStudentControllerProviderElement(super.provider);

  @override
  StudentId get studentId => (origin as GetStudentControllerProvider).studentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
