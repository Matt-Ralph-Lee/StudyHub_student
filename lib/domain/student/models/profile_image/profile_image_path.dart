import '../../exception/student_domain_exception.dart';
import '../../exception/student_domain_exception_detail.dart';
import 'profile_image_format.dart';

class ProfileImagePath {
  final String _value;
  final _pathRegExp = RegExp(r'^images/profile_image/[a-zA-Z0-9_]+\.(' +
      profileImageFormatsRegExpString +
      r')$');

  String get value => _value;

  ProfileImagePath(this._value) {
    if (!_pathRegExp.hasMatch(_value)) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidImagePath);
    }
  }
}
