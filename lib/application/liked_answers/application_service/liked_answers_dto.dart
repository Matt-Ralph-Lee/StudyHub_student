import '../../../domain/answer_list/models/answer_id.dart';

class LikedAnswersDto {
  final Set<AnswerId> _value;

  Set<AnswerId> get value => _value;

  LikedAnswersDto(this._value);
}
