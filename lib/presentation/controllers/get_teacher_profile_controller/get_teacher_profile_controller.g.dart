// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_teacher_profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTeacherProfileControllerHash() =>
    r'8b665696e742c32938b6c9301155edf28ee797a9';

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
  late final IGetTeacherProfileQueryService iGetTeacherProfileQueryService;

  FutureOr<GetTeacherProfileDto?> build(
    TeacherId teacherID,
    IGetTeacherProfileQueryService iGetTeacherProfileQueryService,
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
    IGetTeacherProfileQueryService iGetTeacherProfileQueryService,
  ) {
    return GetTeacherProfileControllerProvider(
      teacherID,
      iGetTeacherProfileQueryService,
    );
  }

  @override
  GetTeacherProfileControllerProvider getProviderOverride(
    covariant GetTeacherProfileControllerProvider provider,
  ) {
    return call(
      provider.teacherID,
      provider.iGetTeacherProfileQueryService,
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
    IGetTeacherProfileQueryService iGetTeacherProfileQueryService,
  ) : this._internal(
          () => GetTeacherProfileController()
            ..teacherID = teacherID
            ..iGetTeacherProfileQueryService = iGetTeacherProfileQueryService,
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
          iGetTeacherProfileQueryService: iGetTeacherProfileQueryService,
        );

  GetTeacherProfileControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teacherID,
    required this.iGetTeacherProfileQueryService,
  }) : super.internal();

  final TeacherId teacherID;
  final IGetTeacherProfileQueryService iGetTeacherProfileQueryService;

  @override
  FutureOr<GetTeacherProfileDto?> runNotifierBuild(
    covariant GetTeacherProfileController notifier,
  ) {
    return notifier.build(
      teacherID,
      iGetTeacherProfileQueryService,
    );
  }

  @override
  Override overrideWith(GetTeacherProfileController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetTeacherProfileControllerProvider._internal(
        () => create()
          ..teacherID = teacherID
          ..iGetTeacherProfileQueryService = iGetTeacherProfileQueryService,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teacherID: teacherID,
        iGetTeacherProfileQueryService: iGetTeacherProfileQueryService,
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
        other.teacherID == teacherID &&
        other.iGetTeacherProfileQueryService == iGetTeacherProfileQueryService;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teacherID.hashCode);
    hash = _SystemHash.combine(hash, iGetTeacherProfileQueryService.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTeacherProfileControllerRef
    on AutoDisposeAsyncNotifierProviderRef<GetTeacherProfileDto?> {
  /// The parameter `teacherID` of this provider.
  TeacherId get teacherID;

  /// The parameter `iGetTeacherProfileQueryService` of this provider.
  IGetTeacherProfileQueryService get iGetTeacherProfileQueryService;
}

class _GetTeacherProfileControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetTeacherProfileController,
        GetTeacherProfileDto?> with GetTeacherProfileControllerRef {
  _GetTeacherProfileControllerProviderElement(super.provider);

  @override
  TeacherId get teacherID =>
      (origin as GetTeacherProfileControllerProvider).teacherID;
  @override
  IGetTeacherProfileQueryService get iGetTeacherProfileQueryService =>
      (origin as GetTeacherProfileControllerProvider)
          .iGetTeacherProfileQueryService;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
