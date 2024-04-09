import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/question/models/i_question_repository.dart';
import '../../../../infrastructure/firebase/question/firebase_question_repository.dart';
import '../../../../infrastructure/in_memory/question/in_memory_question_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';

part 'question_repository_provider.g.dart';

@riverpod
IQuestionRepository questionRepositoryDi(QuestionRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryQuestionRepository();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw FirebaseQuestionRepository();
  }
}
