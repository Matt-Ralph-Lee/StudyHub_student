import 'package:flutter/material.dart';

import '../../photo/models/photo_path.dart';
import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';
import 'question_photo_format.dart';

class QuestionPhotoPath extends PhotoPath {
  final _pathRegExp =
      RegExp(r'^[/\w\-_.]+\.(' + QuestionPhotoFormat.regExpString + r')$');

  QuestionPhotoPath(super.value);

  @override
  void validate(String value) {
    if (!_pathRegExp.hasMatch(value)) {
      debugPrint(value);
      debugPrint(_pathRegExp.toString());
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidPhotoPath);
    }
  }
}
