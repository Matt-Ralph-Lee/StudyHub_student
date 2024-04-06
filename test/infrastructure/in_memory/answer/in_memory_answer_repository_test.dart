import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/infrastructure/in_memory/answer/in_memory_answer_repository.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_repository.dart';

void main() {
  final answerRepository = InMemoryAnswerRepository();
  setUp(() => null);
  group('in-memory answer repository', () {
    test('should have initial values', () {
      expect(answerRepository.store.length, 3);
    });
  });
  group('method', () {
    test('getByQuestionId should return value normally', () async {
      final answerList1 = await answerRepository
          .getByQuestionId(InMemoryQuestionIdInitialValue.questionId1FromS1);
      expect(answerList1.length, 1);
      expect(answerList1[0].answerId,
          InMemoryAnswerIdInitialValue.answerId1FromT1ToQ1);
      final answerList2 = await answerRepository
          .getByQuestionId(InMemoryQuestionIdInitialValue.questionId2FromS2);
      expect(answerList2.length, 2);
      expect(answerList2[0].answerId,
          InMemoryAnswerIdInitialValue.answerId2FromT2ToQ2);
      expect(answerList2[1].answerId,
          InMemoryAnswerIdInitialValue.answerId3FromT2ToQ2);
    });
  });
}
