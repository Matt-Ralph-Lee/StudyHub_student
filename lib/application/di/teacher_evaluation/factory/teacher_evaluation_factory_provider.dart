import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../domain/teacher_evaluation/models/i_teacher_evaluation_factory.dart";
import "../../../../infrastructure/firebase/teacher_evaluation/firebase_teacher_evaluation_factory.dart";
import "../../../../infrastructure/firebase/teacher_evaluation/firebase_teacher_evaluation_repository.dart";
import "../../../../infrastructure/in_memory/teacher_evaluation/in_memory_teacher_evaluation_factory.dart";
import "../../../../infrastructure/in_memory/teacher_evaluation/in_memory_teacher_evaluation_repository.dart";
import "../../../shared/flavor/flavor.dart";
import "../../../shared/flavor/flavor_config.dart";

part 'teacher_evaluation_factory_provider.g.dart';

@riverpod
ITeacherEvaluationFactory teacherEvaluationFactoryDi(
    TeacherEvaluationFactoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryTeacherEvaluationFactory(
          InMemoryTeacherEvaluationRepository());
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      return FirebaseTeacherEvaluationFactory(
          FirebaseTeacherEvaluationRepository());
  }
}
