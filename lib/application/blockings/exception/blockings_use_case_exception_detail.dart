import '../../shared/exception/use_case_exception_detail.dart';

enum BlockingsUseCaseExceptionDetail implements UseCaseExceptionDetail {
  blockingsNotFound('Blockingsが見つかりませんでした。');

  const BlockingsUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
