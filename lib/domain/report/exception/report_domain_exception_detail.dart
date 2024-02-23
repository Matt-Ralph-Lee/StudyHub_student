import '../../shared/domain_exception_detail.dart';
import '../models/report_text.dart';

enum ReportDomainExceptionDetail implements DomainExceptionDetail {
  textInvalidLength('${ReportText.maxLength}字以下にしてください。'),
  textInvalidLineLength('${ReportText.maxLine}行以内にしてください。'),
  ;

  const ReportDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
