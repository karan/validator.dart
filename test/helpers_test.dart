library helpers_test;

import 'package:unittest/unittest.dart';
import 'package:validator/src/helpers.dart';

void testMerge() {
  var default_url_options = {
    'protocols': [ 'http', 'https', 'ftp' ],
    'require_tld': true,
    'require_protocol': false,
    'allow_underscores': false
  };

  group('Test merge', () {
    test('empty maps', () => expect(merge(new Map(), new Map()), {}));
    test('obj empty', () => expect(merge(new Map(), default_url_options),
                                   default_url_options));
    test('equal maps', () => expect(merge(default_url_options,
                                          default_url_options),
                                    default_url_options));
    test('missing values', () => expect(merge({'require_tld': true},
                                              default_url_options),
                                        default_url_options));
  });
}

void main() {
  testMerge();
}
