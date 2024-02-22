import '../exception/report_domain_exception.dart';
import '../exception/report_domain_exception_detail.dart';

class ReportText {
  final String _value;
  String get value => _value;
  static const int maxLength = 100;
  static const int maxLine = 10;

  ReportText(this._value) {
    validate(_value);
  }

  void validate(final String value) {
    if (value.isEmpty) {
      throw const ReportDomainException(ReportDomainExceptionDetail.textEmpty);
    }
    if (value.length > maxLength) {
      throw const ReportDomainException(
          ReportDomainExceptionDetail.textInvalidLength);
    }
    if (value.split('\n').length > maxLine) {
      throw const ReportDomainException(
          ReportDomainExceptionDetail.textInvalidLineLength);
    }
  }
}
