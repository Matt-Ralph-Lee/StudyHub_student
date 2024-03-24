import '../../../domain/question/models/question_id.dart';

class QuestionDetailDto {
  final QuestionId _questionId;
  final String _studentProfilePhotoPath;
  final String _questionTitle;
  final String _questionText;
  final List<String> _questionPhotoPathList;

  QuestionId get questionId => _questionId;
  String get studentProfilePhotoPath => _studentProfilePhotoPath;
  String get questionTitle => _questionTitle;
  String get questionText => _questionText;
  List<String> get questionPhotoPathList => _questionPhotoPathList;

  QuestionDetailDto({
    required final QuestionId questionId,
    required final String studentProfilePhotoPath,
    required final String questionTitle,
    required final String questionText,
    required final List<String> questionPhotoPathList,
  })  : _questionId = questionId,
        _studentProfilePhotoPath = studentProfilePhotoPath,
        _questionTitle = questionTitle,
        _questionText = questionText,
        _questionPhotoPathList = questionPhotoPathList;
}
