import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/blockings/application_service/get_blocking_dto.dart";
import "../../../application/blockings/application_service/get_blockings_use_case.dart";
import "../../../application/di/blockings/query_service/blockings_query_service_provider.dart";
import "../../../application/di/session/session_provider.dart";

part "get_blockings_controller.g.dart";

@riverpod
class GetBlockingsController extends _$GetBlockingsController {
  @override
  Future<List<GetBlockingDto>> build() async {
    final session = ref.read(nonNullSessionProvider);
    final queryService = ref.watch(getBlockingsQueryServiceDiProvider);
    final getBlockingsUseCase =
        GetBlockingsUseCase(session: session, queryService: queryService);
    final blockingTeachers = getBlockingsUseCase.execute();
    return blockingTeachers;
  }
}
