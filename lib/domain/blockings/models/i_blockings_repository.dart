import 'blockings.dart';
import '../../student/models/student_id.dart';

abstract class IBlockingsRepository {
  void save(final Blockings blockings);
  Blockings? findByStudentId(final StudentId studentId);
}
