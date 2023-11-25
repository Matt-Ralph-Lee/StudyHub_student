import '../exception_detail.dart';

enum PhotoCreationExceptionDetail implements ExceptionDetail {
  empty(
    'emptyException',
    'Empty is not allowed.',
  ),
  invalidPathFormat(
    'invalidUrlFormatException',
    'Invalid url.',
  ),
  ;

  const PhotoCreationExceptionDetail(
    this._exceptionTitle,
    this._exceptionMessage,
  );

  final String _exceptionTitle;
  final String _exceptionMessage;

  @override
  String get exceptionTitle => _exceptionTitle;

  @override
  String get exceptionMessage => _exceptionMessage;
}
