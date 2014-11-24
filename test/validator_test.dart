library validator_test;

import 'package:unittest/unittest.dart';
import 'package:validator/validator.dart' as v;

void test_this(Map options) {
  List args = options['args'];
  if (options['valid'] != null) {
    List toTest = options['valid'];
    toTest.forEach((v) {
      args.insert(0, v);
      var f = options["validator"].toString();
      if (Function.apply(options['validator'], args) != true) {
        throw new Exception('validator.$f($args) failed but should have passed');
      }
      args.removeAt(0);
    });
  }

  args = options['args'];
  if (options['invalid'] != null) {
    List toTest = options['invalid'];
    toTest.forEach((v) {
      args.insert(0, v);
      var f = options["validator"].toString();
      if (Function.apply(options['validator'], args) != false) {
        throw new Exception('validator.$f($args) passed but should have failed');
      }
      args.removeAt(0);
    });
  }
}

void testEquals() {
  test_this({
    'validator': v.equals,
    'valid': ['abc'],
    'invalid': ['Abc', '123'],
    'args': ['abc']
  });
}

void testContains() {
  test_this({
    'validator': v.contains,
    'args': ['foo'],
    'valid': ['foo', 'foobar', 'bazfoo'],
    'invalid': ['Foo', 'bar', '']
  });
}

void testIsEmail() {
  test_this({
    'validator': v.isEmail,
    'args': [],
    'valid': [
      'foo@bar.com',
      'x@x.x',
      'foo@bar.com.au',
      'foo+bar@bar.com',
      'hans.m端ller@test.com',
      'hans@m端ller.com',
      'test|123@m端ller.com',
      'test+ext@gmail.com',
      'some.name.midd.leNa.me.+extension@GoogleMail.com'
      ],
    'invalid': [
      'invalidemail@',
      'invalid.com',
      '@invalid.com',
      'foo@bar.com.',
      'foo@bar.co.uk.'
      ]
  });
}

void main() {
  testEquals();
  testContains();
  testIsEmail();
  print('All tests complete');
}
