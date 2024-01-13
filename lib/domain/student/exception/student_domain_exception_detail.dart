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
  empty('Empty is not allowed.'),
  missingCharacter('Missing specified character to be used.'),
  invalidCharacter('Invalid character is used.'),
  alreadyExists('The account already exists.'),
  notFound('The account is not found.'),
  cannotConvert('cannot convert data.'),
  ;

  const StudentDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
