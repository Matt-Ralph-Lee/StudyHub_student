import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../infrastructure/firebase/account/firebase_account_factory.dart';

final accountFactoryProvider = Provider<FirebaseAccountFactory>((ref) {
  final repository = ref.watch(studentRepositoryProvider);
  return FirebaseAccountFactory(repository);
});
