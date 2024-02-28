import '../exception/bookmarks_domain_exception.dart';
import '../exception/bookmarks_domain_exception_detail.dart';

import '../../question/models/question_id.dart';
import '../../student/models/student_id.dart';

class Bookmarks extends Iterable<QuestionId> {
  final StudentId _studentId;
  final Set<QuestionId> _questionIdSet;

  StudentId get studentId => _studentId;
  Set<QuestionId> get questionIdSet => _questionIdSet;

  Bookmarks({
    required final StudentId studentId,
    required final Set<QuestionId> questionIdSet,
  })  : _studentId = studentId,
        _questionIdSet = questionIdSet;

  void add(final QuestionId newQuestionId) {
    if (_questionIdSet.contains(newQuestionId)) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.duplicateQuestion);
    }
    _questionIdSet.add(newQuestionId);
  }

  void delete(final QuestionId questionId) {
    if (!_questionIdSet.contains(questionId)) {
      throw const BookmarksDomainException(
          BookmarksDomainExceptionDetail.questionNotFound);
    }
    _questionIdSet.remove(questionId);
  }

  bool canDelete(final StudentId studentId) {
    return _studentId == studentId;
  }

  @override
  Iterator<QuestionId> get iterator => _questionIdSet.iterator;
}
