import '../exception_detail.dart';

enum ArgumentExceptionDetail implements ExceptionDetail {
  emptyException(
    'emptyException',
    'empty is not allowed.',
  ),
  lengthException(
    'lengthException',
    'The length is not within the specified range.',
  ),
  missingCharacterException(
    'missingCharacterException',
    'missing specified character to be used.',
  ),
  invalidCharacterException(
    'invalidCharacterException',
    'invalid character is used.',
  ),
  ;

  const ArgumentExceptionDetail(
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
