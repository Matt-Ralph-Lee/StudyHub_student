import '../../../domain/shared/name.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/teacher/models/bio.dart';
import '../../../domain/teacher/models/graduated.dart';
import '../../../domain/teacher/models/high_school.dart';
import '../../../domain/teacher/models/introduction.dart';
import '../../../domain/teacher/models/rating.dart';
import '../../../domain/teacher/models/teacher.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher/models/i_teacher_repository.dart';
import '../../../domain/teacher/models/university.dart';

class InMemoryTeacherRepository implements ITeacherRepository {
  late Map<TeacherId, Teacher> store;
  static final InMemoryTeacherRepository _instance =
      InMemoryTeacherRepository._internal();

  factory InMemoryTeacherRepository() {
    return _instance;
  }

  InMemoryTeacherRepository._internal() {
    store = {
      TeacherId('00000000000000000001'): Teacher(
          teacherId: TeacherId('00000000000000000001'),
          name: Name('testName1'),
          highSchool: HighSchool('testSchool1'),
          university: University(
              school: 'testUniversity1',
              enrollmentStatus: EnrollmentStatus.enrolled),
          bio: Bio('わかりやすく教えます'),
          introduction: Introduction('数学が得意科目です。\nよろしくお願いします。'),
          rating: Rating(4.0),
          bestSubjects: [Subject.highMath],
          profilePhotoPath:
              ProfilePhotoPath('assets/images/sample_user_icon.jpg')),
      TeacherId('00000000000000000002'): Teacher(
        teacherId: TeacherId('00000000000000000002'),
        name: Name('testName2'),
        highSchool: HighSchool('testSchool2'),
        university: University(
            school: 'testUniversity2',
            enrollmentStatus: EnrollmentStatus.graduated),
        bio: Bio('丁寧にお教えします'),
        introduction: Introduction('初めまして。塾講師の経験があるので、わかりやすく教えることができると思います。'),
        rating: Rating(3.5),
        bestSubjects: [Subject.midEng],
        profilePhotoPath:
            ProfilePhotoPath('assets/images/sample_user_icon2.jpg'),
      )
    };
  }
  @override
  Teacher? getByTeacherId(final TeacherId teacherId) {
    return store[teacherId];
  }
}
