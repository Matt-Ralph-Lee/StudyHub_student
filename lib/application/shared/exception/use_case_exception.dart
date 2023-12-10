import 'use_case_exception_detail.dart';

abstract class UseCaseException implements Exception {
  final UseCaseExceptionDetail detail;
  final dynamic info;

  const UseCaseException(
    this.detail, {
    this.info,
  });

  @override
  String toString() {
    return '$runtimeType{message: ${detail.message}, info: $info}';
  }
}
