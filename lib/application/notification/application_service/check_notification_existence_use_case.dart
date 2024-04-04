import '../../../domain/notification/models/i_notification_repository.dart';

class CheckNotificationExistenceUseCase {
  final INotificationRepository _repository;

  CheckNotificationExistenceUseCase(this._repository);

  bool execute() {
    final result = _repository.checkNotificationExistence();

    return result;
  }
}
