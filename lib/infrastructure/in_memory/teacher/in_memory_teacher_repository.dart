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
import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../exceptions/teacher/teacher_infrastructure_exception.dart';
import '../../exceptions/teacher/teacher_infrastructure_exception_detail.dart';

class InMemoryTeacherRepository implements ITeacherRepository {
  late Map<TeacherId, Teacher> store;
  late Map<TeacherId, List<int>> ratingStore; // sum, num
  static final InMemoryTeacherRepository _instance =
      InMemoryTeacherRepository._internal();

  factory InMemoryTeacherRepository() {
    return _instance;
  }

  InMemoryTeacherRepository._internal() {
    store = {
      InMemoryTeacherInitialValue.teacher1.teacherId:
          InMemoryTeacherInitialValue.teacher1,
      InMemoryTeacherInitialValue.teacher2.teacherId:
          InMemoryTeacherInitialValue.teacher2,
      InMemoryTeacherInitialValue.teacher3.teacherId:
          InMemoryTeacherInitialValue.teacher3,
    };
    // make sure to change it to int that corresponds to initial rating value
    ratingStore = {
      InMemoryTeacherInitialValue.teacher1.teacherId: [
        (1 * InMemoryTeacherInitialValue.teacher1.rating.value).round(),
        1
      ],
      InMemoryTeacherInitialValue.teacher2.teacherId: [
        (2 * InMemoryTeacherInitialValue.teacher2.rating.value).round(),
        2
      ],
      InMemoryTeacherInitialValue.teacher3.teacherId: [
        (2 * InMemoryTeacherInitialValue.teacher3.rating.value).round(),
        2
      ],
    };
  }
  @override
  Future<Teacher?> getByTeacherId(final TeacherId teacherId) async {
    return store[teacherId];
  }

  @override
  Future<void> changeRate(TeacherEvaluation evaluation) async {
    final teacherId = evaluation.to;
    final oldRating = ratingStore[teacherId];
    if (oldRating == null) {
      throw const TeacherInfrastructureException(
          TeacherInfrastructureExceptionDetail.ratingNotFound);
    }

    final teacher = store[teacherId];
    if (teacher == null) {
      throw const TeacherInfrastructureException(
          TeacherInfrastructureExceptionDetail.teacherNotFound);
    }
    final newRating =
        (oldRating[0] + evaluation.rating.value) / (oldRating[1] + 1);
    ratingStore[teacherId] = [
      oldRating[0] + evaluation.rating.value,
      oldRating[1] + 1
    ];
    store[teacherId] = Teacher(
      teacherId: teacher.teacherId,
      name: teacher.name,
      highSchool: teacher.highSchool,
      university: teacher.university,
      bio: teacher.bio,
      introduction: teacher.introduction,
      rating: Rating(newRating),
      bestSubjects: teacher.bestSubjects,
      profilePhotoPath: teacher.profilePhotoPath,
    );
  }
}

class InMemoryTeacherInitialValue {
  static final teacher1 = Teacher(
    teacherId: TeacherId('00000000000000000001'),
    name: Name('ゆうき先生'),
    highSchool: HighSchool('第二高校'),
    university:
        University(school: '第一大学', enrollmentStatus: EnrollmentStatus.enrolled),
    bio: Bio('わかりやすく教えます'),
    introduction: Introduction('数学が得意科目です。\nよろしくお願いします。'),
    rating: Rating(4.0),
    bestSubjects: [Subject.highMath],
    profilePhotoPath:
        ProfilePhotoPath('photos/profile_photo/sample_user_icon.jpg'),
  );

  static final teacher2 = Teacher(
    teacherId: TeacherId('00000000000000000002'),
    name: Name('しょーこしょーこしょーこ先生'),
    highSchool: HighSchool('第一高校'),
    university: University(
        school: '第二大学', enrollmentStatus: EnrollmentStatus.graduated),
    bio: Bio('丁寧にお教えします'),
    introduction: Introduction('初めまして。塾講師の経験があるので、わかりやすく教えることができると思います。'),
    rating: Rating(3.5),
    bestSubjects: [Subject.midEng],
    profilePhotoPath:
        ProfilePhotoPath('photos/profile_photo/sample_user_icon2.jpg'),
  );

  static final teacher3 = Teacher(
    teacherId: TeacherId('01234567890123456789'),
    name: Name('権兵衛先生'),
    highSchool: HighSchool('適当高校'),
    university: University(
        school: '適当大学', enrollmentStatus: EnrollmentStatus.graduated),
    bio: Bio('厳密第一'),
    introduction: Introduction('初めまして。分かりやすさより厳密さ。'),
    rating: Rating(3.5),
    bestSubjects: [Subject.highMath],
    profilePhotoPath:
        ProfilePhotoPath('assets/photos/profile_photo/sample_user_icon2.jpg'),
  );
}
