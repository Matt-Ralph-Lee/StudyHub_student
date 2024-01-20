import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class SeenCount {
  int _value;
  // TODO: last seen at[time]

  int get value => _value;

  SeenCount(this._value) {
    if (_value < 0) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidSeenCount);
    }
  }

  // Questionの取得コード(表示コード)のときに発火
  void incrementCount() {
    _value += 1;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is SeenCount) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  bool operator >=(Object other) {
    if (identical(this, other)) {
      return false;
    }
    if (other is SeenCount) {
      return runtimeType == other.runtimeType && value >= other.value;
    } else {
      return false;
    }
  }

  bool operator <=(Object other) {
    return !(this >= other) || this == other;
  }

  @override
  int get hashCode => value.hashCode;
}
