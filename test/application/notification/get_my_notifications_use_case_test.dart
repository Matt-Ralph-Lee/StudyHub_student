import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/notification/application_service/get_my_notification_dto.dart';
import 'package:studyhub/application/notification/application_service/get_my_notifications_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/infrastructure/in_memory/notification/in_memory_get_my_notifications_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/notification/in_memory_notification_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';

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
    debugPrint('title: ${dto.title} from ${dto.senderId?.value}');
    debugPrint('text: ${dto.text}');
  }
}
