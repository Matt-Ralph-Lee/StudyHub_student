// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountStateChangesHash() =>
    r'cdc73e282fbc6e14c04b8f76a1aedae339dd93f4';

/// See also [accountStateChanges].
@ProviderFor(accountStateChanges)
final accountStateChangesProvider =
    AutoDisposeStreamProvider<Account?>.internal(
  accountStateChanges,
  name: r'accountStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountStateChangesRef = AutoDisposeStreamProviderRef<Account?>;
String _$accountHash() => r'c4b1ef03563e1ea684b4e5e06b6faadf183bd3ae';

/// See also [account].
@ProviderFor(account)
final accountProvider = AutoDisposeProvider<Account?>.internal(
  account,
  name: r'accountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountRef = AutoDisposeProviderRef<Account?>;
String _$signedInHash() => r'9429f37dcb48d25bb1c689742328fd99c67a7ea0';

/// See also [signedIn].
@ProviderFor(signedIn)
final signedInProvider = AutoDisposeProvider<bool>.internal(
  signedIn,
  name: r'signedInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SignedInRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
