import 'blockings.dart';
import '../../student/models/student_id.dart';

abstract class IBlockingsRepository {
  Future<void> save(final Blockings blockings);
  Future<Blockings?> getByStudentId(final StudentId studentId);
}
