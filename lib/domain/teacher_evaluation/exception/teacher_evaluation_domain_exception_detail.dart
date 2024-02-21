import '../models/teacher_evaluation_comment.dart';
import '../models/teacher_evaluation_rating.dart';

import '../../shared/domain_exception_detail.dart';

enum TeacherEvaluationDomainExceptionDetail implements DomainExceptionDetail {
  invalidRatingValue(
      'ratingの値が不正です。${TeacherEvaluationRating.minValue}以上${TeacherEvaluationRating.maxValue}以下にしてください。'),
  invalidCommentLength(
      "evaluation commentが不正です${TeacherEvaluationComment.minLength}以上${TeacherEvaluationComment.maxLength}以下にしてください");

  const TeacherEvaluationDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
