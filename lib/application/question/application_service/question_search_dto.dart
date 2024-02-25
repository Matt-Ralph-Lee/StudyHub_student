import '../../../domain/question/models/question_id.dart';

class QuestionSearchDto {
  final QuestionId _questionId;
  final String _studentProfilePhotoPath;
  final String _questionTitleData;
  final String _questionTextData;
  final String? _teacherProfilePhotoPath;
  final String? _answerTitleData;
  final String? _answerTextData;

  QuestionId get questionId => _questionId;
  String get studentProfilePhotoPath => _studentProfilePhotoPath;
  String get questionTitleData => _questionTitleData;
  String get questionTextData => _questionTextData;
  String? get teacherProfilePhotoPath => _teacherProfilePhotoPath;
  String? get answerTitleData => _answerTitleData;
  String? get answerTextData => _answerTextData;

  QuestionSearchDto({
    required final QuestionId questionId,
    required final String studentProfilePhotoPath,
    required final String questionTitleData,
    required final String questionTextData,
    required final String? teacherProfilePhotoPath,
    required final String? answerTitleData,
    required final String? answerTextData,
  })  : _questionId = questionId,
        _studentProfilePhotoPath = studentProfilePhotoPath,
        _questionTitleData = questionTitleData,
        _questionTextData = questionTextData,
        _teacherProfilePhotoPath = teacherProfilePhotoPath,
        _answerTitleData = answerTitleData,
        _answerTextData = answerTextData;
}
