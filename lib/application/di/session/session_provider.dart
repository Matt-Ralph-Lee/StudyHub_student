import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/session/session.dart';
import '../student_auth/student_auth_provider.dart';

part 'session_provider.g.dart';

@riverpod
Stream<Session?> sessionStreamDi(SessionStreamDiRef ref) {
  final studentAuth = ref.watch(studentAuthDiProvider);
  final state = studentAuth.accountState();
  return state.map((studentAuthInfo) {
    return studentAuthInfo == null
        ? null
        : Session(studentAuthInfo.studentId, studentAuthInfo.isVerified);
  });
}

@riverpod
Session? sessionDi(SessionDiRef ref) {
  final sessionStream = ref.watch(sessionStreamDiProvider);
  return sessionStream.when(
    data: (session) => session,
    error: (_, __) => null, // TODO: error時の処理,
    loading: () => null,
  );
}
