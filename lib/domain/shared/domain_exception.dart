import 'domain_exception_detail.dart';

abstract class DomainException implements Exception {
  final DomainExceptionDetail detail;
  final dynamic info;

  const DomainException(
    this.detail, {
    this.info,
  });

  @override
  String toString() {
    return '$runtimeType{message: ${detail.message}, info: $info}';
  }
}
