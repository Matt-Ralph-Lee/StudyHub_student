import '../../teacher/models/teacher_id.dart';
import '../exception/question_domain_exception.dart';
import '../exception/question_domain_exception_detail.dart';

class SelectedTeacherList extends Iterable<TeacherId> {
  static const maxLength = 5;
  final List<TeacherId> _selectedTeacherList;

  List<TeacherId> get selectedTeacherList => _selectedTeacherList;

  SelectedTeacherList(final List<TeacherId> selectedTeacherList)
      : _selectedTeacherList = selectedTeacherList {
    if (selectedTeacherList.length > maxLength) {
      throw const QuestionDomainException(
          QuestionDomainExceptionDetail.invalidTeacherLength);
    }
  }

  @override
  Iterator<TeacherId> get iterator => _selectedTeacherList.iterator;
}
