import 'notification_id.dart';
import 'notification_sender.dart';
import 'notification_target.dart';
import 'notification_text.dart';
import 'notification_title.dart';
import 'notification_receiver.dart';

class Notification {
  final NotificationId _notificationId;
  final NotificationSender _sender;
  final NotificationReceiver _receiver;
  final NotificationTarget _target;
  final NotificationTitle _title;
  final NotificationText _text;

  NotificationId get notificationId => _notificationId;
  NotificationSender get sender => _sender;
  NotificationReceiver get receiver => _receiver;
  NotificationTarget get target => _target;
  NotificationTitle get title => _title;
  NotificationText get text => _text;

  Notification({
    required final NotificationId notificationId,
    required final NotificationSender sender,
    required final NotificationReceiver receiver,
    required final NotificationTarget target,
    required final NotificationTitle title,
    required final NotificationText text,
  })  : _notificationId = notificationId,
        _sender = sender,
        _receiver = receiver,
        _target = target,
        _title = title,
        _text = text;
}
