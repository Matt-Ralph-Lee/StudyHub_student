import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/notification/application_service/get_my_notification_dto.dart';
import 'package:studyhub/application/notification/application_service/get_my_notifications_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/notification/models/notification_receiver.dart';
import 'package:studyhub/domain/notification/models/notification_receiver_list.dart';
import 'package:studyhub/domain/notification/models/notification_receiver_type.dart';
import 'package:studyhub/domain/notification/models/notification_sender.dart';
import 'package:studyhub/domain/notification/models/notification_sender_type.dart';
import 'package:studyhub/domain/notification/models/notification_target.dart';
import 'package:studyhub/domain/notification/models/notification_target_type.dart';
import 'package:studyhub/domain/notification/models/notification_text.dart';
import 'package:studyhub/domain/notification/models/notification_title.dart';
import 'package:studyhub/domain/shared/profile_photo_path.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/infrastructure/in_memory/notification/in_memory_get_my_notifications_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/notification/in_memory_notification_factory.dart';
import 'package:studyhub/infrastructure/in_memory/notification/in_memory_notification_repository.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';

void main() {
  final session = MockSession();
  final repository = InMemoryNotificationRepository();
  final queryService =
      InMemoryGetMyNotificationsQueryService(repository: repository);
  final useCase =
      GetMyNotificationsUseCase(session: session, queryService: queryService);

  setUp(() => null);

  group('get my notifications use case should be executed normally', () {
    test('after install', () async {
      final getMyNotificationDtoList = await useCase.execute();
      _printDtoList(getMyNotificationDtoList);
    });

    test('when a teacher send you a new notification.', () async {
      final newNotification =
          await InMemoryNotificationFactory(repository: repository).create(
              sender: NotificationSender(
                  senderType: NotificationSenderType.teacher,
                  senderId: InMemoryTeacherInitialValue.teacher1.teacherId,
                  senderPhotoPath: ProfilePhotoPath(
                      'assets/photos/profile_photo/sample_user_icon2.jpg')),
              receiverList: NotificationReceiverList([
                NotificationReceiver(
                    receiverType: NotificationReceiverType.student,
                    receiverId: session.studentId)
              ]),
              target: NotificationTarget(
                  targetType: NotificationTargetType.question,
                  targetId: InMemoryQuestionIdInitialValue.questionId1FromS1),
              title: NotificationTitle('これは回答です'),
              text: NotificationText('これはテスト配信用の回答です。'));
      repository.store[newNotification.notificationId] = newNotification;
      final getMyNotificationDtoList = await useCase.execute();
      _printDtoList(getMyNotificationDtoList);
    });

    test('even when each value of StudentId and TeacherId is the same',
        () async {
      final session3 = MockSession3();
      final useCase3 = GetMyNotificationsUseCase(
          session: session3, queryService: queryService);
      final getMyNotificationDtoList = await useCase3.execute();
      _printDtoList(getMyNotificationDtoList);
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => InMemoryStudentInitialValue.student1.studentId;
}

class MockSession3 implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => InMemoryStudentInitialValue.student3.studentId;
}

void _printDtoList(final List<GetMyNotificationDto> dtoList) {
  for (var dto in dtoList) {
    debugPrint('title: ${dto.title} from ${dto.sender.senderId?.value}');
    debugPrint('text: ${dto.text}');
  }
}
