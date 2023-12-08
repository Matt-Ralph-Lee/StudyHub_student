class StudentAuthInfoUpdateCommand {
  final String? _emailAddress;
  final String? _password;

  String? get emailAddress => _emailAddress;
  String? get password => _password;

  StudentAuthInfoUpdateCommand(this._emailAddress, this._password);
}
