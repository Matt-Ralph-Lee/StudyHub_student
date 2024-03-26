# Details

Date : 2024-03-26 00:17:40

Directory /Users/morikazu/Downloads/StudyHub_student/lib/infrastructure

Total : 36 files,  1361 codes, 9 comments, 240 blanks, all 1610 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/infrastructure/exceptions/student_auth/student_auth_infrastructure_exception.dart](/lib/infrastructure/exceptions/student_auth/student_auth_infrastructure_exception.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/infrastructure/exceptions/student_auth/student_auth_infrastructure_exception_detail.dart](/lib/infrastructure/exceptions/student_auth/student_auth_infrastructure_exception_detail.dart) | Dart | 18 | 4 | 5 | 27 |
| [lib/infrastructure/firebase/student-auth/firebase_get_student_auth_query_service.dart](/lib/infrastructure/firebase/student-auth/firebase_get_student_auth_query_service.dart) | Dart | 24 | 0 | 5 | 29 |
| [lib/infrastructure/firebase/student-auth/firebase_student_auth_repository.dart](/lib/infrastructure/firebase/student-auth/firebase_student_auth_repository.dart) | Dart | 151 | 1 | 13 | 165 |
| [lib/infrastructure/in_memory/answer/in_memory_answer_repository.dart](/lib/infrastructure/in_memory/answer/in_memory_answer_repository.dart) | Dart | 58 | 0 | 6 | 64 |
| [lib/infrastructure/in_memory/answer/in_memory_get_answer_query_service.dart](/lib/infrastructure/in_memory/answer/in_memory_get_answer_query_service.dart) | Dart | 62 | 0 | 8 | 70 |
| [lib/infrastructure/in_memory/blockings/in_memory_blockings_query_service.dart](/lib/infrastructure/in_memory/blockings/in_memory_blockings_query_service.dart) | Dart | 42 | 0 | 7 | 49 |
| [lib/infrastructure/in_memory/blockings/in_memory_blockings_repository.dart](/lib/infrastructure/in_memory/blockings/in_memory_blockings_repository.dart) | Dart | 22 | 0 | 6 | 28 |
| [lib/infrastructure/in_memory/bookmarks/exception/bookmarks_infrastructure_exception.dart](/lib/infrastructure/in_memory/bookmarks/exception/bookmarks_infrastructure_exception.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/infrastructure/in_memory/bookmarks/exception/bookmarks_infrastructure_exception_detail.dart](/lib/infrastructure/in_memory/bookmarks/exception/bookmarks_infrastructure_exception_detail.dart) | Dart | 11 | 0 | 5 | 16 |
| [lib/infrastructure/in_memory/bookmarks/in_memory_bookmarks_query_service.dart](/lib/infrastructure/in_memory/bookmarks/in_memory_bookmarks_query_service.dart) | Dart | 68 | 0 | 11 | 79 |
| [lib/infrastructure/in_memory/bookmarks/in_memory_bookmarks_repository.dart](/lib/infrastructure/in_memory/bookmarks/in_memory_bookmarks_repository.dart) | Dart | 22 | 0 | 6 | 28 |
| [lib/infrastructure/in_memory/favorite_teachers/in_memory_favorite_teacher_query_service.dart](/lib/infrastructure/in_memory/favorite_teachers/in_memory_favorite_teacher_query_service.dart) | Dart | 45 | 0 | 8 | 53 |
| [lib/infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart](/lib/infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart) | Dart | 23 | 0 | 6 | 29 |
| [lib/infrastructure/in_memory/photo/in_memory_photo_repository.dart](/lib/infrastructure/in_memory/photo/in_memory_photo_repository.dart) | Dart | 32 | 0 | 8 | 40 |
| [lib/infrastructure/in_memory/question/exception/question_infrastructure_exception.dart](/lib/infrastructure/in_memory/question/exception/question_infrastructure_exception.dart) | Dart | 8 | 0 | 2 | 10 |
| [lib/infrastructure/in_memory/question/exception/question_infrastructure_exception_detail.dart](/lib/infrastructure/in_memory/question/exception/question_infrastructure_exception_detail.dart) | Dart | 12 | 0 | 5 | 17 |
| [lib/infrastructure/in_memory/question/in_memory_get_my_questions_query_service.dart](/lib/infrastructure/in_memory/question/in_memory_get_my_questions_query_service.dart) | Dart | 70 | 0 | 9 | 79 |
| [lib/infrastructure/in_memory/question/in_memory_get_question_detail_query_service.dart](/lib/infrastructure/in_memory/question/in_memory_get_question_detail_query_service.dart) | Dart | 20 | 0 | 6 | 26 |
| [lib/infrastructure/in_memory/question/in_memory_get_recommended_questions_query_service.dart](/lib/infrastructure/in_memory/question/in_memory_get_recommended_questions_query_service.dart) | Dart | 73 | 1 | 10 | 84 |
| [lib/infrastructure/in_memory/question/in_memory_question_factory.dart](/lib/infrastructure/in_memory/question/in_memory_question_factory.dart) | Dart | 42 | 0 | 5 | 47 |
| [lib/infrastructure/in_memory/question/in_memory_question_repository.dart](/lib/infrastructure/in_memory/question/in_memory_question_repository.dart) | Dart | 35 | 0 | 11 | 46 |
| [lib/infrastructure/in_memory/question/in_memory_search_for_questions_query_service.dart](/lib/infrastructure/in_memory/question/in_memory_search_for_questions_query_service.dart) | Dart | 62 | 0 | 10 | 72 |
| [lib/infrastructure/in_memory/report/in_memory_report_repository.dart](/lib/infrastructure/in_memory/report/in_memory_report_repository.dart) | Dart | 23 | 0 | 5 | 28 |
| [lib/infrastructure/in_memory/school/in_memory_school_repository.dart](/lib/infrastructure/in_memory/school/in_memory_school_repository.dart) | Dart | 25 | 0 | 5 | 30 |
| [lib/infrastructure/in_memory/student/in_memory_student_query_service.dart](/lib/infrastructure/in_memory/student/in_memory_student_query_service.dart) | Dart | 21 | 0 | 4 | 25 |
| [lib/infrastructure/in_memory/student/in_memory_student_repository.dart](/lib/infrastructure/in_memory/student/in_memory_student_repository.dart) | Dart | 26 | 0 | 7 | 33 |
| [lib/infrastructure/in_memory/student_auth/in_memory_get_student_auth_query_service.dart](/lib/infrastructure/in_memory/student_auth/in_memory_get_student_auth_query_service.dart) | Dart | 14 | 0 | 4 | 18 |
| [lib/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart](/lib/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart) | Dart | 142 | 1 | 22 | 165 |
| [lib/infrastructure/in_memory/teacher/in_memory_get_popular_teachers_query_service.dart](/lib/infrastructure/in_memory/teacher/in_memory_get_popular_teachers_query_service.dart) | Dart | 24 | 1 | 7 | 32 |
| [lib/infrastructure/in_memory/teacher/in_memory_get_teacher_profile_query_service.dart](/lib/infrastructure/in_memory/teacher/in_memory_get_teacher_profile_query_service.dart) | Dart | 45 | 0 | 7 | 52 |
| [lib/infrastructure/in_memory/teacher/in_memory_search_for_teachers_query_service.dart](/lib/infrastructure/in_memory/teacher/in_memory_search_for_teachers_query_service.dart) | Dart | 23 | 0 | 7 | 30 |
| [lib/infrastructure/in_memory/teacher/in_memory_teacher_repository.dart](/lib/infrastructure/in_memory/teacher/in_memory_teacher_repository.dart) | Dart | 55 | 0 | 4 | 59 |
| [lib/infrastructure/in_memory/teacher_evaluation/in_memory_teacher_evaluation_repository.dart](/lib/infrastructure/in_memory/teacher_evaluation/in_memory_teacher_evaluation_repository.dart) | Dart | 30 | 1 | 6 | 37 |
| [lib/infrastructure/shared/infrastructure_exception.dart](/lib/infrastructure/shared/infrastructure_exception.dart) | Dart | 13 | 0 | 4 | 17 |
| [lib/infrastructure/shared/infrastructure_exception_detail.dart](/lib/infrastructure/shared/infrastructure_exception_detail.dart) | Dart | 4 | 0 | 2 | 6 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)