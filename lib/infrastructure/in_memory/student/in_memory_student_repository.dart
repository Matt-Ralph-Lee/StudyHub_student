import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryStudentRepository implements IStudentRepository {
  late Map<StudentId, Student> store;
  static final InMemoryStudentRepository _instance =
      InMemoryStudentRepository._internal();

  factory InMemoryStudentRepository() {
    return _instance;
  }

  InMemoryStudentRepository._internal() {
    store = {};
  }

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
