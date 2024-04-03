import '../../shared/id.dart';
import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

class AnswerId extends Id {
  final String _value;
  static const minLength = 20;

  @override
  String get value => _value;

  AnswerId(this._value) : super(_value);

  @override
  void validate(final String value) {
    if (_value.length < minLength) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.idInvalidLength);
    }
  }
}
