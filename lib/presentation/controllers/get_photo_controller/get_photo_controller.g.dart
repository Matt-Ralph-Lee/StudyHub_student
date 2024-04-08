// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_photo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPhotoControllerHash() =>
    r'919a3647cafb8826db60110feb59257af4b2ea6c';

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

abstract class _$GetPhotoController
    extends BuildlessAutoDisposeAsyncNotifier<ImageProvider> {
  late final String photoPathData;

  FutureOr<ImageProvider> build(
    String photoPathData,
  );
}

/// See also [GetPhotoController].
@ProviderFor(GetPhotoController)
const getPhotoControllerProvider = GetPhotoControllerFamily();

/// See also [GetPhotoController].
class GetPhotoControllerFamily extends Family<AsyncValue<ImageProvider>> {
  /// See also [GetPhotoController].
  const GetPhotoControllerFamily();

  /// See also [GetPhotoController].
  GetPhotoControllerProvider call(
    String photoPathData,
  ) {
    return GetPhotoControllerProvider(
      photoPathData,
    );
  }

  @override
  GetPhotoControllerProvider getProviderOverride(
    covariant GetPhotoControllerProvider provider,
  ) {
    return call(
      provider.photoPathData,
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
  String? get name => r'getPhotoControllerProvider';
}

/// See also [GetPhotoController].
class GetPhotoControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetPhotoController, ImageProvider> {
  /// See also [GetPhotoController].
  GetPhotoControllerProvider(
    String photoPathData,
  ) : this._internal(
          () => GetPhotoController()..photoPathData = photoPathData,
          from: getPhotoControllerProvider,
          name: r'getPhotoControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPhotoControllerHash,
          dependencies: GetPhotoControllerFamily._dependencies,
          allTransitiveDependencies:
              GetPhotoControllerFamily._allTransitiveDependencies,
          photoPathData: photoPathData,
        );

  GetPhotoControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.photoPathData,
  }) : super.internal();

  final String photoPathData;

  @override
  FutureOr<ImageProvider> runNotifierBuild(
    covariant GetPhotoController notifier,
  ) {
    return notifier.build(
      photoPathData,
    );
  }

  @override
  Override overrideWith(GetPhotoController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPhotoControllerProvider._internal(
        () => create()..photoPathData = photoPathData,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        photoPathData: photoPathData,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetPhotoController, ImageProvider>
      createElement() {
    return _GetPhotoControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPhotoControllerProvider &&
        other.photoPathData == photoPathData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, photoPathData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPhotoControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ImageProvider> {
  /// The parameter `photoPathData` of this provider.
  String get photoPathData;
}

class _GetPhotoControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPhotoController,
        ImageProvider> with GetPhotoControllerRef {
  _GetPhotoControllerProviderElement(super.provider);

  @override
  String get photoPathData =>
      (origin as GetPhotoControllerProvider).photoPathData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
