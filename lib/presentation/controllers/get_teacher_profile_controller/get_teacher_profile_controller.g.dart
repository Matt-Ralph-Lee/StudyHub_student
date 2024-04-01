// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_teacher_profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTeacherProfileControllerHash() =>
    r'ce4517019bd7a95d25c184e7a347857a33306df5';

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

abstract class _$GetTeacherProfileController
    extends BuildlessAutoDisposeAsyncNotifier<GetTeacherProfileDto?> {
  late final TeacherId teacherID;

  FutureOr<GetTeacherProfileDto?> build(
    TeacherId teacherID,
  );
}

/// See also [GetTeacherProfileController].
@ProviderFor(GetTeacherProfileController)
const getTeacherProfileControllerProvider = GetTeacherProfileControllerFamily();

/// See also [GetTeacherProfileController].
class GetTeacherProfileControllerFamily
    extends Family<AsyncValue<GetTeacherProfileDto?>> {
  /// See also [GetTeacherProfileController].
  const GetTeacherProfileControllerFamily();

  /// See also [GetTeacherProfileController].
  GetTeacherProfileControllerProvider call(
    TeacherId teacherID,
  ) {
    return GetTeacherProfileControllerProvider(
      teacherID,
    );
  }

  @override
  GetTeacherProfileControllerProvider getProviderOverride(
    covariant GetTeacherProfileControllerProvider provider,
  ) {
    return call(
      provider.teacherID,
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
  String? get name => r'getTeacherProfileControllerProvider';
}

/// See also [GetTeacherProfileController].
class GetTeacherProfileControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetTeacherProfileController,
        GetTeacherProfileDto?> {
  /// See also [GetTeacherProfileController].
  GetTeacherProfileControllerProvider(
    TeacherId teacherID,
  ) : this._internal(
          () => GetTeacherProfileController()..teacherID = teacherID,
          from: getTeacherProfileControllerProvider,
          name: r'getTeacherProfileControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTeacherProfileControllerHash,
          dependencies: GetTeacherProfileControllerFamily._dependencies,
          allTransitiveDependencies:
              GetTeacherProfileControllerFamily._allTransitiveDependencies,
          teacherID: teacherID,
        );

  GetTeacherProfileControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teacherID,
  }) : super.internal();

  final TeacherId teacherID;

  @override
  FutureOr<GetTeacherProfileDto?> runNotifierBuild(
    covariant GetTeacherProfileController notifier,
  ) {
    return notifier.build(
      teacherID,
    );
  }

  @override
  Override overrideWith(GetTeacherProfileController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetTeacherProfileControllerProvider._internal(
        () => create()..teacherID = teacherID,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teacherID: teacherID,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetTeacherProfileController,
      GetTeacherProfileDto?> createElement() {
    return _GetTeacherProfileControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTeacherProfileControllerProvider &&
        other.teacherID == teacherID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teacherID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTeacherProfileControllerRef
    on AutoDisposeAsyncNotifierProviderRef<GetTeacherProfileDto?> {
  /// The parameter `teacherID` of this provider.
  TeacherId get teacherID;
}

class _GetTeacherProfileControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetTeacherProfileController,
        GetTeacherProfileDto?> with GetTeacherProfileControllerRef {
  _GetTeacherProfileControllerProviderElement(super.provider);

  @override
  TeacherId get teacherID =>
      (origin as GetTeacherProfileControllerProvider).teacherID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
