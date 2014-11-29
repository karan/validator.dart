library sanitizer_dart;

import 'package:validator/validator.dart' as s;


void test(Map options) {
  List args = options['args'];

  options['expect'].keys.forEach((input) {
    args.insert(0, input);

    var f = options["sanitizer"].toString();
    var result = Function.apply(options['sanitizer'], args);
    var expected = options['expect'][input];

    if ((expected is double || expected is int) && expected.isNaN == true && result.isNaN == true) {
      return true;
    }

    if (result != expected) {
      throw new Exception('sanitizer.$f($args) failed but should have passed');
    }
    args.removeAt(0);
  });
}


void testToString() {
  test({
    'sanitizer': s.toString,
    'args': [],
    'expect': {
      1: '1',
      1.5: '1.5',
      {1: 2}: '{1: 2}',
      null: ''
    }
  });
}


void testToDate() {
  test({
    'sanitizer': s.toDate,
    'args': [],
    'expect': {
      '2012-02-27 13:27:00': DateTime.parse('2012-02-27 13:27:00'),
      'abc': null
    }
  });
}


void testToFloat() {
  test({
    'sanitizer': s.toFloat,
    'args': [],
    'expect': {
      '1': 1.0,
      '2.': 2.0,
      '-1.4': -1.4,
      'foo': double.NAN
    }
  });
}


void testToInt() {
  test({
    'sanitizer': s.toInt,
    'args': [],
    'expect': {
      '1.4': 1,
      '2.': 2,
      'foo': double.NAN
    }
  });
}


void main() {
  testToString();
  testToDate();
  testToFloat();
  testToInt();

  print('-------------------------------------');
  print('All tests in sanitizer.dart complete.');
  print('-------------------------------------');
}