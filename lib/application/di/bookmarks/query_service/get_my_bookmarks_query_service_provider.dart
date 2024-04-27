import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/firebase/bookmarks/firebase_bookmarks_query_service.dart';
import '../../../../infrastructure/firebase/bookmarks/firebase_bookmarks_repository.dart';
import '../../../../infrastructure/firebase/question/firebase_question_repository.dart';
import '../../../../infrastructure/firebase/student/firebase_student_repository.dart';
import '../../../../infrastructure/firebase/teacher/firebase_teacher_repository.dart';
import '../../../../infrastructure/in_memory/bookmarks/in_memory_bookmarks_query_service.dart';
import '../../../../infrastructure/in_memory/bookmarks/in_memory_bookmarks_repository.dart';
import '../../../../infrastructure/in_memory/question/in_memory_question_repository.dart';
import '../../../../infrastructure/in_memory/student/in_memory_student_repository.dart';
import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../../bookmarks/application_service/i_get_bookmarks_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../../question/repository/question_repository_provider.dart';
import '../../student/student_provider.dart';
import '../../teacher/teacher_provider.dart';
import '../repository/bookmarks_repository_provider.dart';

part 'get_my_bookmarks_query_service_provider.g.dart';

@riverpod
IGetBookmarksQueryService getMyBookmarksQueryServiceDi(
    GetMyBookmarksQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryBookmarksQueryService(
        repository: (ref.watch(bookmarksRepositoryDiProvider))
            as InMemoryBookmarksRepository,
        studentRepository: (ref.watch(studentRepositoryDiProvider))
            as InMemoryStudentRepository,
        questionRepository: (ref.watch(questionRepositoryDiProvider))
            as InMemoryQuestionRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as InMemoryTeacherRepository,
      );
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseBookmarksQueryService(
        repository: (ref.watch(bookmarksRepositoryDiProvider))
            as FirebaseBookmarksRepository,
        studentRepository: (ref.watch(studentRepositoryDiProvider))
            as FirebaseStudentRepository,
        questionRepository: (ref.watch(questionRepositoryDiProvider))
            as FirebaseQuestionRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as FirebaseTeacherRepository,
      );
  }
}
