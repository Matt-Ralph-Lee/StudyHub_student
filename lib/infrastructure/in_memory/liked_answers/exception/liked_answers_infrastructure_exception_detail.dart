import '../../../shared/infrastructure_exception_detail.dart';

enum LikedAnswersInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  likedAnswersNotFound('liked answers not found'),
  ;

  const LikedAnswersInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
