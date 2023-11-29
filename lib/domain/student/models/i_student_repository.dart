import 'package:studyhub/domain/student/models/student_id.dart';

import 'student.dart';
import 'email_address.dart';
import '../../account/password.dart';

abstract class IStudentRepository {
  Future<void> save(final Student student);

  Future<void> delete();
  Stream<Student?> accountStateChanges();
  Student? getCurrentAccount();
  Stream<bool> isSignedIn();
  Student? findByEmailAddress(final EmailAddress emailAddress);
  Student? findById(final StudentId studentId);
  Future<void> resetPassword({
    required final Student account,
    required Password newPassword,
  });
  Future<void> saveChangedEmailAddress(final Student modifiedAccount);
}
