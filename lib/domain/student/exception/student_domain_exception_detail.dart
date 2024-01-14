import '../../shared/domain_exception_detail.dart';
import '../models/profile_photo.dart';
import '../models/student_id.dart';
import '../models/student_name.dart';

enum StudentDomainExceptionDetail implements DomainExceptionDetail {
  nameInvalidLength(
      '${StudentName.minLength}字以上${StudentName.maxLength}字以下にしてください'),
  idInvalidLength('${StudentId.minLength}字以上にしてください'),
  invalidPhotoPath('画像パスが不正です'),
  invalidPhotoSize(
      'プロフィール画像の大きさは${ProfilePhoto.height}x${ProfilePhoto.width}にしてください'),
  invalidQuestionCount('質問数が不正です'),
  ;

  const StudentDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
