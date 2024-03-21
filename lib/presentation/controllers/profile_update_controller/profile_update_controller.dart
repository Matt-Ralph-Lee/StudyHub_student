import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/photo/photo_repository_provider.dart";
import "../../../application/di/school/school_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/di/student/student_repository_provider.dart";
import "../../../application/student/application_service/profile_update_command.dart";
import "../../../application/student/application_service/profile_update_use_case.dart";
import "../../../domain/school/services/school_service.dart";

part "profile_update_controller.g.dart";

@riverpod
class ProfileUpdateController extends _$ProfileUpdateController {
  @override
  Future<void> build() async {}

  Future<void> profileUpdate(ProfileUpdateCommand command) async {
    final session = ref.watch(sessionDiProvider);
    final studentRepository = ref.read(studentRepositoryDiProvider);
    final schoolRepository = ref.read(schoolRepositoryDiProvider);
    final schoolService = SchoolService(schoolRepository);
    final photoRepository = ref.read(photoRepositoryDiProvider);
    if (session == null) {
      throw Exception('Session is null');
    }

    final profileUpdateUseCase = ProfileUpdateUseCase(
      session: session,
      repository: studentRepository,
      schoolService: schoolService,
      photoRepository: photoRepository,
    );

    profileUpdateUseCase.execute(command);
  }
}
