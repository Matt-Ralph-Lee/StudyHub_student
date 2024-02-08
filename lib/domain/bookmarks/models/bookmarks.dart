import '../exception/bookmarks_domain_exception.dart';
import '../exception/bookmarks_domain_exception_detail.dart';

import '../../question/models/question_id.dart';
import '../../student/models/student_id.dart';

class Bookmarks {
  static const maxLength = 5;
  final StudentId _studentId;
  final List<QuestionId> _questionIdList;

  StudentId get studentId => _studentId;
  List<QuestionId> get questionIdList => _questionIdList;
  int get length => _questionIdList.length;

  Bookmarks({
    required StudentId studentId,
    required List<QuestionId> questionIdList,
  })  : _studentId = studentId,
        _questionIdList = questionIdList {
    if (_questionIdList.length > maxLength) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.invalidQuestionLength);
    }
    if (_questionIdList.toSet().toList().length != _questionIdList.length) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.duplicateQuestion);
    }
  }

  void add(QuestionId newQuestionId) {
    if (_questionIdList.length >= maxLength) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.invalidQuestionLength);
    }
    if (_questionIdList.contains(newQuestionId)) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.duplicateQuestion);
    }
    _questionIdList.add(newQuestionId);
  }

  void delete(QuestionId questionId) {
    if (!_questionIdList.contains(questionId)) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.questionNotFound);
    }
    _questionIdList.remove(questionId);
  }

  bool canDelete(StudentId studentId) {
    return _studentId == studentId;
  }
}
