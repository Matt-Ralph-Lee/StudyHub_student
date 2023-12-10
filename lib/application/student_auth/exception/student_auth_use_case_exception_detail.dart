import '../../shared/exception/use_case_exception_detail.dart';

enum StudentAuthUseCaseExceptionDetail implements UseCaseExceptionDetail {
  // invalidCharacter('使用できない文字が含まれています'),
  // invalidEmailFormat('メールアドレスの形式ではありません'),
  // shortPassword('パスワードが短すぎます。${Password.minLength}文字以上にしてください'),
  // longPassword('パスワードが長すぎます。${Password.maxLength}文字以下にしてください'),
  // TODO: メールアドレスが被っちゃダメというルールをここに残しておくと危ない？
  alreadyExists('メールアドレスはすでに使用されています'),
  notFound('アカウントが見つかりません'),
  // invalidLength('The length is not within the specified range.'),
  // missingCharacter('Missing specified character to be used.'),
  // weakPassword('The password is weak.'),
  // noCurrentAccount('There does not exist current Account.'),

  // wrongPassword('Password is wrong.'),
  ;

  const StudentAuthUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
