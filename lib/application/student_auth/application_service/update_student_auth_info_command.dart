class UpdateStudentAuthInfoCommand {
  final String? _emailAddress;
  final String? _emailAddressToResetPassword;

  UpdateStudentAuthInfoCommand({
    required final String? emailAddress,
    required final String? emailAddressToResetPassword,
  })  : _emailAddress = emailAddress,
        _emailAddressToResetPassword = emailAddressToResetPassword;

  String? get emailAddress => _emailAddress;
  String? get emailAddressToResetPassword => _emailAddressToResetPassword;
}
