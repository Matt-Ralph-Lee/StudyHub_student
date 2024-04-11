import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/default/default_student.dart';
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
  Future<QuestionDetailDto> execute(final QuestionId questionId) async {
    final question = await _queryService.getByQuestionId(questionId);
    final student = await _studentRepository.findById(question.studentId);
    if (student == null) {
      return QuestionDetailDto(
          questionId: question.questionId,
          studentProfilePhotoPath: DefaultStudent.profilePhoto,
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
