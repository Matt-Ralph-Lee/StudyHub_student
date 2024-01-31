import '../../shared/domain_exception_detail.dart';
import '../models/password.dart';

enum StudentAuthDomainExceptionDetail implements DomainExceptionDetail {
  invalidCharacter('使用できない文字が含まれています'),
  invalidEmailFormat('メールアドレスの形式ではありません'),
  shortPassword('パスワードが短すぎます。${Password.minLength}文字以上にしてください'),
  longPassword('パスワードが長すぎます。${Password.maxLength}文字以下にしてください'),
  ;

  const StudentAuthDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
