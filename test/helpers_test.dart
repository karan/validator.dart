library helpers_test;

import 'package:unittest/unittest.dart';
import 'package:validator/validator.dart' as v;

void testShift() {
  group('Test shift', () {
    test('full list', () {
      var l = [1, 2, 3, 4];
      var f = v._shift(l);
      expect(f, equals(1));
      expect(l, equals([2, 3, 4]));
    });
    test('empty list', () => expect(v._shift([]), null));
  });
}

void testMerge() {
  var default_url_options = {
    'protocols': [ 'http', 'https', 'ftp' ],
    'require_tld': true,
    'require_protocol': false,
    'allow_underscores': false
  };

  group('Test merge', () {
    test('empty maps', () => expect(v._merge(new Map(), new Map()), {}));
    test('obj empty', () => expect(v._merge(new Map(), default_url_options),
                                   default_url_options));
    test('equal maps', () => expect(v._merge(default_url_options,
                                          default_url_options),
                                    default_url_options));
    test('missing values', () => expect(v._merge({'require_tld': true},
                                              default_url_options),
                                        default_url_options));
  });
}

void main() {
  testShift();
  testMerge();
}
