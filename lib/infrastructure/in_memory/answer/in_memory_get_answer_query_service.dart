import '../../../application/answer/application_service/answer_dto.dart';
import '../../../application/answer/application_service/i_get_answer_query_service.dart';
import '../../../application/shared/session/session.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';
import 'in_memory_answer_repository.dart';

class InMemoryGetAnswerQueryService implements IGetAnswerQueryService {
  final Session _session;
  final InMemoryAnswerRepository _repository;
  final InMemoryTeacherRepository _teacherRepository;
  final InMemoryFavoriteTeachersRepository _favoriteTeachersRepository;

  InMemoryGetAnswerQueryService({
    required final Session session,
    required final InMemoryAnswerRepository repository,
    required final InMemoryTeacherRepository teacherRepository,
    required final InMemoryFavoriteTeachersRepository
        favoriteTeachersRepository,
  })  : _session = session,
        _repository = repository,
        _teacherRepository = teacherRepository,
        _favoriteTeachersRepository = favoriteTeachersRepository;

  @override
  List<AnswerDto> getById(QuestionId questionId) {
    final answerDtoList = <AnswerDto>[];

    final result = _repository.getByQuestionId(questionId);

    for (final answer in result) {
      final studentId = _session.studentId;
      final teacher = _teacherRepository.getByTeacherId(answer.teacherId);

      if (teacher == null) {
        answerDtoList.add(AnswerDto(
            answerId: answer.answerId,
            teacherId: TeacherId("999999999999999999999999999"), // default id
            teacherName: "teacher name", // default teacher name
            teacherProfilePath:
                "/assets/images/sample_user_icon.jpg", // default user icon
            answerText: answer.answerText.value,
            answerLike: answer.like.value,
            isFollowing: false));
      } else {
        final favoriteTeachers =
            _favoriteTeachersRepository.getByStudentId(studentId);
        bool isFollowing = false;
        if (favoriteTeachers != null) {
          if (favoriteTeachers.contains(teacher.teacherId)) {
            isFollowing = true;
          }
        }
        answerDtoList.add(AnswerDto(
            answerId: answer.answerId,
            teacherId: teacher.teacherId,
            teacherName: teacher.name.value,
            teacherProfilePath: teacher.profilePhotoPath.value,
            answerText: answer.answerText.value,
            answerLike: answer.like.value,
            isFollowing: isFollowing));
      }
    }

    return answerDtoList;
  }
}
