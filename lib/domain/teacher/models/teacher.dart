import '../../student/models/student_name.dart';
import 'bio.dart';
import 'high_school_name.dart';
import 'introduction.dart';
import 'rating.dart';
import 'teacher_id.dart';
import 'university_name.dart';

class Teacher {
  final TeacherId _teacherId;
  final StudentName _name; // TODO: StudentName -> Name
  final HighSchoolName _highSchoolName;
  final UniversityName _universityName;
  final Bio _bio;
  final Introduction _introduction;
  final Rating _rating;

  TeacherId get teacherId => _teacherId;
  StudentName get name => _name;
  HighSchoolName get highSchoolName => _highSchoolName;
  UniversityName get universityName => _universityName;
  Bio get bio => _bio;
  Introduction get introduction => _introduction;
  Rating get rating => _rating;

  Teacher._({
    required TeacherId teacherId,
    required StudentName name,
    required HighSchoolName highSchoolName,
    required UniversityName universityName,
    required Bio bio,
    required Introduction introduction,
    required Rating rating,
  })  : _teacherId = teacherId,
        _name = name,
        _highSchoolName = highSchoolName,
        _universityName = universityName,
        _bio = bio,
        _introduction = introduction,
        _rating = rating;
}
