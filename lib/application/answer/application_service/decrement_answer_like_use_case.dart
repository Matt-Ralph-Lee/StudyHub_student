import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/answer_list/models/i_answer_repository.dart';
import '../../../domain/liked_answer/models/i_liked_answers_repository.dart';
import '../../../domain/student/models/student_id.dart';

class DecrementAnswerLikeUseCase {
  final IAnswerRepository _repository;
  final ILikedAnswersRepository _likedAnswersRepository;

  DecrementAnswerLikeUseCase({
    required final IAnswerRepository repository,
    required final ILikedAnswersRepository likedAnswersRepository,
  })  : _repository = repository,
        _likedAnswersRepository = likedAnswersRepository;

  void execute({
    required final AnswerId answerId,
    required final StudentId studentId,
  }) {
    _repository.decrementAnswerLike(answerId);
    _likedAnswersRepository.delete(studentId, answerId);
  }
}