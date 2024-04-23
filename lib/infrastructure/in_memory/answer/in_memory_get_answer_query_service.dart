import '../../../application/answer/application_service/answer_dto.dart';
import '../../../application/answer/application_service/i_get_answer_query_service.dart';
import '../../../application/shared/session/session.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../blockings/in_memory_blockings_repository.dart';
import '../favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../liked_answers/in_memory_liked_answers_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';
import 'in_memory_answer_repository.dart';

class InMemoryGetAnswerQueryService implements IGetAnswerQueryService {
  final Session _session;
  final InMemoryAnswerRepository _repository;
  final InMemoryTeacherRepository _teacherRepository;
  final InMemoryFavoriteTeachersRepository _favoriteTeachersRepository;
  final InMemoryLikedAnswersRepository _likedAnswersRepository;
  final InMemoryBlockingsRepository _blockingsRepository;

  InMemoryGetAnswerQueryService({
    required final Session session,
    required final InMemoryAnswerRepository repository,
    required final InMemoryTeacherRepository teacherRepository,
    required final InMemoryFavoriteTeachersRepository
        favoriteTeachersRepository,
    required final InMemoryLikedAnswersRepository likedAnswersRepository,
    required final InMemoryBlockingsRepository blockingsRepository,
  })  : _session = session,
        _repository = repository,
        _teacherRepository = teacherRepository,
        _favoriteTeachersRepository = favoriteTeachersRepository,
        _likedAnswersRepository = likedAnswersRepository,
        _blockingsRepository = blockingsRepository;

  @override
  Future<List<AnswerDto>> getById(QuestionId questionId) async {
    final answerDtoList = <AnswerDto>[];

    final result = await _repository.getByQuestionId(questionId);

    final studentId = _session.studentId;

    final likedAnswers =
        await _likedAnswersRepository.getByStudentId(studentId);

    for (final answer in result) {
      final teacher = await _teacherRepository.getByTeacherId(answer.teacherId);

      if (teacher == null) {
        answerDtoList.add(
          AnswerDto(
            answerId: answer.answerId,
            questionId: answer.questionId,
            teacherId: TeacherId("999999999999999999999999999"), // default id
            teacherName: "teacher name", // default teacher name
            teacherProfilePath:
                "/assets/photos/profile_photo/sample_user_icon.jpg", // default user icon
            answerText: answer.answerText.value,
            answerLike: answer.like.value,
            isFollowing: false,
            isBlocking: false,
            isEvaluated: answer.evaluated,
            answerPhotoList: answer.answerPhotoPathList
                .map((answerPhotoPath) => answerPhotoPath.value)
                .toList(),
            hasLiked: likedAnswers.contains(answer.answerId),
          ),
        );
      } else {
        final favoriteTeachers =
            await _favoriteTeachersRepository.getByStudentId(studentId);
        bool isFollowing = false;
        if (favoriteTeachers != null) {
          if (favoriteTeachers.contains(teacher.teacherId)) {
            isFollowing = true;
          }
        }

        final isBlocking = await _blockingsRepository.checkTeacherIsBlocking(
            studentId: studentId, teacherId: teacher.teacherId);

        answerDtoList.add(AnswerDto(
          answerId: answer.answerId,
          questionId: answer.questionId,
          teacherId: teacher.teacherId,
          teacherName: teacher.name.value,
          teacherProfilePath: teacher.profilePhotoPath.value,
          answerText: answer.answerText.value,
          answerLike: answer.like.value,
          isFollowing: isFollowing,
          isBlocking: isBlocking,
          isEvaluated: answer.evaluated,
          answerPhotoList: answer.answerPhotoPathList
              .map((answerPhotoPath) => answerPhotoPath.value)
              .toList(),
          hasLiked: likedAnswers.contains(answer.answerId),
        ));
      }
    }

    return answerDtoList;
  }
}
