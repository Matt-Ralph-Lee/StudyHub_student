import '../../shared/id.dart';
import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class QuestionId extends Id {
  final String _value;
  static const minLength = 10;
  QuestionId(this._value) : super(_value);

  @override
  String get value => _value;

  @override
  void validate(final String value) {
    if (_value.length < minLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.idInvalidLength);
    }
  }
}
