import '../exception/bookmarks_domain_exception.dart';
import '../exception/bookmarks_domain_exception_detail.dart';

import '../../question/models/question_id.dart';
import '../../student/models/student_id.dart';

class Bookmarks extends Iterable {
  final StudentId _studentId;
  final Set<QuestionId> _questionIdSet;

  StudentId get studentId => _studentId;
  Set<QuestionId> get questionIdSet => _questionIdSet;

  Bookmarks({
    required final StudentId studentId,
    required final Set<QuestionId> questionIdSet,
  })  : _studentId = studentId,
        _questionIdSet = questionIdSet;

  void add(QuestionId newQuestionId) {
    if (_questionIdSet.contains(newQuestionId)) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.duplicateQuestion);
    }
    _questionIdSet.add(newQuestionId);
  }

  void delete(QuestionId questionId) {
    if (!_questionIdSet.contains(questionId)) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.questionNotFound);
    }
    _questionIdSet.remove(questionId);
  }

  bool canDelete(StudentId studentId) {
    return _studentId == studentId;
  }

  @override
  Iterator get iterator => _questionIdSet.iterator;
}
