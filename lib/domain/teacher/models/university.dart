import '../../school/models/school.dart';
import 'graduated.dart';

class University extends School {
  final EnrollmentStatus _enrollmentStatus;

  EnrollmentStatus get enrollmentStatus => _enrollmentStatus;

  University(
      {required final String school,
      required final EnrollmentStatus enrollmentStatus})
      : _enrollmentStatus = enrollmentStatus,
        super(school);
}
