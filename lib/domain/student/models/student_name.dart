import 'package:studyhub/common/exception/student/student_creation_exception.dart';
import 'package:studyhub/common/exception/student/student_creation_exception_detail.dart';

class StudentName {
  final String _value;
  static const int _maxLength = 15;

  StudentName(this._value) {
    if (_value.isEmpty) {
      throw const StudentCreationException(
          StudentCreationExceptionDetail.empty);
    }
    if (_value.length > _maxLength) {
      throw const StudentCreationException(
          StudentCreationExceptionDetail.invalidLength,
          info: _maxLength);
    }
  }
}
