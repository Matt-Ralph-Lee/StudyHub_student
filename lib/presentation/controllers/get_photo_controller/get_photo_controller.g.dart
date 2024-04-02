// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_photo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPhotoControllerHash() =>
    r'cc6b377cf59cf800dd68e18f5f8d6af5ff007135';

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
    extends BuildlessAutoDisposeAsyncNotifier<Uint8List> {
  late final String path;

  FutureOr<Uint8List> build(
    String path,
  );
}

/// See also [GetPhotoController].
@ProviderFor(GetPhotoController)
const getPhotoControllerProvider = GetPhotoControllerFamily();

/// See also [GetPhotoController].
class GetPhotoControllerFamily extends Family<AsyncValue<Uint8List>> {
  /// See also [GetPhotoController].
  const GetPhotoControllerFamily();

  /// See also [GetPhotoController].
  GetPhotoControllerProvider call(
    String path,
  ) {
    return GetPhotoControllerProvider(
      path,
    );
  }

  @override
  GetPhotoControllerProvider getProviderOverride(
    covariant GetPhotoControllerProvider provider,
  ) {
    return call(
      provider.path,
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
    GetPhotoController, Uint8List> {
  /// See also [GetPhotoController].
  GetPhotoControllerProvider(
    String path,
  ) : this._internal(
          () => GetPhotoController()..path = path,
          from: getPhotoControllerProvider,
          name: r'getPhotoControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPhotoControllerHash,
          dependencies: GetPhotoControllerFamily._dependencies,
          allTransitiveDependencies:
              GetPhotoControllerFamily._allTransitiveDependencies,
          path: path,
        );

  GetPhotoControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  FutureOr<Uint8List> runNotifierBuild(
    covariant GetPhotoController notifier,
  ) {
    return notifier.build(
      path,
    );
  }

  @override
  Override overrideWith(GetPhotoController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPhotoControllerProvider._internal(
        () => create()..path = path,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetPhotoController, Uint8List>
      createElement() {
    return _GetPhotoControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPhotoControllerProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPhotoControllerRef on AutoDisposeAsyncNotifierProviderRef<Uint8List> {
  /// The parameter `path` of this provider.
  String get path;
}

class _GetPhotoControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPhotoController,
        Uint8List> with GetPhotoControllerRef {
  _GetPhotoControllerProviderElement(super.provider);

  @override
  String get path => (origin as GetPhotoControllerProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
