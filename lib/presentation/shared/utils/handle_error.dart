import '../../../application/blockings/exception/blockings_use_case_exception.dart';
import '../../../application/blockings/exception/blockings_use_case_exception_detail.dart';
import '../../../application/bookmarks/exception/bookmarks_use_case_exception.dart';
import '../../../application/bookmarks/exception/bookmarks_use_case_exception_detail.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../../application/notification/exception/notification_use_case_exception.dart';
import '../../../application/notification/exception/notification_use_case_exception_detail.dart';
import '../../../application/question/exception/question_use_case_exception.dart';
import '../../../application/question/exception/question_use_case_exception_detail.dart';
import '../../../application/student/exception/student_use_case_exception.dart';
import '../../../application/student/exception/student_use_case_exception_detail.dart';
import '../../../application/student_auth/exception/student_auth_use_case_exception.dart';
import '../../../application/student_auth/exception/student_auth_use_case_exception_detail.dart';
import '../../../application/teacher_evaluation/exception/teacher_evaluation_use_case_exception.dart';
import '../../../application/teacher_evaluation/exception/teacher_evaluation_use_case_exception_detail.dart';
import '../../../domain/blockings/exception/blockings_domain_exception.dart';
import '../../../domain/blockings/exception/blockings_domain_exception_detail.dart';
import '../../../domain/bookmarks/exception/bookmarks_domain_exception.dart';
import '../../../domain/bookmarks/exception/bookmarks_domain_exception_detail.dart';
import '../../../domain/favorite_teachers/exception/favorite_teachers_domain_exception.dart';
import '../../../domain/favorite_teachers/exception/favorite_teachers_domain_exception_detail.dart';
import '../../../domain/notification/exception/notification_domain_exception.dart';
import '../../../domain/notification/exception/notification_domain_exception_detail.dart';
import '../../../domain/question/exception/question_domain_exception.dart';
import '../../../domain/question/exception/question_domain_exception_detail.dart';
import '../../../domain/report/exception/report_domain_exception.dart';
import '../../../domain/report/exception/report_domain_exception_detail.dart';
import '../../../domain/student/exception/student_domain_exception.dart';
import '../../../domain/student/exception/student_domain_exception_detail.dart';
import '../../../domain/student_auth/exception/student_auth_domain_exception.dart';
import '../../../domain/student_auth/exception/student_auth_domain_exception_detail.dart';
import '../../../domain/teacher_evaluation/exception/teacher_evaluation_domain_exception.dart';
import '../../../domain/teacher_evaluation/exception/teacher_evaluation_domain_exception_detail.dart';
import '../../../infrastructure/exceptions/blockings/blockings_infrastructure_exception.dart';
import '../../../infrastructure/exceptions/blockings/blockings_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/bookmarks/bookmarks_infrastructure_exception.dart';
import '../../../infrastructure/exceptions/bookmarks/bookmarks_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/favorite_teachers/favorite_teachers_infrastructure_exception.dart';
import '../../../infrastructure/exceptions/favorite_teachers/favorite_teachers_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/notification/notification_infrastructure_exception.dart';
import '../../../infrastructure/exceptions/notification/notification_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/question/question_infrastructure_exception.dart';
import '../../../infrastructure/exceptions/question/question_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/student/student_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/student_auth/student_auth_infrastructure_exception.dart';
import '../../../infrastructure/exceptions/student_auth/student_auth_infrastructure_exception_detail.dart';
import '../constants/l10n.dart';

String handleError(Object? error) {
  //auth
  if (error is StudentAuthDomainException) {
    return L10n.getStudentAuthDomainExceptionMessage(
        error.detail as StudentAuthDomainExceptionDetail);
  }
  if (error is StudentAuthUseCaseException) {
    return L10n.getStudentAuthUseCaseExceptionMessage(
        error.detail as StudentAuthUseCaseExceptionDetail);
  }
  if (error is StudentAuthInfrastructureException) {
    return L10n.getStudentAuthInfrastructureExceptionMessage(
        error.detail as StudentAuthInfrastructureExceptionDetail);
  }

  //question
  if (error is QuestionUseCaseException) {
    return L10n.questionExceptionMessage(
        error.detail as QuestionUseCaseExceptionDetail);
  }
  if (error is QuestionDomainException) {
    return L10n.questionDomainExceptionMessage(
        error.detail as QuestionDomainExceptionDetail);
  }
  if (error is QuestionInfrastructureException) {
    return L10n.questionInfrastructureExceptionMessage(
        error.detail as QuestionInfrastructureExceptionDetail);
  }

  //Blockings
  if (error is BlockingsUseCaseException) {
    return L10n.blockingsUseCaseExceptionMessage(
        error.detail as BlockingsUseCaseExceptionDetail);
  }
  if (error is BlockingsInfrastructureException) {
    return L10n.blockingsInfrastructureExceptionMessage(
        error.detail as BlockingsInfrastructureExceptionDetail);
  }
  if (error is BlockingsDomainException) {
    return L10n.blockingsDomainExceptionMessage(
        error.detail as BlockingsDomainExceptionDetail);
  }

  //FavoriteTeacher
  if (error is FavoriteTeachersUseCaseException) {
    return L10n.favoriteTeacherUseCaseExceptionMessage(
        error.detail as FavoriteTeachersUseCaseExceptionDetail);
  }
  if (error is FavoriteTeachersDomainException) {
    return L10n.favoriteTeacherDomainExceptionMessage(
        error.detail as FavoriteTeachersDomainExceptionDetail);
  }
  if (error is FavoriteTeachersInfrastructureException) {
    return L10n.favoriteTeacherInfrastructureExceptionMessage(
        error.detail as FavoriteTeachersInfrastructureExceptionDetail);
  }

  //Evaluations
  if (error is EvaluationUseCaseException) {
    return L10n.evaluationUseCaseExceptionMessage(
        error.detail as EvaluationUseCaseExceptionDetail);
  }
  if (error is TeacherEvaluationDomainException) {
    return L10n.evaluationDomainExceptionMessage(
        error.detail as TeacherEvaluationDomainExceptionDetail);
  }

  //Student
  if (error is StudentUseCaseException) {
    return L10n.studentUseCaseExceptionMessage(
        error.detail as StudentUseCaseExceptionDetail);
  }
  if (error is StudentDomainException) {
    return L10n.studentDomainExceptionMessage(
        error.detail as StudentDomainExceptionDetail);
  }
  if (error is StudentDomainException) {
    return L10n.studentInfrastructureExceptionMessage(
        error.detail as StudentInfrastructureExceptionDetail);
  }

  //Bookmark
  if (error is BookmarksUseCaseException) {
    return L10n.bookmarkUseCaseExceptionMessage(
        error.detail as BookmarksUseCaseExceptionDetail);
  }
  if (error is BookmarksInfrastructureException) {
    return L10n.bookmarkInfrastructureExceptionMessage(
        error.detail as BookmarksInfrastructureExceptionDetail);
  }
  if (error is BookmarksDomainException) {
    return L10n.bookmarkDomainExceptionMessage(
        error.detail as BookmarksDomainExceptionDetail);
  }

  //Notification
  if (error is NotificationInfrastructureException) {
    return L10n.notificationInfrastructureExceptionMessage(
        error.detail as NotificationInfrastructureExceptionDetail);
  }
  if (error is NotificationUseCaseException) {
    return L10n.notificationUseCaseExceptionMessage(
        error.detail as NotificationUseCaseExceptionDetail);
  }
  if (error is NotificationDomainException) {
    return L10n.notificationDomainExceptionMessage(
        error.detail as NotificationDomainExceptionDetail);
  }

  //Report
  if (error is ReportDomainException) {
    return L10n.reportDomainExceptionMessage(
        error.detail as ReportDomainExceptionDetail);
  }

  return L10n.defaultErrorText;
}
