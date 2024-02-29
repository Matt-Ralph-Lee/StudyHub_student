import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/session/session.dart';
import '../student_auth/student_auth_provider.dart';

final sessionTestProvider = Provider((ref) {
  final studentAuth = ref.watch(studentAuthProvider);
  final state = studentAuth.accountState();
  return state.map((studentAuthInfo) {
    return studentAuthInfo == null
        ? null
        : Session(studentAuthInfo.studentId, studentAuthInfo.isVerified);
  });
});
