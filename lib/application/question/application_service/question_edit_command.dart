class QuestionEditCommand {
  final String _questionId;
  final String? _questionTitleData;
  final String? _questionTextData;
  final List<String>? _localPathList;

  String get questionId => _questionId;
  String? get questionTitleData => _questionTitleData;
  String? get questionTextData => _questionTextData;
  List<String>? get localPathList => _localPathList;

  QuestionEditCommand({
    required String questionId,
    required String? questionTitleData,
    required String? questionTextData,
    required List<String>? localPathList,
  })  : _questionId = questionId,
        _questionTitleData = questionTitleData,
        _questionTextData = questionTextData,
        _localPathList = localPathList;
}
