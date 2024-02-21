import '../../../domain/blockings/models/blockings.dart';
import '../../../domain/blockings/models/i_blockings_repository.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryBlockingsRepository implements IBlockingsRepository {
  final store = <StudentId, Blockings>{};
  @override
  void save(Blockings blockings) {
    store[blockings.studentId] = blockings;
  }

  @override
  Blockings? getByStudentId(StudentId studentId) {
    return store[studentId];
  }
}
