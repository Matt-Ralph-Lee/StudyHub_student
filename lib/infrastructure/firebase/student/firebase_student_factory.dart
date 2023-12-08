import 'package:studyhub/domain/student/models/i_student_factory.dart';

import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade.dart';
import '../../../domain/student/models/occupation.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';

class FirebaseStudentFactory implements IStudentFactory {
  @override
  Student createInitially(final StudentId accountId) {
    return Student(
      accountId: accountId,
      studentName: studentName,
      profilePhoto: null,
      gender: Gender.nonAnswer,
      occupation: Occupation.others,
      schoolName: schoolName,
      grade: Grade.other,
    );
  }
}
