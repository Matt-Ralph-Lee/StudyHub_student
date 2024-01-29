class QuestionEditCommand {
  final String _questionId;
  final String? _questionTitleData;
  final String? _questionTextData;
  final List<String>? _localPathList;
  final List<String>? _selectedTeacherList;

  String get questionId => _questionId;
  String? get questionTitleData => _questionTitleData;
  String? get questionTextData => _questionTextData;
  List<String>? get localPathList => _localPathList;
  List<String>? get selectedTeacherList => _selectedTeacherList;

  QuestionEditCommand({
    required String questionId,
    required String? questionTitleData,
    required String? questionTextData,
    required List<String>? localPathList,
    required List<String>? selectedTeacherList,
  })  : _questionId = questionId,
        _questionTitleData = questionTitleData,
        _questionTextData = questionTextData,
        _localPathList = localPathList,
        _selectedTeacherList = selectedTeacherList;
}
