import '../../../domain/student/models/student_id.dart';
import 'get_blocking_dto.dart';

abstract class IGetBlockingsQueryService {
  Future<List<GetBlockingDto>> getByStudentId(final StudentId studentId);
}
