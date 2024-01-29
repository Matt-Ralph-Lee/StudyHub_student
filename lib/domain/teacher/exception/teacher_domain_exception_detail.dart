import '../../shared/domain_exception_detail.dart';
import '../models/bio.dart';
import '../models/introduction.dart';
import '../models/rating.dart';
import '../models/teacher_id.dart';

enum TeacherDomainExceptionDetail implements DomainExceptionDetail {
  invalidIdLength('${TeacherId.minLength}字以上にしてください'),
  invalidBioLength('${Bio.maxLength}字以内にしてください'),
  invalidIntroductionLength('${Introduction.maxLength}字以内にしてください'),
  invalidRatingValue('${Rating.minValue}以上${Rating.maxValue}以下にしてください'),
  ;

  const TeacherDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
