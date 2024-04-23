import 'package:flutter/material.dart';

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
import 'l10n.dart';

//a

String handleError(BuildContext context, Object? error) {
  String errorMessage = L10n.defaultErrorText;

  //auth
  if (error is StudentAuthDomainException) {
    errorMessage = L10n.getStudentAuthDomainExceptionMessage(
        error.detail as StudentAuthDomainExceptionDetail);
  } else if (error is StudentAuthUseCaseException) {
    errorMessage = L10n.getStudentAuthUseCaseExceptionMessage(
        error.detail as StudentAuthUseCaseExceptionDetail);
  } else if (error is StudentAuthInfrastructureException) {
    errorMessage = L10n.getStudentAuthInfrastructureExceptionMessage(
        error.detail as StudentAuthInfrastructureExceptionDetail);
  }
  //question
  else if (error is QuestionUseCaseException) {
    errorMessage = L10n.questionExceptionMessage(
        error.detail as QuestionUseCaseExceptionDetail);
  } else if (error is QuestionDomainException) {
    errorMessage = L10n.questionDomainExceptionMessage(
        error.detail as QuestionDomainExceptionDetail);
  } else if (error is QuestionInfrastructureException) {
    errorMessage = L10n.questionInfrastructureExceptionMessage(
        error.detail as QuestionInfrastructureExceptionDetail);
  }
  //Blockings
  else if (error is BlockingsUseCaseException) {
    errorMessage = L10n.blockingsUseCaseExceptionMessage(
        error.detail as BlockingsUseCaseExceptionDetail);
  } else if (error is BlockingsInfrastructureException) {
    errorMessage = L10n.blockingsInfrastructureExceptionMessage(
        error.detail as BlockingsInfrastructureExceptionDetail);
  } else if (error is BlockingsDomainException) {
    errorMessage = L10n.blockingsDomainExceptionMessage(
        error.detail as BlockingsDomainExceptionDetail);
  }
  //FavoriteTeacher
  else if (error is FavoriteTeachersUseCaseException) {
    errorMessage = L10n.favoriteTeacherUseCaseExceptionMessage(
        error.detail as FavoriteTeachersUseCaseExceptionDetail);
  } else if (error is FavoriteTeachersDomainException) {
    errorMessage = L10n.favoriteTeacherDomainExceptionMessage(
        error.detail as FavoriteTeachersDomainExceptionDetail);
  } else if (error is FavoriteTeachersInfrastructureException) {
    errorMessage = L10n.favoriteTeacherInfrastructureExceptionMessage(
        error.detail as FavoriteTeachersInfrastructureExceptionDetail);
  }
  //Evaluations
  else if (error is EvaluationUseCaseException) {
    errorMessage = L10n.evaluationUseCaseExceptionMessage(
        error.detail as EvaluationUseCaseExceptionDetail);
  } else if (error is TeacherEvaluationDomainException) {
    errorMessage = L10n.evaluationDomainExceptionMessage(
        error.detail as TeacherEvaluationDomainExceptionDetail);
  }
  //Student
  else if (error is StudentUseCaseException) {
    errorMessage = L10n.studentUseCaseExceptionMessage(
        error.detail as StudentUseCaseExceptionDetail);
  } else if (error is StudentDomainException) {
    errorMessage = L10n.studentDomainExceptionMessage(
        error.detail as StudentDomainExceptionDetail);
  } else if (error is StudentDomainException) {
    errorMessage = L10n.studentInfrastructureExceptionMessage(
        error.detail as StudentInfrastructureExceptionDetail);
  }
  //Bookmark
  else if (error is BookmarksUseCaseException) {
    errorMessage = L10n.bookmarkUseCaseExceptionMessage(
        error.detail as BookmarksUseCaseExceptionDetail);
  } else if (error is BookmarksInfrastructureException) {
    errorMessage = L10n.bookmarkInfrastructureExceptionMessage(
        error.detail as BookmarksInfrastructureExceptionDetail);
  } else if (error is BookmarksDomainException) {
    errorMessage = L10n.bookmarkDomainExceptionMessage(
        error.detail as BookmarksDomainExceptionDetail);
  }
  //Notification
  else if (error is NotificationInfrastructureException) {
    errorMessage = L10n.notificationInfrastructureExceptionMessage(
        error.detail as NotificationInfrastructureExceptionDetail);
  } else if (error is NotificationUseCaseException) {
    errorMessage = L10n.notificationUseCaseExceptionMessage(
        error.detail as NotificationUseCaseExceptionDetail);
  } else if (error is NotificationDomainException) {
    errorMessage = L10n.notificationDomainExceptionMessage(
        error.detail as NotificationDomainExceptionDetail);
  }
  //Report
  else if (error is ReportDomainException) {
    errorMessage = L10n.reportDomainExceptionMessage(
        error.detail as ReportDomainExceptionDetail);
  }

  return errorMessage;
}
