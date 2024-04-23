import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/di/student/get_my_profile_query_service.dart";
import "../../../application/student/application_service/get_my_profile_dto.dart";
import "../../../application/student/application_service/get_my_profile_use_case.dart";

part "get_my_profile_controller.g.dart";

@riverpod
class GetMyProfileController extends _$GetMyProfileController {
  @override
  Future<GetMyProfileDto> build() async {
    final session = ref.watch(sessionDiProvider);
    final getMyProfileQueryService =
        ref.watch(getMyProfileQueryServiceDiProvider);
    if (session == null) {
      throw Exception('Session is null');
    }

    final getMyProfileUseCase = GetMyProfileUseCase(
      session: session,
      queryService: getMyProfileQueryService,
    );

    final questionCardDto = getMyProfileUseCase.execute();
    return questionCardDto;
  }
}
