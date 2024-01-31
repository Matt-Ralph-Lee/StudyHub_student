Iterable<List> zip(Iterable iterable1, Iterable iterable2) sync* {
  Iterator iter1 = iterable1.iterator;
  Iterator iter2 = iterable2.iterator;

  while (iter1.moveNext() && iter2.moveNext()) {
    yield [iter1.current, iter2.current];
  }
}
