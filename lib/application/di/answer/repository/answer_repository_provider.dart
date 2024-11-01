import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/answer_list/models/i_answer_repository.dart';
import '../../../../infrastructure/firebase/answer/firebase_answer_repository.dart';
import '../../../../infrastructure/in_memory/answer/in_memory_answer_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';

part 'answer_repository_provider.g.dart';

@riverpod
IAnswerRepository answerRepositoryDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryAnswerRepository();
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseAnswerRepository();
  }
}
