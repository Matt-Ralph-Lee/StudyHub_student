import '../../account/models/account_id.dart';
import 'student.dart';

abstract class IStudentFactory {
  Student createInitially(final AccountId accountId);
}
