import '../../../application/answer/application_service/answer_dto.dart';
import '../../../application/answer/application_service/i_get_answer_query_service.dart';
import '../../../application/shared/session/session.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../favorite_teachers/firebase_favorite_teachers_repository.dart';
import '../liked_answers/firebase_liked_answers_repository.dart';
import '../teacher/firebase_teacher_repository.dart';
import 'firebase_answer_repository.dart';

class FirebaseGetAnswerQueryService implements IGetAnswerQueryService {
  final Session _session;
  final FirebaseAnswerRepository _repository;
  final FirebaseTeacherRepository _teacherRepository;
  final FirebaseFavoriteTeachersRepository _favoriteTeachersRepository;
  final FirebaseLikedAnswersRepository _likedAnswersRepository;

  FirebaseGetAnswerQueryService({
    required final Session session,
    required final FirebaseAnswerRepository repository,
    required final FirebaseTeacherRepository teacherRepository,
    required final FirebaseFavoriteTeachersRepository
        favoriteTeachersRepository,
    required final FirebaseLikedAnswersRepository likedAnswersRepository,
  })  : _session = session,
        _repository = repository,
        _teacherRepository = teacherRepository,
        _favoriteTeachersRepository = favoriteTeachersRepository,
        _likedAnswersRepository = likedAnswersRepository;
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
                "https://firebasestorage.googleapis.com/v0/b/study-hub-b81c1.appspot.com/o/profile_photo%2Fdefault%2Fmale_default.jpg?alt=media&token=5ad0aaa2-ac51-480a-ba83-3ba847d81c90", // default user icon
            answerText: answer.answerText.value,
            answerLike: answer.like.value,
            isFollowing: false,
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
        final isFollowing = favoriteTeachers != null &&
            favoriteTeachers.contains(teacher.teacherId);
        answerDtoList.add(AnswerDto(
          answerId: answer.answerId,
          questionId: answer.questionId,
          teacherId: teacher.teacherId,
          teacherName: teacher.name.value,
          teacherProfilePath: teacher.profilePhotoPath.value,
          answerText: answer.answerText.value,
          answerLike: answer.like.value,
          isFollowing: isFollowing,
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
