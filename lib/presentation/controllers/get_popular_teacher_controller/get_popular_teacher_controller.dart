import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/favorite_teacher/query_service/get_favorite_teacher_query_service_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/favorite_teachers/application_service/get_favorite_teacher_dto.dart";
import "../../../application/favorite_teachers/application_service/get_favorite_teacher_use_case.dart";
import "../../../application/teacher/application_service/get_popular_teachers_use_case.dart";
import "../../../application/teacher/application_service/get_teacher_profile_dto.dart";
import "../../../application/teacher/application_service/search_for_teachers_dto.dart";

part "get_popular_teacher_controller.g.dart";

@riverpod
class GetPopularTeacherController extends _$GetPopularTeacherController {
  @override
  Future<List<SearchForTeacherDto>> build() async {
    //ユースケースが引数にクエリサービス必要だけど、クエリサービスのインターフェイスが実装されてない？以上、クエリサービスのdiが作れない
    //（厳密には、それっぽいファイルはあるんだけど、先頭にIがついていない）
    final getPopularTeachesUseCase = GetPopularTeachersUseCase();
    final favoriteTeachers = getPopularTeachesUseCase.execute();
    return favoriteTeachers;
  }
}
