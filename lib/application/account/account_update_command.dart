class AccountUpdateCommand {
  final String? _emailAddress;
  final String? _password;

  String? get emailAddress => _emailAddress;
  String? get password => _password;

  AccountUpdateCommand(this._emailAddress, this._password);
}
