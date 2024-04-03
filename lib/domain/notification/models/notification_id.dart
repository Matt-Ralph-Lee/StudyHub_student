import '../../shared/id.dart';
import '../exception/notification_domain_exception.dart';
import '../exception/notification_domain_exception_detail.dart';

class NotificationId extends Id {
  final String _value;
  static const minLength = 20;
  NotificationId(this._value) : super(_value);

  @override
  String get value => _value;

  @override
  void validate(final String value) {
    if (_value.length < minLength) {
      throw const NotificationDomainException(
          NotificationDomainExceptionDetail.invalidNotificationIdLength);
    }
  }
}
