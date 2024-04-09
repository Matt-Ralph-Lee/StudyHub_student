import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/session/session.dart';
import '../student_auth/student_auth_provider.dart';

part 'session_provider.g.dart';

@riverpod
Stream<Session?> _sessionStreamDi(_SessionStreamDiRef ref) {
  ref.keepAlive();
  final queryService = ref.watch(getStudentAuthQueryServiceProvider);
  final state = queryService.userChanges();
  return state.map((studentAuthInfo) {
    return studentAuthInfo == null
        ? null
        : Session(
            studentAuthInfo.studentId,
            studentAuthInfo.isVerified,
            studentAuthInfo.emailAddress,
          );
  });
}

@riverpod
Session? sessionDi(SessionDiRef ref) {
  final sessionStream = ref.watch(_sessionStreamDiProvider);
  return sessionStream.when(
    data: (session) => session,
    error: (_, __) => null, // TODO: error時の処理,
    loading: () => null,
  );
}

@riverpod
bool isSignedIn(IsSignedInRef ref) {
  final session = ref.watch(sessionDiProvider);
  return session != null;
}

@riverpod
Session nonNullSession(NonNullSessionRef ref) {
  final session = ref.watch(sessionDiProvider);
  return session!;
}
