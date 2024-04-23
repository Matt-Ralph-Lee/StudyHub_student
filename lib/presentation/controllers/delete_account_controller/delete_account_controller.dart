import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/photo/repository/photo_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/di/student/student_provider.dart";
import "../../../application/di/student_auth/student_auth_provider.dart";
import "../../../application/student/application_service/student_delete_use_case.dart";

part "delete_account_controller.g.dart";

@riverpod
class DeleteAccountController extends _$DeleteAccountController {
  @override
  Future<void> build() async {}

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.watch(nonNullSessionProvider);
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final studentRepository = ref.read(studentRepositoryDiProvider);
      final photoRepository = ref.read(photoRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);
      final getMyBookmarksUseCase = StudentDeleteUseCase(
        session: session,
        studentAuthRepository: studentAuthRepository,
        studentRepository: studentRepository,
        photoRepository: photoRepository,
        logger: logger,
      );

      await getMyBookmarksUseCase.execute();
    });
  }
}
