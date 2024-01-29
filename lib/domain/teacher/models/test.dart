import 'package:flutter/foundation.dart';

class Test {
  final String _test;

  Test(this._test);
}

class Test2 extends Test {
  final String _test2;

  Test2({required final String test1, required final String test2})
      : _test2 = test2,
        super(test1);
}

void main(List<String> args) {
  final x = Test2(test1: 'aaa', test2: 'bbb');
  debugPrint(x.test);
  debugPrint(x.test2);
}
