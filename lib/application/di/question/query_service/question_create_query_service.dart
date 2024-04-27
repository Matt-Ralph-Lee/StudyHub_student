import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../infrastructure/firebase/question/firebase_question_create_query_service.dart";
import "../../../../infrastructure/firebase/student/firebase_student_repository.dart";
import "../../../../infrastructure/in_memory/question/in_memory_question_create_query_service.dart";
import "../../../../infrastructure/in_memory/student/in_memory_student_repository.dart";
import "../../../question/application_service/i_question_create_query_service.dart";
import "../../../shared/flavor/flavor.dart";
import "../../../shared/flavor/flavor_config.dart";

part 'question_create_query_service.g.dart';

@riverpod
IQuestionCreateQueryService questionCreateQueryServiceDi(
    QuestionCreateQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryQuestionCreateQueryService(
          repository: InMemoryStudentRepository());
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseQuestionCreateQueryService(FirebaseStudentRepository());
  }
}
