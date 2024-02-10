import '../models/evaluation_comment.dart';
import '../models/evaluation_rating.dart';

import '../../shared/domain_exception_detail.dart';

enum EvaluationDomainExceptionDetail implements DomainExceptionDetail {
  invalidRatingValue(
      'ratingの値が不正です。${EvaluationRating.minValue}以上${EvaluationRating.maxValue}以下にしてください。'),
  invalidCommentLength(
      "evaluation commentが不正です${EvaluationComment.minLength}以上${EvaluationComment.maxLength}以下にしてください");

  const EvaluationDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
