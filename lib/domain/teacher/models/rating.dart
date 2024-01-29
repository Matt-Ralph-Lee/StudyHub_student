import '../exception/teacher_domain_exception.dart';
import '../exception/teacher_domain_exception_detail.dart';

class Rating {
  final double _value;
  static const maxValue = 5.0;
  static const minValue = 0.0;

  Rating(this._value) {
    if (_value > maxValue || _value < minValue) {
      throw const TeacherDomainException(
          TeacherDomainExceptionDetail.invalidRatingValue);
    }
  }

  double get value => _value;
}
