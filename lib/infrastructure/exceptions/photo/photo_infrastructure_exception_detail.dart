import '../../shared/infrastructure_exception_detail.dart';

enum PhotoInfrastructureExceptionDetail
    implements InfrastructureExceptionDetail {
  photoNotFound('photo not found'),
  ;

  const PhotoInfrastructureExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
