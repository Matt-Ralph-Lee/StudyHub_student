import 'package:studyhub/domain/student/models/student_name.dart';

import '../../shared/domain_exception_detail.dart';
import '../models/profile_image/profile_image.dart';
import '../models/student_id.dart';

enum StudentDomainExceptionDetail implements DomainExceptionDetail {
  nameInvalidLength(
      '${StudentName.minLength}字以上${StudentName.maxLength}字以下にしてください'),
  idInvalidLength('${StudentId.minLength}字以上にしてください'),
  invalidImagePath('画像パスが不正です'),
  invalidImageSize(
      'プロフィール画像の大きさは${ProfileImage.height}x${ProfileImage.width}にしてください'),
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
