import '../../../domain/student/models/student_id.dart';
import 'get_my_notification_dto.dart';

abstract class IGetMyNotificationsQueryService {
  Future<List<GetMyNotificationDto>> get(final StudentId studentId);
}
