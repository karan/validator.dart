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


void testToBoolean() {
  test({
    'sanitizer': s.toBoolean,
    'args': [],
    'expect': {
      '0': false,
      '': false,
      '1': true,
      'true': true,
      'foobar': true,
      '   ': true
    }
  });

  test({
    'sanitizer': s.toBoolean,
    'args': [true],
    'expect': {
      '0': false,
      '': false,
      '1': true,
      'true': true,
      'foobar': false,
      '   ': false
    }
  });
}


void testTrim() {
  test({
    'sanitizer': s.trim,
    'args': [],
    'expect': {'  \r\n\tfoo  \r\n\t   ': 'foo'}
  });

  test({
    'sanitizer': s.trim,
    'args': ['01'],
    'expect': {'010100201000': '2'}
  });

  test({
    'sanitizer': s.ltrim,
    'args': [],
    'expect': {'  \r\n\tfoo  \r\n\t   ': 'foo  \r\n\t   '}
  });

  test({
    'sanitizer': s.ltrim,
    'args': ['01'],
    'expect': {'010100201000': '201000'}
  });

  test({
    'sanitizer': s.rtrim,
    'args': [],
    'expect': {'  \r\n\tfoo  \r\n\t   ': '  \r\n\tfoo'}
  });

  test({
    'sanitizer': s.rtrim,
    'args': ['01'],
    'expect': {'010100201000': '0101002'}
  });
}


void main() {
  testToString();
  testToDate();
  testToFloat();
  testToInt();
  testToBoolean();
  testTrim();

  print('-------------------------------------');
  print('All tests in sanitizer.dart complete.');
  print('-------------------------------------');
}