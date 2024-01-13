import '../../../photo/models/photo_path.dart';
import '../../exception/student_domain_exception.dart';
import '../../exception/student_domain_exception_detail.dart';
import 'profile_photo_format.dart';

class ProfilePhotoPath extends PhotoPath {
  final _pathRegExp = RegExp(r'^photos/profile_photo/[a-zA-Z0-9_]+\.(' +
      profilePhotoFormatsRegExpString +
      r')$');

  ProfilePhotoPath(super.value);

  @override
  void validate(String value) {
    if (!_pathRegExp.hasMatch(value)) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidPhotoPath);
    }
  }
}
