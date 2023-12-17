import 'infrastructure_exception_detail.dart';

abstract class InfrastructureException implements Exception {
  final InfrastructureExceptionDetail detail;
  final dynamic info;

  const InfrastructureException(
    this.detail, {
    this.info,
  });

  @override
  String toString() {
    return '$runtimeType{message: ${detail.message}, info: $info}';
  }
}
