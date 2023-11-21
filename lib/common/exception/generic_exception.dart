import 'exception_detail.dart';

// 例外を表すモデル
// 例外をひとつひとつ作ると、例外捕捉の条件分岐がややこしくなるので、性質の似ているものはとりあえずまとめる方針でいきます
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
