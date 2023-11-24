import '../../../common/exception/student_exception/student_creation_exception.dart';
import '../../../common/exception/student_exception/student_creation_exception_detail.dart';

class Password {
  final String _value;
  static const _minLength = 6;

  String get value => _value;

  Password(this._value) {
    if (value.isEmpty) {
      throw const StudentCreationException(
          StudentCreationExceptionDetail.empty);
    }

    _validate(_value);
  }

  void _validate(final String value) {
    if (value.length < _minLength) {
      throw const StudentCreationException(
        StudentCreationExceptionDetail.weakPassword,
        info: _minLength,
      );
    }
  }
}
