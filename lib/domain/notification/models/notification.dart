import 'notification_id.dart';
import 'notification_receiver_list.dart';
import 'notification_sender.dart';
import 'notification_target.dart';
import 'notification_text.dart';
import 'notification_title.dart';

class Notification {
  final NotificationId _notificationId;
  final NotificationSender _sender;
  final NotificationReceiverList _receiverList;
  final NotificationTarget _target;
  final NotificationTitle _title;
  final NotificationText _text;
  final DateTime _postedAt;
  final bool _read;

  NotificationId get notificationId => _notificationId;
  NotificationSender get sender => _sender;
  NotificationReceiverList get receiverList => _receiverList;
  NotificationTarget get target => _target;
  NotificationTitle get title => _title;
  NotificationText get text => _text;
  DateTime get postedAt => _postedAt;
  bool get read => _read;

  Notification({
    required final NotificationId notificationId,
    required final NotificationSender sender,
    required final NotificationReceiverList receiverList,
    required final NotificationTarget target,
    required final NotificationTitle title,
    required final NotificationText text,
    required final DateTime postedAt,
    required final bool read,
  })  : _notificationId = notificationId,
        _sender = sender,
        _receiverList = receiverList,
        _target = target,
        _title = title,
        _text = text,
        _postedAt = postedAt,
        _read = read;
}
