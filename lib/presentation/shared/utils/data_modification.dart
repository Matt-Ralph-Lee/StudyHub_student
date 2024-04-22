// do not use this in normal occasion
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade_or_graduate_status.dart';
import '../../../domain/student/models/occupation.dart';

void modifyStudentData() async {
  final db = FirebaseFirestore.instance;

  final querySnapshot = await db.collection("students").get();

  for (final docSnapshot in querySnapshot.docs) {
    final doc = docSnapshot.data();

    final profilePhoto = doc["profilePhoto"];

    final sex = doc["sex"];
    final grade = doc["grade"];
    final userName = doc["userName"];

    if (profilePhoto == null) {
      final blockings = [];
      final bookmarks = [];
      final favoriteTeachers = [];
      String profilePhoto = "";

      String gender = Gender.noAnswer.english;
      if (sex == "男") {
        gender = Gender.male.english;
        profilePhoto = "profile_photo/default/male_default.jpg";
      }
      if (sex == "女") {
        gender = Gender.female.english;
        profilePhoto = "profile_photo/default/female_default.jpg";
      }
      if (sex == "回答しない") {
        gender = Gender.noAnswer.english;
        profilePhoto = "profile_photo/default/female_default.jpg";
      }

      String gradeOrGraduateState = GradeOrGraduateStatus.other.english;
      if (grade == "1年") {
        gradeOrGraduateState = GradeOrGraduateStatus.first.english;
      }
      if (grade == "2年") {
        gradeOrGraduateState = GradeOrGraduateStatus.second.english;
      }
      if (grade == "3年") {
        gradeOrGraduateState = GradeOrGraduateStatus.third.english;
      }
      if (grade == "その他") {
        gradeOrGraduateState = GradeOrGraduateStatus.other.english;
      }

      final likedAnswer = [];
      final name = userName;
      final occupation = Occupation.student.english;

      final studentId = docSnapshot.reference.id;
      final querySnapshot = await db
          .collection("all_questions")
          .where("student_uid", isEqualTo: studentId)
          .get();
      final questionCount = querySnapshot.size;

      final addData = <String, dynamic>{};

      addData["blockings"] = blockings;
      addData["bookmarks"] = bookmarks;
      addData["favoriteTeachers"] = favoriteTeachers;
      addData["gender"] = gender;
      addData["gradeOrGradutateStatus"] = gradeOrGraduateState;
      addData["likedAnswers"] = likedAnswer;
      addData["occupation"] = occupation;
      addData["profilePhoto"] = profilePhoto;
      addData["questionCount"] = questionCount;
      addData["name"] = name;

      // to activate this function, please remove the comment below and make it as a code

      // await docSnapshot.reference.update(addData);
    }
  }
}
