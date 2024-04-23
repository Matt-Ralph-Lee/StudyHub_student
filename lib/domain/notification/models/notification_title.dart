import '../exception/notification_domain_exception.dart';
import '../exception/notification_domain_exception_detail.dart';

class NotificationTitle {
  final String _value;
  static const int maxLength = 15;
  static const int minLength = 1;

  String get value => _value;

  NotificationTitle(this._value) {
    if (_value.length < minLength) {
      throw const NotificationDomainException(
          NotificationDomainExceptionDetail.invalidTitleLength);
    }
    if (_value.length > maxLength) {
      throw const NotificationDomainException(
          NotificationDomainExceptionDetail.invalidTitleLength);
    }
  }
}
