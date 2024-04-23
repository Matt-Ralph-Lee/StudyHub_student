import '../../answer_list/models/answer_id.dart';

class LikedAnswers extends Iterable {
  final Set<AnswerId> _value;

  Set<AnswerId> get value => _value;

  LikedAnswers(this._value);

  @override
  Iterator get iterator => _value.iterator;
}
