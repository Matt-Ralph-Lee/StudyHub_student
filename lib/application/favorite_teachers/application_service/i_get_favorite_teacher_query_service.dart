import '../../../domain/student/models/student_id.dart';
import 'get_favorite_teacher_dto.dart';

abstract class IGetFavoriteTeacherQueryService {
  Future<List<GetFavoriteTeacherDto>> getById(final StudentId studentId);
}
