import 'package:cloud_firestore/cloud_firestore.dart';

import '../database.dart';

import '../../../domain/school/models/school.dart';
import '../../../domain/shared/name.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade_or_graduate_status.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/occupation.dart';
import '../../../domain/student/models/question_count.dart';
import '../../../domain/student/models/status.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';

class FirebaseStudentRepository implements IStudentRepository {
  final db = Database.db;

  static final FirebaseStudentRepository _instance =
      FirebaseStudentRepository._internal();

  factory FirebaseStudentRepository() {
    return _instance;
  }

  FirebaseStudentRepository._internal();

  @override
  Future<void> delete(StudentId studentId) async {
    await db.collection("students").doc(studentId.value).delete();
  }

  @override
  Future<Student?> findById(StudentId studentId) async {
    final docRef = db.collection("students").doc(studentId.value);
    final snapshot = await docRef.get();
    final doc = snapshot.data();

    if (doc == null) {
      return null;
    }

    final genderData = doc["gender"] as String;
    Gender gender = Gender.noAnswer;
    if (genderData == Gender.male.english) {
      gender = Gender.male;
    }
    if (genderData == Gender.female.english) {
      gender = Gender.female;
    }
    if (genderData == Gender.other.english) {
      gender = Gender.other;
    }

    final gradeOrGraduateStatusData = doc["gradeOrGraduateStatus"] as String;
    GradeOrGraduateStatus gradeOrGraduateStatus = GradeOrGraduateStatus.other;
    if (gradeOrGraduateStatusData == GradeOrGraduateStatus.first.english) {
      gradeOrGraduateStatus = GradeOrGraduateStatus.first;
    }
    if (gradeOrGraduateStatusData == GradeOrGraduateStatus.second.english) {
      gradeOrGraduateStatus = GradeOrGraduateStatus.second;
    }
    if (gradeOrGraduateStatusData == GradeOrGraduateStatus.third.english) {
      gradeOrGraduateStatus = GradeOrGraduateStatus.third;
    }
    if (gradeOrGraduateStatusData == GradeOrGraduateStatus.graduate.english) {
      gradeOrGraduateStatus = GradeOrGraduateStatus.graduate;
    }

    final name = doc["name"] as String;

    final occupationData = doc["occupation"] as String;

    Occupation occupation = Occupation.others;
    if (occupationData == Occupation.student.english) {
      occupation = Occupation.student;
    }
    if (occupationData == Occupation.teacher.english) {
      occupation = Occupation.teacher;
    }
    if (occupationData == Occupation.companyEmployee.english) {
      occupation = Occupation.companyEmployee;
    }

    final profilePhoto = doc["profilePhoto"] as String;
    final questionCount = doc["questionCount"] as int;
    final school = doc["school"] as String;
    final email = doc["email"] as String;

    Status status = Status.beginner;
    if (questionCount > Status.beginner.minQuestionCount.value) {
      status = Status.beginner;
    }
    if (questionCount > Status.novice.minQuestionCount.value) {
      status = Status.novice;
    }
    if (questionCount > Status.advanced.minQuestionCount.value) {
      status = Status.advanced;
    }
    if (questionCount > Status.expert.minQuestionCount.value) {
      status = Status.expert;
    }

    final student = Student(
      studentId: studentId,
      name: Name(name),
      profilePhotoPath: ProfilePhotoPath(profilePhoto),
      gender: gender,
      occupation: occupation,
      school: School(school),
      gradeOrGraduateStatus: gradeOrGraduateStatus,
      questionCount: QuestionCount(questionCount),
      status: status,
      emailAddress: EmailAddress(email),
    );

    return student;
  }

  @override
  Future<void> create(Student student) async {
    final docRef = db.collection("students").doc(student.studentId.value);

    final addData = <String, dynamic>{};

    addData["gender"] = student.gender.english;
    addData["gradeOrGraduateStatus"] = student.gradeOrGraduateStatus.english;
    addData["name"] = student.name.value;
    addData["occupation"] = student.occupation.english;
    addData["profilePhoto"] = student.profilePhotoPath.value;
    addData["questionCount"] = student.questionCount.value;
    addData["school"] = student.school.value;
    addData["blockings"] = <String>[];
    addData["bookmarks"] = <String>[];
    addData["favoriteTeachers"] = <String>[];
    addData["likedAnswers"] = <String>[];
    addData["email"] = student.emailAddress.value;

    await docRef.set(addData);
  }

  @override
  Future<void> update(Student student) async {
    final docRef = db.collection("students").doc(student.studentId.value);

    final addData = <String, dynamic>{};

    addData["gender"] = student.gender.english;
    addData["gradeOrGraduateStatus"] = student.gradeOrGraduateStatus.english;
    addData["name"] = student.name.value;
    addData["occupation"] = student.occupation.english;
    addData["profilePhoto"] = student.profilePhotoPath.value;
    addData["questionCount"] = student.questionCount.value;
    addData["school"] = student.school.value;

    await docRef.update(addData);
  }

  @override
  Future<void> incrementQuestionCount(StudentId studentId) async {
    final docRef = db.collection("students").doc(studentId.value);

    await docRef.update({"questionCount": FieldValue.increment(1)});
  }

  @override
  Future<bool> isStudent(EmailAddress emailAddress) async {
    final querySnapshot = await db
        .collection("students")
        .where("email", isEqualTo: emailAddress.value)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Future<void> updateEmailAddress({
    required StudentId studentId,
    required EmailAddress newEmailAddress,
  }) async {
    final docRef = db.collection("students").doc(studentId.value);

    await docRef.update({"email": newEmailAddress.value});
  }
}
