import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../infrastructure/firebase/student-auth/firebase_get_student_auth_query_service.dart';
import '../../../infrastructure/firebase/student-auth/firebase_student_auth_repository.dart';
import '../../../infrastructure/in_memory/student_auth/in_memory_get_student_auth_query_service.dart';
import '../../../infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';
import '../../student_auth/application_service/i_get_student_auth_query_service.dart';

part 'student_auth_provider.g.dart';

@riverpod
IStudentAuthRepository studentAuthRepositoryDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryStudentAuthRepository();
    case Flavor.stg:
      return FirebaseStudentAuthRepository(
          firebaseAuth: ref.watch(firebaseAuthProvider));
    case Flavor.prd:
      return FirebaseStudentAuthRepository(
          firebaseAuth: ref.watch(firebaseAuthProvider));
  }
}

@riverpod
IGetStudentAuthQueryService getStudentAuthQueryService(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetStudentAuthQueryService(
          repository: ref.watch(studentAuthRepositoryDiProvider)
              as InMemoryStudentAuthRepository);
    case Flavor.stg:
      return FirebaseGetStudentAuthQueryService(
          firebaseAuth: ref.watch(firebaseAuthProvider));
    case Flavor.prd:
      return FirebaseGetStudentAuthQueryService(
          firebaseAuth: ref.watch(firebaseAuthProvider));
  }
}

@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}
