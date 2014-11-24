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
  group('Test contains', () {
    test('empty strings', () => expect(v.contains('', ''), true));
    test('first empty string', () => expect(v.contains('', 'hello'), false));
    test('second empty string', () => expect(v.contains('hello', ''), true));
    test('contains string', () => expect(v.contains('hello', 'ello'), true));
    test('case sensitive', () => expect(v.contains('Hello', 'he'), false));
  });
}

void testIsEmail() {
  group('Test isEmail', () {
    test('valid email', () => expect(v.isEmail('foo@bar.com'), true));
    test('valid email', () => expect(v.isEmail('x@x.x'), true));
    test('valid email', () => expect(v.isEmail('foo@bar.com.au'), true));
    test('valid email', () => expect(v.isEmail('foo+bar@bar.com'), true));
    test('valid email', () => expect(v.isEmail('hans.m端ller@test.com'), true));
    test('valid email', () => expect(v.isEmail('test|123@m端ller.com'), true));
    test('weird valid email', () => expect(v.isEmail('some.name.midd.leNa.me.+extension@GoogleMail.com'), true));

    test('invalid email', () => expect(v.isEmail('invalidemail@'), false));
    test('invalid email', () => expect(v.isEmail('invalid.com'), false));
    test('invalid email', () => expect(v.isEmail('@invalid.com'), false));
    test('invalid email', () => expect(v.isEmail('foo@bar.com.'), false));
    test('invalid email', () => expect(v.isEmail('foo@bar.co.uk.'), false));
  });
}

void main() {
  testEquals();
  testContains();
  testIsEmail();
}
