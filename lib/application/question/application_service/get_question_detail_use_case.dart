import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/models/i_student_repository.dart';
import 'i_get_question_detail_query_service.dart';
import 'question_detail_dto.dart';

class GetQuestionDetailUseCase {
  final IGetQuestionDetailQueryService _queryService;
  final IStudentRepository _studentRepository;

  GetQuestionDetailUseCase({
    required final IGetQuestionDetailQueryService queryService,
    required final IStudentRepository studentRepository,
  })  : _queryService = queryService,
        _studentRepository = studentRepository;
  QuestionDetailDto execute(final QuestionId questionId) {
    final question = _queryService.getByQuestionId(questionId);
    final student = _studentRepository.findById(question.studentId);
    if (student == null) {
      return QuestionDetailDto(
          questionId: question.questionId,
          studentProfilePhotoPath: "/assets/images/sample_user_icon.jpg",
          questionTitle: question.questionTitle.value,
          questionText: question.questionText.value,
          questionPhotoPathList: question.questionPhotoPathList
              .map((photoPath) => photoPath.value)
              .toList());
    }

    return QuestionDetailDto(
        questionId: question.questionId,
        studentProfilePhotoPath: student.profilePhotoPath.value,
        questionTitle: question.questionTitle.value,
        questionText: question.questionText.value,
        questionPhotoPathList: question.questionPhotoPathList
            .map((photoPath) => photoPath.value)
            .toList());
  }
}
