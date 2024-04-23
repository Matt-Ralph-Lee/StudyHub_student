import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class AnswerDto {
  final AnswerId _answerId;
  final QuestionId _questionId;
  final TeacherId _teacherId;
  final String _teacherName;
  final String _teacherProfilePath;
  final String _answerText;
  final int _answerLike;
  final bool _isFollowing;
  final bool _isBlocking;
  final bool _isEvaluated;
  final List<String> _answerPhotoList;
  final bool _hasLiked;

  AnswerId get answerId => _answerId;
  QuestionId get questionId => _questionId;
  TeacherId get teacherId => _teacherId;
  String get teacherName => _teacherName;
  String get teacherProfilePath => _teacherProfilePath;
  String get answerText => _answerText;
  int get answerLike => _answerLike;
  bool get isFollowing => _isFollowing;
  bool get isBlocking => _isBlocking;
  bool get isEvaluated => _isEvaluated; //追加
  List<String> get answerPhotoList => _answerPhotoList;
  bool get hasLiked => _hasLiked;

  AnswerDto({
    required final AnswerId answerId,
    required final QuestionId questionId,
    required final TeacherId teacherId,
    required final String teacherName,
    required final String teacherProfilePath,
    required final String answerText,
    required final int answerLike,
    required final bool isFollowing,
    required final bool isBlocking,
    required final bool isEvaluated, //追加
    required final List<String> answerPhotoList,
    required final bool hasLiked,
  })  : _answerId = answerId,
        _questionId = questionId,
        _teacherId = teacherId,
        _teacherName = teacherName,
        _teacherProfilePath = teacherProfilePath,
        _answerText = answerText,
        _answerLike = answerLike,
        _isFollowing = isFollowing,
        _isBlocking = isBlocking,
        _isEvaluated = isEvaluated,
        _answerPhotoList = answerPhotoList,
        _hasLiked = hasLiked;
}
