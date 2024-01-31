import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

import '../../teacher/models/teacher_id.dart';

class SelectedTeacherList {
  static const maxLength = 5;
  final List<TeacherId> _selectedTeacherList;

  List<TeacherId> get selectedTeacherList => _selectedTeacherList;

  SelectedTeacherList({required final List<TeacherId> selectedTeacherList})
      : _selectedTeacherList = selectedTeacherList {
    if (selectedTeacherList.length > maxLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidTeacherLength);
    }
  }
}
