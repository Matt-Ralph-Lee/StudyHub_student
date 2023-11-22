import 'exception_detail.dart';

abstract class GenericException implements Exception {
  final ExceptionDetail exceptionDetail;
  final dynamic info;

  const GenericException(
    this.exceptionDetail, {
    this.info,
  });

  @override
  String toString() {
    return '$runtimeType{title: ${exceptionDetail.exceptionTitle}, message: ${exceptionDetail.exceptionMessage}, info: $info}';
  }
}
