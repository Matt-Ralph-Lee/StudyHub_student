import '../../shared/exception/use_case_exception.dart';
import 'blockings_use_case_exception_detail.dart';

class BlockingsUseCaseException extends UseCaseException {
  const BlockingsUseCaseException(
    BlockingsUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
