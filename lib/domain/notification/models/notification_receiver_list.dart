import '../exception/notification_domain_exception.dart';
import '../exception/notification_domain_exception_detail.dart';
import 'notification_receiver.dart';

class NotificationReceiverList extends Iterable<NotificationReceiver> {
  final List<NotificationReceiver> _receiverList;

  List<NotificationReceiver> get receiverList => _receiverList;

  NotificationReceiverList(this._receiverList) {
    if (_receiverList.isEmpty) {
      throw const NotificationDomainException(
          NotificationDomainExceptionDetail.empty);
    }
  }

  @override
  Iterator<NotificationReceiver> get iterator => _receiverList.iterator;
}
