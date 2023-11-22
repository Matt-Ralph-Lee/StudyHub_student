import '../../../common/exception/argument_exception/argument_exception.dart';
import '../../../common/exception/argument_exception/argument_exception_detail.dart';

class AccountId {
  final String _value;

  String get value => _value;

  AccountId(final String value) : _value = value {
    if (_value.isEmpty) {
      throw const ArgumentException(ArgumentExceptionDetail.emptyException);
    }
  }
}
