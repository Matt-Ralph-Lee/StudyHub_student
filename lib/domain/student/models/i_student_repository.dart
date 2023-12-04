import '../../account/models/account_id.dart';
import '../../account/models/email_address.dart';
import 'student.dart';

abstract class IStudentRepository {
  void save(final Student student);
  void delete(final AccountId accountId);
  Student? findByEmailAddress(final EmailAddress emailAddress);
  Student? findById(final AccountId accountId);
}
