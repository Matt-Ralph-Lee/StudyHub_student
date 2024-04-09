import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/student/models/student_id.dart';

class CheckNotificationExistenceUseCase {
  final INotificationRepository _repository;

  CheckNotificationExistenceUseCase(this._repository);

  Future<bool> execute(final StudentId studentId) async {
    final result = _repository.checkNotificationExistence(studentId);

    return result;
  }
}
