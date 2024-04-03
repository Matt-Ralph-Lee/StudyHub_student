import '../exception/notification_domain_exception.dart';
import '../exception/notification_domain_exception_detail.dart';

class NotificationText {
  final String _value;
  static const int maxLength = 300;
  static const int maxLine = 14;

  String get value => _value;

  NotificationText(this._value) {
    if (_value.isEmpty) {
      throw const NotificationDomainException(
          NotificationDomainExceptionDetail.empty);
    }
    if (_value.length > maxLength) {
      throw const NotificationDomainException(
          NotificationDomainExceptionDetail.invalidTextLength);
    }
    if (_value.split('\n').length > maxLine) {
      throw const NotificationDomainException(
          NotificationDomainExceptionDetail.invalidTextLine);
    }
  }
}
