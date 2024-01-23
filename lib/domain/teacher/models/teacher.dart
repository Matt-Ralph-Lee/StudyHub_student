import '../../shared/profile_photo_path.dart';
import '../../shared/name.dart';
import 'bio.dart';
import 'high_school.dart';
import 'introduction.dart';
import 'rating.dart';
import 'teacher_id.dart';
import 'university.dart';

class Teacher {
  final TeacherId _teacherId;
  final Name _name;
  final HighSchool _highSchool;
  final University _university;
  final Bio _bio;
  final Introduction _introduction;
  final Rating _rating;
  final List<Subject> _bestSubjects;
  final ProfilePhotoPath _profilePhotoPath;

  TeacherId get teacherId => _teacherId;
  Name get name => _name;
  HighSchool get highSchool => _highSchool;
  University get university => _university;
  Bio get bio => _bio;
  Introduction get introduction => _introduction;
  Rating get rating => _rating;
  List<Subject> get bestSubjects => _bestSubjects;
  ProfilePhotoPath get profilePhotoPath => _profilePhotoPath;

  Teacher._({
    required final TeacherId teacherId,
    required final Name name,
    required final HighSchool highSchool,
    required final University university,
    required final Bio bio,
    required final Introduction introduction,
    required final Rating rating,
    required final List<Subject> bestSubjects,
    required final ProfilePhotoPath profilePhotoPath,
  })  : _teacherId = teacherId,
        _name = name,
        _highSchool = highSchool,
        _university = university,
        _bio = bio,
        _introduction = introduction,
        _rating = rating,
        _bestSubjects = bestSubjects,
        _profilePhotoPath = profilePhotoPath;
}
