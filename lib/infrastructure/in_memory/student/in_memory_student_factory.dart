import 'package:english_words/english_words.dart';

import '../../../domain/school/models/school.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade.dart';
import '../../../domain/student/models/i_student_factory.dart';
import '../../../domain/student/models/occupation.dart';
import '../../../domain/student/models/question_count.dart';
import '../../../domain/student/models/status.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/shared/name.dart';

class InMemoryStudentFactory implements IStudentFactory {
  @override
  Student createInitially(StudentId studentId) {
    final studentName = Name(WordPair.random().asLowerCase);
    final profilePhotoPath =
        ProfilePhotoPath('photos/profile_photo/initial_photo.jpg');
    const gender = Gender.noAnswer;
    const occupation = Occupation.others;
    final school = School.noAnswer;
    const grade = Grade.other;
    final questionCount = QuestionCount(0);
    const status = Status.beginner;

    return Student(
      studentId: studentId,
      studentName: studentName,
      profilePhotoPath: profilePhotoPath,
      gender: gender,
      occupation: occupation,
      school: school,
      grade: grade,
      questionCount: questionCount,
      status: status,
    );
  }
}
