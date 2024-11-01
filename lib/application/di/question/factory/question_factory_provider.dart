import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/question/models/i_question_factory.dart';
import '../../../../infrastructure/firebase/question/firebase_question_factory.dart';
import '../../../../infrastructure/firebase/question/firebase_question_repository.dart';
import '../../../../infrastructure/in_memory/question/in_memory_question_factory.dart';
import '../../../../infrastructure/in_memory/question/in_memory_question_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../repository/question_repository_provider.dart';

part 'question_factory_provider.g.dart';

@riverpod
IQuestionFactory questionFactoryDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryQuestionFactory((ref.watch(questionRepositoryDiProvider))
          as InMemoryQuestionRepository);
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseQuestionFactory((ref.watch(questionRepositoryDiProvider))
          as FirebaseQuestionRepository);
  }
}
