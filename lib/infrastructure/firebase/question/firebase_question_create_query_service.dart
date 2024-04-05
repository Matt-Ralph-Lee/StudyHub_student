import '../../../application/question/application_service/i_question_create_query_service.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/student_id.dart';
import '../../exceptions/question/question_infrastructure_exception.dart';
import '../../exceptions/question/question_infrastructure_exception_detail.dart';
import '../student/firebase_student_repository.dart';

class FirebaseQuestionCreateQueryService
    implements IQuestionCreateQueryService {
  final FirebaseStudentRepository _repository;

  FirebaseQuestionCreateQueryService(this._repository);

  @override
  Future<ProfilePhotoPath> getProfilePhotoPath(StudentId studentId) async {
    final student = await _repository.findById(studentId);
    if (student == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.studentNotFound);
    }
    return student.profilePhotoPath;
  }
}
