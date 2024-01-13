import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryStudentRepository implements IStudentRepository {
  final store = <StudentId, Student>{};

  @override
  void delete(StudentId studentId) {
    store.remove(studentId);
  }

  @override
  Student? findById(StudentId studentId) {
    return store[studentId];
  }

  @override
  void save(Student student) {
    store[student.studentId] = student;
  }
}
