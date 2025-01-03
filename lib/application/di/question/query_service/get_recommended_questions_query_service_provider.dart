import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/firebase/question/firebase_get_recommended_questions_query_service.dart';
import '../../../../infrastructure/firebase/question/firebase_question_repository.dart';
import '../../../../infrastructure/firebase/student/firebase_student_repository.dart';
import '../../../../infrastructure/firebase/teacher/firebase_teacher_repository.dart';
import '../../../../infrastructure/in_memory/question/in_memory_get_recommended_questions_query_service.dart';
import '../../../../infrastructure/in_memory/question/in_memory_question_repository.dart';
import '../../../../infrastructure/in_memory/student/in_memory_student_repository.dart';
import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../../question/application_service/i_get_recommended_questions_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../../student/student_provider.dart';
import '../../teacher/teacher_provider.dart';
import '../repository/question_repository_provider.dart';

part 'get_recommended_questions_query_service_provider.g.dart';

@riverpod
IGetRecommendedQuestionsQueryService getRecommendedQuestionQueryServiceDi(
    Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetRecommendedQuestionsQueryService(
        repository: (ref.watch(questionRepositoryDiProvider))
            as InMemoryQuestionRepository,
        studentRepository: (ref.watch(studentRepositoryDiProvider))
            as InMemoryStudentRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as InMemoryTeacherRepository,
      );
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseGetRecommendedQuestionsQueryService(
        repository: (ref.watch(questionRepositoryDiProvider))
            as FirebaseQuestionRepository,
        studentRepository: (ref.watch(studentRepositoryDiProvider))
            as FirebaseStudentRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as FirebaseTeacherRepository,
      );
  }
}
