import '../../../common/exception/student/student_creation_exception.dart';
import '../../../common/exception/student/student_creation_exception_detail.dart';

class StudentId {
  final String _value;

  String get value => _value;

  StudentId(this._value) {
    if (_value.isEmpty) {
      throw const StudentCreationException(
          StudentCreationExceptionDetail.empty);
    }
  }
}
