import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/question/application_service/get_my_questions_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/student/models/student_id.dart';

void main() {
    final session = MockSession();
    final queryService = InMemory
  setUp(() => null);
  group('execute usecase properly', () {
    test('', () {
      GetMyQuestionsUseCase(session: session, queryService: queryService)
  });
});
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}