import '../database.dart';

import '../../../domain/shared/name.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/teacher/models/bio.dart';
import '../../../domain/teacher/models/graduated.dart';
import '../../../domain/teacher/models/high_school.dart';
import '../../../domain/teacher/models/i_teacher_repository.dart';
import '../../../domain/teacher/models/introduction.dart';
import '../../../domain/teacher/models/rating.dart';
import '../../../domain/teacher/models/teacher.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher/models/university.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../exceptions/teacher/teacher_infrastructure_exception.dart';
import '../../exceptions/teacher/teacher_infrastructure_exception_detail.dart';

class FirebaseTeacherRepository implements ITeacherRepository {
  final db = Database.db;

  static final FirebaseTeacherRepository _instance =
      FirebaseTeacherRepository._internal();

  factory FirebaseTeacherRepository() {
    return _instance;
  }

  FirebaseTeacherRepository._internal();

  @override
  Future<void> changeRate(TeacherEvaluation evaluation) async {
    final teacherId = evaluation.to;

    final docRef = db.collection("teachers").doc(teacherId.value);
    final snapshot = await docRef.get();
    final doc = snapshot.data();

    if (doc == null) {
      throw const TeacherInfrastructureException(
          TeacherInfrastructureExceptionDetail.docNotFound);
    }

    final ratingSum = doc["ratingSum"] as int;
    final ratingNum = doc["ratingNum"] as int;

    final newRatingNum = ratingNum + 1;
    final newRatingSum = ratingSum + evaluation.rating.value;

    await docRef.update({"ratingSum": newRatingSum, "ratingNum": newRatingNum});
  }

  @override
  Future<Teacher?> getByTeacherId(TeacherId teacherId) async {
    final docRef = db.collection("teachers").doc(teacherId.value);
    final snapshot = await docRef.get();
    final doc = snapshot.data();

    if (doc == null) {
      return null;
    }

    final bio = doc["BIO"] as String;
    final bestSubjectsData = doc["bestSubjects"] as List<dynamic>;
    final bestSubjects = <Subject>[];
    for (final bestSubjectData in bestSubjectsData) {
      if (bestSubjectData == Subject.highEng.japanese) {
        bestSubjects.add(Subject.highEng);
      }
      if (bestSubjectData == Subject.highMath.japanese) {
        bestSubjects.add(Subject.highMath);
      }
      if (bestSubjectData == Subject.midEng.japanese) {
        bestSubjects.add(Subject.midEng);
      }
      if (bestSubjectData == Subject.midMath.japanese) {
        bestSubjects.add(Subject.midMath);
      }
    }

    final highSchool = doc["highSchool"] as String;
    final introduction = doc["introduction"] as String;
    final name = doc["name"] as String;
    final profilePhoto = doc["profilePhoto"] as String;
    final ratingNum = doc["ratingNum"] as int;
    final ratingSum = doc["ratingSum"] as int;
    final university = doc["university"] as String;
    final enrollmentStatusData = doc["enrollmentStatus"] as String;

    EnrollmentStatus enrollmentStatus = EnrollmentStatus.noAnswer;
    if (enrollmentStatusData == EnrollmentStatus.enrolled.english) {
      enrollmentStatus = EnrollmentStatus.enrolled;
    }
    if (enrollmentStatusData == EnrollmentStatus.graduated.english) {
      enrollmentStatus = EnrollmentStatus.graduated;
    }

    final teacher = Teacher(
      teacherId: teacherId,
      name: Name(name),
      highSchool: HighSchool(highSchool),
      university: University(
        school: university,
        enrollmentStatus: enrollmentStatus,
      ),
      bio: Bio(bio),
      introduction: Introduction(introduction),
      rating: ratingSum == 0 ? Rating(0) : Rating(ratingSum / ratingNum),
      bestSubjects: bestSubjects,
      profilePhotoPath: ProfilePhotoPath(profilePhoto),
    );

    return teacher;
  }
}
