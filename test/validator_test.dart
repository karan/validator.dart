library validator_test;

import 'package:asynchronous_validator/asynchronous_validator.dart' as v;


void test(Map options) {
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
  test({
    'validator': v.equals,
    'valid': ['abc'],
    'invalid': ['Abc', '123'],
    'args': ['abc']
  });
}


void testContains() {
  test({
    'validator': v.contains,
    'args': ['foo'],
    'valid': ['foo', 'foobar', 'bazfoo'],
    'invalid': ['Foo', 'bar', '']
  });
}


void testMatches() {
  test({
    'validator': v.matches,
    'args': ['abc'],
    'valid': [
      'abc',
      'abcdef',
      '123abc'
      ],
    'invalid': [
      'acb',
      'ABC'
      ]
  });
}


void testIsEmail() {
  test({
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


void testIsURL() {
  test({
    'validator': v.isURL,
    'args': [],
    'valid': [
      'foobar.com',
      'www.foobar.com',
      'foobar.com/',
      'valid.au',
      'http://www.foobar.com/',
      'http://www.foobar.com:23/',
      'http://www.foobar.com:65535/',
      'http://www.foobar.com:5/',
      'https://www.foobar.com/',
      'ftp://www.foobar.com/',
      'http://www.foobar.com/~foobar',
      'http://user:pass@www.foobar.com/',
      'http://127.0.0.1/',
      'http://10.0.0.0/',
      'http://189.123.14.13/',
      'http://duckduckgo.com/?q=%2F',
      'http://foobar.com/t\$-_.+!*\'(),',
      'http://localhost:3000/',
      'http://foobar.com/?foo=bar#baz=qux',
      'http://foobar.com?foo=bar',
      'http://foobar.com#baz=qux',
      'http://www.xn--froschgrn-x9a.net/',
      'http://xn--froschgrn-x9a.com/',
      'http://foo--bar.com'
      ],
    'invalid': [
      'xyz://foobar.com',
      'invalid/',
      'invalid.x',
      'invalid.',
      '.com',
      'http://com/',
      'http://300.0.0.1/',
      'mailto:foo@bar.com',
      'rtmp://foobar.com',
      'http://www.xn--.com/',
      'http://xn--.com/',
      'http://www.foobar.com:0/',
      'http://www.foobar.com:70000/',
      'http://www.foobar.com:99999/',
      'http://www.-foobar.com/',
      'http://www.foobar-.com/',
      'http://www.foo---bar.com/',
      'http://www.foo_bar.com/',
      '',
      'http://foobar.com/' + new List(2083).join('f'),
      'http://*.foo.com',
      '*.foo.com',
      '!.foo.com',
      'http://localhost:61500this is an invalid url!!!!'
      ]
  });
}


void testIsIP() {
  test({
    'validator': v.isIP,
    'args': [],
    'valid': [
      '127.0.0.1',
      '0.0.0.0',
      '255.255.255.255',
      '1.2.3.4',
      '::1',
      '2001:db8:0000:1:1:1:1:1'
      ],
    'invalid': [
      'abc',
      '256.0.0.0',
      '0.0.0.256',
      '26.0.0.256'
      ]
  });
}


void testIsAlpha() {
  test({
    'validator': v.isAlpha,
    'args': [],
    'valid': [
      'abc',
      'ABC',
      'FoObAr'
      ],
    'invalid': [
      'abc1',
      'AB  C',
      ''
      ],
  });
}


void testIsAlphanumeric() {
  test({
    'validator': v.isAlphanumeric,
    'args': [],
    'valid': [
      'abc1',
      '0A1BC',
      'Fo0bAr'
      ],
    'invalid': [
      'abc!',
      'AB C',
      ''
      ],
  });
}

void testIsNumeric() {
  test({
    'validator': v.isNumeric,
    'args': [],
    'valid': [
      '-1',
      '0',
      '00',
      '01',
      '19934',
      '-23412'
      ],
    'invalid': [
      'abc!',
      'AB C',
      ''
      ],
  });
}


void testIsBase64() {
  test({
    'validator': v.isBase64,
    'args': [],
    'valid': [
      'TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4=',
      'Vml2YW11cyBmZXJtZW50dW0gc2VtcGVyIHBvcnRhLg==',
      'U3VzcGVuZGlzc2UgbGVjdHVzIGxlbw==',
      'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuMPNS1Ufof9EW/M98FNw'+
      'UAKrwflsqVxaxQjBQnHQmiI7Vac40t8x7pIb8gLGV6wL7sBTJiPovJ0V7y7oc0Ye'+
      'rhKh0Rm4skP2z/jHwwZICgGzBvA0rH8xlhUiTvcwDCJ0kc+fh35hNt8srZQM4619'+
      'FTgB66Xmp4EtVyhpQV+t02g6NzK72oZI0vnAvqhpkxLeLiMCyrI416wHm5Tkukhx'+
      'QmcL2a6hNOyu0ixX/x2kSFXApEnVrJ+/IxGyfyw8kf4N2IZpW5nEP847lpfj0SZZ'+
      'Fwrd1mnfnDbYohX2zRptLy2ZUn06Qo9pkG5ntvFEPo9bfZeULtjYzIl6K8gJ2uGZ'+
      'HQIDAQAB'
      ],
    'invalid': [
      'abc!',
      'AB C',
      'Vml2YW11cyBmZXJtZtesting123',
      ''
      ],
  });
}


void testIsInt() {
  test({
    'validator': v.isInt,
    'args': [],
    'valid': [
      '-1',
      '0',
      '10',
      '23423',
      '19934',
      '-23412'
      ],
    'invalid': [
      '-01',
      '000',
      '12.13',
      'AB',
      ''
      ],
  });
}


void testIsFloat() {
  test({
    'validator': v.isFloat,
    'args': [],
    'valid': [
      '-1.324',
      '0.32',
      '-0.324',
      '-2423.234234',
      '-0.22250738585072011e-307',
      '0.22250738585072011e-307'
      ],
    'invalid': [
      'abc!',
      'AB C',
      ' '
      ],
  });
}


void testIsHexadecimal() {
  test({
    'validator': v.isHexadecimal,
    'args': [],
    'valid': [
      'deadBEEF',
      'ff0044'
      ],
    'invalid': [
      'abcdefg',
      ' ',
      '..'
      ],
  });
}


void testIsHexColor() {
  test({
    'validator': v.isHexColor,
    'args': [],
    'valid': [
      '#ff0034',
      '#CCCCCC',
      'fff',
      '#f00'
      ],
    'invalid': [
      '#ff',
      'fff0',
      '#ff12FG'
      ],
  });
}


void testIsLowercase() {
  test({
    'validator': v.isLowercase,
    'args': [],
    'valid': [
      'abc',
      'abc123',
      'l.o.w.e.r.',
      'tr竪s 端ber'
      ],
    'invalid': [
      'f00Bar',
      'uUu'
      ],
  });
}


void testIsUppercase() {
  test({
    'validator': v.isUppercase,
    'args': [],
    'valid': [
      'ABC',
      'ABC123',
      'U.P.P.E.R.'
      ],
    'invalid': [
      'f00Bar',
      'uUu'
      ],
  });
}


void testIsDivisibleBy() {
  test({
    'validator': v.isDivisibleBy,
    'args': ['2'],
    'valid': [
      '2',
      '4',
      '100',
      '-10'
      ],
    'invalid': [
      '1',
      '-1',
      'abc'
      ]
  });
}


void testIsNull() {
  test({
    'validator': v.isNull,
    'args': [],
    'valid': [
      null,
      '',
      ],
    'invalid': [
      ' ',
      'foo'
    ]
  });
}


void testIsLength() {
  test({
    'validator': v.isLength,
    'args': [2],
    'valid': [
      'ab',
      'de',
      'abcd',
      '干𩸽'
      ],
    'invalid': [
      '',
      'a',
      '𠀋'
    ]
  });

  test({
    'validator': v.isLength,
    'args': [2, 3],
    'valid': [
      'abc',
      'de',
      '干𩸽'
      ],
    'invalid': [
      '',
      '𠀋',
      '千竈通り'
    ]
  });
}


void testIsByteLength() {
  test({
    'validator': v.isByteLength,
    'args': [2],
    'valid': [
      'abc',
      'de'
      ],
    'invalid': [
      '',
      ' '
    ]
  });

  test({
    'validator': v.isByteLength,
    'args': [2, 3],
    'valid': [
      'abc',
      'de',
      '干𩸽'
      ],
    'invalid': [
      '',
      'abcdef'
    ]
  });
}


void testIsUUID() {
  test({
    'validator': v.isUUID,
    'args': [],
    'valid': [
      'A987FBC9-4BED-3078-CF07-9141BA07C9F3',
      'A987FBC9-4BED-4078-8F07-9141BA07C9F3',
      'A987FBC9-4BED-5078-AF07-9141BA07C9F3'
      ],
    'invalid': [
      '',
      'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
      'A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx',
      'A987FBC94BED3078CF079141BA07C9F3',
      '934859',
      '987FBC9-4BED-3078-CF07A-9141BA07C9F3',
      'AAAAAAAA-1111-1111-AAAG-111111111111'
    ]
  });

  test({
    'validator': v.isUUID,
    'args': [3],
    'valid': [
      'A987FBC9-4BED-3078-CF07-9141BA07C9F3'
      ],
    'invalid': [
      '',
      'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
      'A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx',
      'A987FBC94BED3078CF079141BA07C9F3',
      '934859',
      '987FBC9-4BED-3078-CF07A-9141BA07C9F3',
      'AAAAAAAA-1111-1111-AAAG-111111111111'
    ]
  });

  test({
    'validator': v.isUUID,
    'args': [4],
    'valid': [
      '713ae7e3-cb32-45f9-adcb-7c4fa86b90c1',
      '625e63f3-58f5-40b7-83a1-a72ad31acffb',
      '57b73598-8764-4ad0-a76a-679bb6640eb1'
      ],
    'invalid': [
      '',
      'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
      'A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx',
      'A987FBC94BED3078CF079141BA07C9F3',
      '934859',
      '987FBC9-4BED-3078-CF07A-9141BA07C9F3',
      'AAAAAAAA-1111-1111-AAAG-111111111111'
    ]
  });

  test({
    'validator': v.isUUID,
    'args': [5],
    'valid': [
      '987FBC97-4BED-5078-AF07-9141BA07C9F3',
      '987FBC97-4BED-5078-BF07-9141BA07C9F3',
      '987FBC97-4BED-5078-8F07-9141BA07C9F3'
      ],
    'invalid': [
      '',
      'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
      'A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx',
      'A987FBC94BED3078CF079141BA07C9F3',
      '934859',
      '987FBC9-4BED-3078-CF07A-9141BA07C9F3',
      'AAAAAAAA-1111-1111-AAAG-111111111111'
    ]
  });
}


void testIsDate() {
  test({
    'validator': v.isDate,
    'args': [],
    'valid': [
      '2012-02-27 13:27:00',
      '2012-02-27',
      '2011-08-04 12:00',
      '2012-02-27 13:27:00.123456z',
      '20120227',
      '2002-02-27T14:00:00-0500',
      '2002-02-27T19:00:00Z'
      ],
    'invalid': [
      '',
      'aaaafff',
      'ABC'
    ]
  });
}


void testIsAfter() {
  test({
    'validator': v.isAfter,
    'args': ['2005-12-12'],
    'valid': [
      '2012-12-12',
      '2012-02-27 13:27:00',
      '2022-02-27T14:00:00-0500'
      ],
    'invalid': [
      '2002-12-12',
      '2002-02-27 13:27:00',
      '2002-02-27T14:00:00-0500',
      ' ',
      ''
      ]
  });

  test({
    'validator': v.isAfter,
    'args': [],
    'valid': [
      '2022-12-12',
      '2022-02-27 13:27:00',
      '2022-02-27T14:00:00-0500'
      ],
    'invalid': [
      '2002-12-12',
      '2002-02-27 13:27:00',
      '2002-02-27T14:00:00-0500',
      ' ',
      ''
      ]
  });
}


void testIsBefore() {
  test({
    'validator': v.isBefore,
    'args': ['2005-12-12'],
    'valid': [
      '2002-12-12',
      '2002-02-27 13:27:00',
      '2002-02-27T14:00:00-0500'
      ],
    'invalid': [
      '2012-12-12',
      '2012-02-27 13:27:00',
      '2022-02-27T14:00:00-0500',
      ' ',
      ''
      ]
  });

  test({
    'validator': v.isBefore,
    'args': [],
    'valid': [
      '2002-12-12',
      '2002-02-27 13:27:00',
      '2002-02-27T14:00:00-0500'
      ],
    'invalid': [
      '2022-12-12',
      '2022-02-27 13:27:00',
      '2022-02-27T14:00:00-0500',
      ' ',
      ''
      ]
  });
}


void testIsIn() {
  test({
    'validator': v.isIn,
    'args': ['foobar'],
    'valid': ['foo', 'bar', 'oba', 'foobar', ''],
    'invalid': ['1', ' ']
  });

  test({
    'validator': v.isIn,
    'args': [[1, 2, 3]],
    'valid': ['1', '2', '3'],
    'invalid': ['4', ' ']
  });
}


void testIsCreditCard() {
  test({
    'validator': v.isCreditCard,
    'args': [],
    'valid': [
      '375556917985515',
      '36050234196908',
      '4716461583322103',
      '4716-2210-5188-5662',
      '4929 7226 5379 7141',
      '5398228707871527'
      ],
    'invalid': [
      '5398228707871528',
      '',
      'Lol0'
      ]
  });
}


void testIsISBN() {
  test({
    'validator': v.isISBN,
    'args': [10],
    'valid': [
      '3836221195', '3-8362-2119-5', '3 8362 2119 5',
      '1617290858', '1-61729-085-8', '1 61729 085-8',
      '0007269706', '0-00-726970-6', '0 00 726970 6',
      '3423214120', '3-423-21412-0', '3 423 21412 0',
      '340101319X', '3-401-01319-X', '3 401 01319 X'
      ],
    'invalid': [
      '3423214121', '3-423-21412-1', '3 423 21412 1',
      '978-3836221191', '9783836221191',
      '123456789a',
      'foo',
      ''
      ]
  });

  test({
    'validator': v.isISBN,
    'args': [13],
    'valid': [
      '9783836221191', '978-3-8362-2119-1', '978 3 8362 2119 1',
      '9783401013190', '978-3401013190', '978 3401013190',
      '9784873113685', '978-4-87311-368-5', '978 4 87311 368 5'
      ],
    'invalid': [
      '9783836221190', '978-3-8362-2119-0', '978 3 8362 2119 0',
      '3836221195', '3-8362-2119-5', '3 8362 2119 5',
      '01234567890ab',
      'foo',
      ''
      ]
  });

  test({
    'validator': v.isISBN,
    'args': [],
    'valid': [
      '9783836221191', '978-3-8362-2119-1', '978 3 8362 2119 1',
      '9783401013190', '978-3401013190', '978 3401013190',
      '3423214120', '3-423-21412-0', '3 423 21412 0',
      '340101319X', '3-401-01319-X', '3 401 01319 X'
      ],
    'invalid': [
      '3423214121',
      '9783836221190'
      '01234567890ab',
      'foo',
      ''
      ]
  });
}


void testIsJSON() {
  test({
    'validator': v.isJSON,
    'args': [],
    'valid': [
      '{"key": "v"}',
      '{"1": [1, 2, 3]}',
      '[1, 2, 3]'
      ],
    'invalid': [
      'foo',
      '{ key: "value" }',
      '{ \'key\': \'value\' }'
      ]
  });
}


void testIsMultibyte() {
  test({
    'validator': v.isMultibyte,
    'args': [],
    'valid': [
      'ひらがな・カタカナ、．漢字',
      'あいうえお foobar',
      'test＠example.com',
      '1234abcDEｘｙｚ'
      ],
    'invalid': [
      'abc',
      '<>@" *.'
      ]
  });
}


void testIsAscii() {
  test({
    'validator': v.isAscii,
    'args': [],
    'valid': [
      'abc',
      '<>@" *.'
      ],
    'invalid': [
      'ひらがな・カタカナ、．漢字',
      'あいうえお foobar',
      'test＠example.com',
      '1234abcDEｘｙｚ'
      ]
  });
}


void testIsFullWidth() {
  test({
    'validator': v.isFullWidth,
    'args': [],
    'valid': [
      'ひらがな・カタカナ、．漢字',
      '３ー０　ａ＠ｃｏｍ',
      'Ｆｶﾀｶﾅﾞﾬ'
      ],
    'invalid': [
      'abc',
      'abc123',
      ''
      ]
  });
}


void testIsHalfWidth() {
  test({
    'validator': v.isHalfWidth,
    'args': [],
    'valid': [
      'l-btn_02--active',
      'abc123い',
      'ｶﾀｶﾅﾞﾬ￩'
      ],
    'invalid': [
      '００１１',
      'あいうえお',
      ''
      ]
  });
}


void testIsVariableWidth() {
  test({
    'validator': v.isVariableWidth,
    'args': [],
    'valid': [
      'ひらがなカタカナ漢字ABCDE',
      '３ー０123',
      'Ｆｶﾀｶﾅﾞﾬ',
      'Good＝Parts'
      ],
    'invalid': [
      'abc',
      'abc123',
      'ひらがな・カタカナ、．漢字',
      '１２３４５６',
      ''
      ]
  });
}


void testIsSurrogatePairs() {
  test({
    'validator': v.isSurrogatePair,
    'args': [],
    'valid': [
      '𠮷野𠮷',
      '𩸽',
      'ABC千𥧄1-2-3'
      ],
    'invalid': [
      '吉野竈',
      '鮪',
      'ABC1-2-3'
      ]
  });
}


void testIsMongoId() {
  test({
    'validator': v.isMongoId,
    'args': [],
    'valid': [
      '507f1f77bcf86cd799439011'
      ],
    'invalid': [
      '507f1f77bcf86cd7994390',
      '507f1f77bcf86cd7994390z',
      ''
      ]
  });
}


void main() {
  testEquals();
  testContains();
  testMatches();
  testIsEmail();
  testIsURL();
  testIsIP();
  testIsAlpha();
  testIsAlphanumeric();
  testIsNumeric();
  testIsBase64();
  testIsInt();
  testIsFloat();
  testIsHexadecimal();
  testIsHexColor();
  testIsLowercase();
  testIsUppercase();
  testIsDivisibleBy();
  testIsNull();
  testIsLength();
  testIsByteLength();
  testIsUUID();
  testIsDate();
  testIsAfter();
  testIsBefore();
  testIsIn();
  testIsCreditCard();
  testIsISBN();
  testIsJSON();
  testIsMultibyte();
  testIsAscii();
  testIsFullWidth();
  testIsHalfWidth();
  testIsVariableWidth();
  testIsSurrogatePairs();
  testIsMongoId();

  print('-------------------------------------');
  print('All tests in asynchronous_validator.dart complete.');
  print('-------------------------------------');
}
