import 'package:studyhub/domain/question/models/selected_teacher_list.dart';

import '../../shared/domain_exception_detail.dart';
import '../models/question_id.dart';
import '../models/question_title.dart';
import '../models/question_text.dart';
import '../models/question_photo.dart';
import '../models/question_photo_path_list.dart';

enum QuestionDomainExceptionDetail implements DomainExceptionDetail {
  idInvalidLength('${QuestionId.minLength}字以上にしてください。'),
  titleInvalidLength(
      '${QuestionTitle.minLength}字以上${QuestionTitle.maxLength}字以下にしてください。'),
  textEmptyLength('文字列が空です。質問を入力してください。'),
  textInvalidLength('${QuestionText.maxLength}字以上にしてください。'),
  textInvalidLineLength('${QuestionText.maxLine}行い内にしてください。'),
  invalidPhotoPath('画像パスが不正です'),
  invalidPhotoSize('画像の大きさは${QuestionPhoto.dataSize}以下にしてください。'),
  invalidPhotoLength('画像は${QuestionPhotoPathList.maxLength}枚までです。'),
  invalidSeenCount('閲覧数が不正です。'),
  invalidIndex('不正なindexです。'),
  invalidTeacherLength(
      '先生の指定数が多すぎます。${SelectedTeacherList.maxLength}人以内にしてください。');

  const QuestionDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
