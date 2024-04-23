import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_repository.dart';

void main() {
  final questionRepository = InMemoryQuestionRepository();
  setUp(() => null);
  group('in-memory question repository', () {
    test('should have initial values', () {
      expect(questionRepository.store.length, 2);
      expect(
          questionRepository.store
              .containsKey(InMemoryQuestionIdInitialValue.questionId1FromS1),
          true);
    });
  });
}
