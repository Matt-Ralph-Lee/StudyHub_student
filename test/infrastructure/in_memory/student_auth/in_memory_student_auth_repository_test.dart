import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/student_auth/models/password.dart';
import 'package:studyhub/domain/student_auth/models/student_auth_info.dart';
import 'package:studyhub/infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';
import 'package:studyhub/infrastructure/shared/infrastructure_exception.dart';

void main() {
  setUp(() {});

  final studentId1 = StudentId('111111111111111111111');
  final emailAddress1 = EmailAddress('test1@example.com');
  final password1 = Password('password1');
  final studentAuthInfo1 = StudentAuthInfo(
    studentId: studentId1,
    emailAddress: emailAddress1,
    password: password1,
    isVerified: false,
  );

  final studentId2 = StudentId('222222222222222222222');
  final emailAddress2 = EmailAddress('test2@example.com');
  final password2 = Password('password2');
  final studentAuthInfo2 = StudentAuthInfo(
    studentId: studentId2,
    emailAddress: emailAddress2,
    password: password2,
    isVerified: false,
  );

  group('create', () {
    test('test create studentAuthInfo with password', () {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);

      final storedStudentAuthInfo = repository.store[studentId1];
      expect(storedStudentAuthInfo?.studentId, studentId1);

      final signedIn = repository.signedInStore[studentId1];
      expect(signedIn, equals(false));

      final mappedId = repository.emailToIdMap[emailAddress1];
      expect(mappedId, equals(studentId1));
      _printStudentAuthInfo(storedStudentAuthInfo);
    });

    test('test throw exception when creating studentAuthInfo without password',
        () {
      final repository = InMemoryStudentAuthRepository();
      final studentId = StudentId('01234567890123456789');
      final emailAddress = EmailAddress('test@example.com');

      final studentAuthInfo = StudentAuthInfo(
        studentId: studentId,
        emailAddress: emailAddress,
        password: null,
        isVerified: false,
      );
      expect(() => repository.create(studentAuthInfo),
          throwsA(isA<InfrastructureException>()));
    });
  });

  group('delete', () {
    test('delete normally', () {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);
      repository.create(studentAuthInfo2);

      print('store size before deletion: ${repository.store.length}');

      final storedStudentAuthInfo2 = repository.store[studentId2];
      expect(storedStudentAuthInfo2?.studentId, equals(studentId2));

      repository.delete(studentId2);

      final currentlyStoredStudentAuth = repository.store[studentId2];
      expect(currentlyStoredStudentAuth?.studentId, equals(null));

      final signedIn = repository.signedInStore[studentId2];
      expect(signedIn, equals(null));

      final mappedId = repository.emailToIdMap[emailAddress2];
      expect(mappedId, equals(null));

      print('store size after deletion: ${repository.store.length}');
    });
  });

  group('findById', () {
    test('find by id normally', () {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);
      repository.create(studentAuthInfo2);

      final found = repository.findById(studentId1);
      expect(found?.studentId, equals(studentId1));
      expect(found?.password, equals(null));
      _printStudentAuthInfo(found);
    });

    test('cannot find', () {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);
      repository.create(studentAuthInfo2);

      repository.delete(studentId1);

      final found = repository.findById(studentId1);
      expect(found?.studentId, equals(null));
      _printStudentAuthInfo(found);
    });
  });

  group('findByEmail', () {
    test('find by email normally', () {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);
      repository.create(studentAuthInfo2);

      final found = repository.findByEmailAddress(emailAddress1);
      expect(found?.studentId, equals(studentId1));
      expect(found?.password, equals(null));
      _printStudentAuthInfo(found);
    });

    test('cannot find', () {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);
      repository.create(studentAuthInfo2);

      repository.delete(studentId1);

      final found = repository.findByEmailAddress(emailAddress1);
      expect(found?.studentId, equals(null));
      _printStudentAuthInfo(found);
    });
  });

  group('signIn', () {
    test('sign in normally', () {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);
      bool? signedIn = repository.signedInStore[studentId1];
      expect(signedIn, equals(false));
      repository.signIn(emailAddress: emailAddress1, password: password1);
      signedIn = repository.signedInStore[studentId1];
      expect(signedIn, equals(true));
    });
  });

  group('signOut', () {
    test('sign out normally', () {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);
      repository.signIn(emailAddress: emailAddress1, password: password1);
      bool? signedIn = repository.signedInStore[studentId1];
      expect(signedIn, equals(true));
      repository.signOut(studentId1);
      signedIn = repository.signedInStore[studentId1];
      expect(signedIn, equals(false));
    });
  });

  group('getAccountState', () {
    test('get account state normally', () async {
      final repository = InMemoryStudentAuthRepository();

      repository.create(studentAuthInfo1);

      final stream = repository.accountState(studentId1);
      stream.listen((data) {
        _printStudentAuthInfo(data);
      });

      await Future.delayed(const Duration(seconds: 1));
      repository.verifyWithEmail(studentId1);
      await Future.delayed(const Duration(seconds: 1));
      repository.signIn(emailAddress: emailAddress1, password: password1);
      await Future.delayed(const Duration(seconds: 1));
      repository.signOut(studentId1);
    });
  });
}

void _printStudentAuthInfo(final StudentAuthInfo? studentAuthInfo) {
  if (studentAuthInfo == null) {
    print(null);
    return;
  }
  final studentId = studentAuthInfo.studentId;
  final emailAddress = studentAuthInfo.emailAddress;
  final password = studentAuthInfo.password;
  final isVerified = studentAuthInfo.isVerified;

  print(
      'studentId: ${studentId.value}\nemailAddress: ${emailAddress.value}\npassword: ${password?.value}\nisVerified: $isVerified');
}
