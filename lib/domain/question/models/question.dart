import '../../answer_list/models/answer_list.dart';

import '../../student/models/student_id.dart';

import 'question_id.dart';
import 'question_subject.dart';
import 'question_title.dart';
import 'question_text.dart';
import 'question_photo_path_list.dart';
import 'seen_count.dart';

class Question {
  final QuestionId _questionId;
  final QuestionSubject _questionSubject;
  final StudentId _studentId;
  final AnswerList _answerList;
  final SeenCount _seenCount;
  QuestionTitle _questionTitle;
  QuestionText _questionText;
  QuestionPhotoPathList _questionPhotoPathList;
  // TODO: selected teacher
  bool _questionResolved;

  QuestionId get questionId => _questionId;
  QuestionSubject get questionSubject => _questionSubject;
  QuestionTitle get questionTitle => _questionTitle;
  QuestionText get questionText => _questionText;
  QuestionPhotoPathList get questionPhotoPathList => _questionPhotoPathList;
  StudentId get studentId => _studentId;
  AnswerList get answerList => _answerList;
  SeenCount get seenCount => _seenCount;
  bool get questionResolved => _questionResolved;

  Question({
    required final QuestionId questionId,
    required final QuestionSubject questionSubject,
    required final QuestionTitle questionTitle,
    required final QuestionText questionText,
    required final QuestionPhotoPathList questionPhotoPathList,
    required final StudentId studentId,
    required final AnswerList answerList,
    required final SeenCount seenCount,
    required final bool questionResolved,
  })  : _questionId = questionId,
        _questionSubject = questionSubject,
        _questionTitle = questionTitle,
        _questionText = questionText,
        _questionPhotoPathList = questionPhotoPathList,
        _studentId = studentId,
        _answerList = answerList,
        _seenCount = seenCount,
        _questionResolved = questionResolved;

// 下記の編集権限は必ずstudentIdの一致を確認すること
  void changeQuestionTitle(final QuestionTitle newQuestionTitle) {
    _questionTitle = newQuestionTitle;
  }

  void changeQuestionText(final QuestionText newQuestionText) {
    _questionText = newQuestionText;
  }

  // 写真を追加するときどのように操作するかに依存する。毎度写真の配列毎入れ替えるのか、追加削除を可能にするのか
  void changeQuestionPhotoPathList(
      final QuestionPhotoPathList newQuestionPhotoPathList) {
    _questionPhotoPathList = newQuestionPhotoPathList;
  }

  void changeQuestionResolved(final bool newQuestionResolved) {
    _questionResolved = newQuestionResolved;
  }

  bool canDelete(final StudentId studentId) {
    return studentId == _studentId;
  }

  bool canEdit(final StudentId studentId) {
    return studentId == _studentId;
  }
}
