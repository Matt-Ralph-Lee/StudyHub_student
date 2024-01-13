import '../../exception/student_domain_exception.dart';
import '../../exception/student_domain_exception_detail.dart';
import 'profile_photo_format.dart';

class ProfilePhotoPath {
  final String _value;
  final _pathRegExp = RegExp(r'^photos/profile_photo/[a-zA-Z0-9_]+\.(' +
      profilePhotoFormatsRegExpString +
      r')$');

  String get value => _value;

  ProfilePhotoPath(this._value) {
    if (!_pathRegExp.hasMatch(_value)) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidPhotoPath);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is ProfilePhotoPath) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
