import '../../../application/question/application_service/i_question_create_query_service.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/student_id.dart';
import '../student/in_memory_student_repository.dart';
import 'exception/question_infrastructure_exception.dart';
import 'exception/question_infrastructure_exception_detail.dart';

class InMemoryQuestionCreateQueryService
    implements IQuestionCreateQueryService {
  final InMemoryStudentRepository _repository;

  InMemoryQuestionCreateQueryService({
    required final InMemoryStudentRepository repository,
  }) : _repository = repository;

  @override
  Future<ProfilePhotoPath> getProfilePhotoPath(
      final StudentId studentId) async {
    final student = _repository.findById(studentId);
    if (student == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.studentNotFound);
    }
    return student.profilePhotoPath;
  }
}
