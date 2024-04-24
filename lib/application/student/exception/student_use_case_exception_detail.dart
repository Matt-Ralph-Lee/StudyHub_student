import '../../shared/exception/use_case_exception_detail.dart';

enum StudentUseCaseExceptionDetail implements UseCaseExceptionDetail {
  notFound('student not found'),
  failedInImageProcessing('failed in image processing'),
  noSchoolFound('no school found'),
  noProfileFound('no profile found'),
  photoNotFound('image not found'),
  notSignedIn('not signed in'),
  ;

  const StudentUseCaseExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
