import '../../../domain/question/models/question_id.dart';

class QuestionCardDto {
  final QuestionId _questionId;
  final String _studentProfilePhotoPath;
  final String _questionTitle;
  final String _questionText;
  final String? _teacherProfilePhotoPath;
  final String? _answerText;

  QuestionId get questionId => _questionId;
  String get studentProfilePhotoPath => _studentProfilePhotoPath;
  String get questionTitle => _questionTitle;
  String get questionText => _questionText;
  String? get teacherProfilePhotoPath => _teacherProfilePhotoPath;
  String? get answerText => _answerText;

  QuestionCardDto({
    required final QuestionId questionId,
    required final String studentProfilePhotoPath,
    required final String questionTitle,
    required final String questionText,
    required final String? teacherProfilePhotoPath,
    required final String? answerText,
  })  : _questionId = questionId,
        _studentProfilePhotoPath = studentProfilePhotoPath,
        _questionTitle = questionTitle,
        _questionText = questionText,
        _teacherProfilePhotoPath = teacherProfilePhotoPath,
        _answerText = answerText;
}
