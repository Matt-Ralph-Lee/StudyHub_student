import '../../../application/question/application_service/i_search_for_questions_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/student/default/default_student.dart';
import '../../../domain/student/models/student.dart';
import '../student/in_memory_student_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';
import '../../exceptions/question/question_infrastructure_exception.dart';
import '../../exceptions/question/question_infrastructure_exception_detail.dart';
import 'in_memory_question_repository.dart';

class InMemorySearchForQuestionsQueryService
    implements ISearchForQuestionsQueryService {
  final InMemoryQuestionRepository _repository;
  final InMemoryStudentRepository _studentRepository;
  final InMemoryTeacherRepository _teacherRepository;

  InMemorySearchForQuestionsQueryService({
    required final InMemoryQuestionRepository repository,
    required final InMemoryStudentRepository studentRepository,
    required final InMemoryTeacherRepository teacherRepository,
  })  : _repository = repository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;

  @override
  Future<List<QuestionCardDto>> search({
    required final String searchWord,
    required final Subject? subject,
  }) async {
    final questionCardDtoList = <QuestionCardDto>[];

    final result = _repository.store.values.where((question) {
      bool match = true;
      if (subject != null) {
        match = match && question.questionSubject == subject;
      }
      match = match && question.questionTitle.value.contains(searchWord);

      return match;
    });

    for (final question in result) {
      final dto = await _toDto(question);
      questionCardDtoList.add(dto);
    }

    return questionCardDtoList;
  }

  Future<QuestionCardDto> _toDto(final Question question) async {
    Student? student = await _studentRepository.findById(question.studentId);
    student ??= Student(
      studentId: DefaultStudent.studentId,
      name: DefaultStudent.name,
      profilePhotoPath: DefaultStudent.profilePhoto,
      gender: DefaultStudent.gender,
      occupation: DefaultStudent.occupation,
      school: DefaultStudent.school,
      gradeOrGraduateStatus: DefaultStudent.gradeOrGraduateStatus,
      questionCount: DefaultStudent.questionCount,
      status: DefaultStudent.status,
      emailAddress: DefaultStudent.emailAddress,
    );

    final mostLikedAnswer = question.getMostLikedAnswer();
    if (mostLikedAnswer == null) {
      return QuestionCardDto(
        questionId: question.questionId,
        studentProfilePhotoPath: student.profilePhotoPath.value,
        questionTitle: question.questionTitle.value,
        questionText: question.questionText.value,
        teacherProfilePhotoPath: null,
        answerText: null,
        isMine: question.studentId == student.studentId,
      );
    }

    final teacher =
        await _teacherRepository.getByTeacherId(mostLikedAnswer.teacherId);
    if (teacher == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.teacherNotFound);
    }
    return QuestionCardDto(
      questionId: question.questionId,
      studentProfilePhotoPath: student.profilePhotoPath.value,
      questionTitle: question.questionTitle.value,
      questionText: question.questionText.value,
      teacherProfilePhotoPath: teacher.profilePhotoPath.value,
      answerText: mostLikedAnswer.answerText.value,
      isMine: question.studentId == student.studentId,
    );
  }
}
