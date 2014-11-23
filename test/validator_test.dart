library validator_test;

import 'package:unittest/unittest.dart';
import 'package:validator/validator.dart' as v;

void testEquals() {
  group('Test equals', () {
    test('empty strings', () => expect(v.equals('', ''), true));
    test('first empty string', () => expect(v.equals('', 'hello'), false));
    test('second empty string', () => expect(v.equals('hello', ''), false));
    test('equal strings', () => expect(v.equals('hello', 'hello'), true));
    test('case sensitive', () => expect(v.equals('hello', 'Hello'), false));
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
