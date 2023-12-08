import 'package:uuid/uuid.dart';

import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/student_auth_info.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_factory.dart';
import '../../../domain/student_auth/models/password.dart';
import 'firebase_account_repository.dart';

class FirebaseAccountFactory implements IStudentFactory {
  final FirebaseAccountRepository _repository;

  FirebaseAccountFactory(this._repository);

  @override
  StudentAuthInfo createWithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  }) {
    var accountId = StudentId(const Uuid().v4());
    while (_repository.findById(accountId) != null) {
      accountId = StudentId(const Uuid().v4());
    }

    return StudentAuthInfo(
      accountId: accountId,
      emailAddress: emailAddress,
      password: password,
      isVerified: false,
    );
  }
}
