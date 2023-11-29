import '../exception_detail.dart';

enum StudentCreationExceptionDetail implements ExceptionDetail {
  empty(
    'emptyException',
    'Empty is not allowed.',
  ),
  invalidLength(
    'lengthException',
    'The length is not within the specified range.',
  ),
  missingCharacter(
    'missingCharacterException',
    'Missing specified character to be used.',
  ),
  invalidCharacter(
    'invalidCharacterException',
    'Invalid character is used.',
  ),
  alreadyExists(
    'alreadyexistException',
    'The account already exists.',
  ),
  ;

  const StudentCreationExceptionDetail(
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
