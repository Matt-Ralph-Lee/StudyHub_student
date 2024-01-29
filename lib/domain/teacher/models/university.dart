
import '../../school/models/school.dart'
import 'graduated.dart';

class University extends School {
  final EnrollmentStatus _enrollmentStatus;

  University({required final School school, required final EnrollmentStatus enrollmentStatus})
   : _enrollmentStatus = enrollmentStatus,
   super(school);


}
