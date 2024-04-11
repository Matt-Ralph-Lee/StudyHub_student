import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/student/models/student_id.dart';

class ReadNotificationUseCase {
  final INotificationRepository _repository;

  ReadNotificationUseCase(this._repository);

  Future<void> execute(
      final NotificationId id, final StudentId studentId) async {
    await _repository.readNotification(id, studentId);
  }
}
