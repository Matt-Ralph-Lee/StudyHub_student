import '../../shared/domain_exception_detail.dart';
import '../../shared/profile_photo.dart';
import '../models/student_id.dart';
import '../../shared/name.dart';

enum StudentDomainExceptionDetail implements DomainExceptionDetail {
  nameInvalidLength('${Name.minLength}字以上${Name.maxLength}字以下にしてください'),
  idInvalidLength('${StudentId.minLength}字以上にしてください'),
  invalidPhotoPath('画像パスが不正です'),
  invalidPhotoSize(
      'プロフィール画像の大きさは${ProfilePhoto.avaliableHeight}x${ProfilePhoto.availableWidth}にしてください'),
  invalidQuestionCount('質問数が不正です'),
  ;

  const StudentDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
