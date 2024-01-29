import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

class AnswerId {
  final String _value;
  static const minLength = 10;

  String get value => _value;

  AnswerId(this._value) {
    if (_value.length < minLength) {
      throw const AnswerDomainException(
          AnswerDomainExceptionDetail.idInvalidLength);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is AnswerId) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
