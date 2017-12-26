library validator_test;

import 'package:validator/validator.dart' as v;


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

void testIsMd5() {
  test({
    'validator': v.isMd5,
    'args': [],
    'valid': [
      'd94f3f016ae679c3008de268209132f2',
      '751adbc511ccbe8edf23d486fa4581cd',
      '88dae00e614d8f24cfd5a8b3f8002e93',
      '0bf1c35032a71a14c2f719e5a14c1e96',
      ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
      ]
  });
}

void testIsMd4() {
  test({
    'validator': v.isMd4,
    'args': [],
    'valid': [
      'd94f3f016ae679c3008de268209132f2',
      '751adbc511ccbe8edf23d486fa4581cd',
      '88dae00e614d8f24cfd5a8b3f8002e93',
      '0bf1c35032a71a14c2f719e5a14c1e96',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsRipemd128() {
  test({
    'validator': v.isMd4,
    'args': [],
    'valid': [
      'd94f3f016ae679c3008de268209132f2',
      '751adbc511ccbe8edf23d486fa4581cd',
      '88dae00e614d8f24cfd5a8b3f8002e93',
      '0bf1c35032a71a14c2f719e5a14c1e96',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsTiger128() {
  test({
    'validator': v.isTiger128,
    'args': [],
    'valid': [
      'd94f3f016ae679c3008de268209132f2',
      '751adbc511ccbe8edf23d486fa4581cd',
      '88dae00e614d8f24cfd5a8b3f8002e93',
      '0bf1c35032a71a14c2f719e5a14c1e96',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsCrc32() {
  test({
    'validator': v.isCrc32,
    'args':[],
    'valid': [
      'd94f3f01',
      '751adbc5',
      '88dae00e',
      '0bf1c350',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'q94375dj93458w34',
      'q943',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsCrc32b() {
  test({
    'validator': v.isCrc32b,
    'args': [],
    'valid': [
      'd94f3f01',
      '751adbc5',
      '88dae00e',
      '0bf1c350',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'q94375dj93458w34',
      'q943',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsSha1() {
  test({
    'validator': v.isSha1,
    'args': [],
    'valid': [
      '3ca25ae354e192b26879f651a51d92aa8a34d8d3',
      'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d',
      'beb8c3f30da46be179b8df5f5ecb5e4b10508230',
      'efd5d3b190e893ed317f38da2420d63b7ae0d5ed',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsTiger160() {
  test({
    'validator': v.isTiger160,
    'args': [],
    'valid': [
      '3ca25ae354e192b26879f651a51d92aa8a34d8d3',
      'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d',
      'beb8c3f30da46be179b8df5f5ecb5e4b10508230',
      'efd5d3b190e893ed317f38da2420d63b7ae0d5ed',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsRipemd160() {
  test({
    'validator': v.isRipemd160,
    'args': [],
    'valid': [
      '3ca25ae354e192b26879f651a51d92aa8a34d8d3',
      'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d',
      'beb8c3f30da46be179b8df5f5ecb5e4b10508230',
      'efd5d3b190e893ed317f38da2420d63b7ae0d5ed',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsSha256() {
  test({
    'validator': v.isSha256,
    'args': [],
    'valid': [
      '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824',
      '1d996e033d612d9af2b44b70061ee0e868bfd14c2dd90b129e1edeb7953e7985',
      '80f70bfeaed5886e33536bcfa8c05c60afef5a0e48f699a7912d5e399cdcc441',
      '579282cfb65ca1f109b78536effaf621b853c9f7079664a3fbe2b519f435898c',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsSha384() {
  test({
    'validator': v.isSha384,
    'args': [],
    'valid': [
      '3fed1f814d28dc5d63e313f8a601ecc4836d1662a19365cbdcf6870f6b56388850b58043f7ebf2418abb8f39c3a42e31',
      'b330f4e575db6e73500bd3b805db1a84b5a034e5d21f0041d91eec85af1dfcb13e40bb1c4d36a72487e048ac6af74b58',
      'bf547c3fc5841a377eb1519c2890344dbab15c40ae4150b4b34443d2212e5b04aa9d58865bf03d8ae27840fef430b891',
      'fc09a3d11368386530f985dacddd026ae1e44e0e297c805c3429d50744e6237eb4417c20ffca8807b071823af13a3f65',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsSha512() {
  test({
    'validator': v.isSha512,
    'args': [],
    'valid': [
      '9b71d224bd62f3785d96d46ad3ea3d73319bfbc2890caadae2dff72519673ca72323c3d99ba5c11d7c7acc6e14b8c5da0c4663475c2e5c3adef46f73bcdec043',
      '83c586381bf5ba94c8d9ba8b6b92beb0997d76c257708742a6c26d1b7cbb9269af92d527419d5b8475f2bb6686d2f92a6649b7f174c1d8306eb335e585ab5049',
      '45bc5fa8cb45ee408c04b6269e9f1e1c17090c5ce26ffeeda2af097735b29953ce547e40ff3ad0d120e5361cc5f9cee35ea91ecd4077f3f589b4d439168f91b9',
      '432ac3d29e4f18c7f604f7c3c96369a6c5c61fc09bf77880548239baffd61636d42ed374f41c261e424d20d98e320e812a6d52865be059745fdb2cb20acff0ab',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsTiger192() {
  test({
    'validator': v.isTiger192,
    'args': [],
    'valid': [
      '6281a1f098c5e7290927ed09150d43ff3990a0fe1a48267c',
      '56268f7bc269cf1bc83d3ce42e07a85632394737918f4760',
      '46fc0125a148788a3ac1d649566fc04eb84a746f1a6e4fa7',
      '7731ea1621ae99ea3197b94583d034fdbaa4dce31a67404a',
    ],
    'invalid': [
      'KYT0bf1c35032a71a14c2f719e5a14c1',
      'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
      'q94375dj93458w34',
      '39485729348',
      '%&FHKJFvk',
    ],
  });
}

void testIsPort() {
  test({
    'validator': v.isPort,
    'args': [],
      'valid': [
        '0',
        '22',
        '80',
        '443',
        '3000',
        '8080',
        '65535',
      ],
      'invalid': [
        '',
        '-1',
        '65536',
      ],
  });
}

void testIsMACAddress() {
  test({
    'validator': v.isMACAddress,
    'args': [],
    'valid': [
      'ab:ab:ab:ab:ab:ab',
      'FF:FF:FF:FF:FF:FF',
      '01:02:03:04:05:ab',
      '01:AB:03:04:05:06',
    ],
    'invalid': [
      'abc',
      '01:02:03:04:05',
      '01:02:03:04::ab',
      '1:2:3:4:5:6',
      'AB:CD:EF:GH:01:02',
    ],
  });
}

void testIsMobilePhone() {
  test({
    'validator': v.isMobilePhone,
    'args': ['ar-AE'],
    'valid': [
      '+971502674453',
      '+971521247658',
      '+971541255684',
      '+971555454458',
      '+971561498855',
      '+971585215778',
      '971585215778',
      '0585215778',
      '585215778',
    ],
    'invalid': [
      '12345',
      '+971511498855',
      '+9715614988556',
      '+9745614988556',
      '',
      '+9639626626262',
      '+963332210972',
      '0114152198',
      '962796477263',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ar-EG'],
    'valid': [
      '+201004513789',
      '+201111453489',
      '+201221204610',
      '+201144621154',
      '+201200124304',
      '+201011201564',
      '+201124679001',
      '+201064790156',
      '+201274652177',
      '+201280134679',
      '+201090124576',
      '201090124576',
      '01090124576',
      '1090124576',
    ],
    'invalid': [
      '+221004513789',
      '+201404513789',
      '12345',
      '',
      '+9639626626262',
      '+963332210972',
      '0114152198',
      '962796477263',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ar-JO'],
    'valid': [
      '0796477263',
      '0777866254',
      '0786725261',
      '+962796477263',
      '+962777866254',
      '+962786725261',
      '962796477263',
      '962777866254',
      '962786725261',
    ],
    'invalid': [
      '00962786725261',
      '00962796477263',
      '12345',
      '',
      '+9639626626262',
      '+963332210972',
      '0114152198',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ar-SY'],
    'valid': [
      '0944549710',
      '+963944549710',
      '956654379',
      '0944549710',
      '0962655597',
    ],
    'invalid': [
      '12345',
      '',
      '+9639626626262',
      '+963332210972',
      '0114152198',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ar-SA'],
    'valid': [
      '0556578654',
      '+966556578654',
      '966556578654',
      '596578654',
      '572655597',
    ],
    'invalid': [
      '12345',
      '',
      '+9665626626262',
      '+96633221097',
      '0114152198',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['cs-CZ'],
    'valid': [
      '+420 123 456 789',
      '+420 123456789',
      '+420123456789',
      '123 456 789',
      '123456789',
    ],
    'invalid': [
      '',
      '+42012345678',
      '+421 123 456 789',
      '+420 023456789',
      '+4201234567892',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['sk-SK'],
    'valid': [
      '+421 123 456 789',
      '+421 123456789',
      '+421123456789',
      '123 456 789',
      '123456789',
    ],
    'invalid': [
      '',
      '+42112345678',
      '+422 123 456 789',
      '+421 023456789',
      '+4211234567892',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['de-DE'],
    'valid': [
      '+49 (0) 123 456 789',
      '+49 (0) 123 456789',
      '0123/4567890',
      '+49 01234567890',
      '01234567890',
    ],
    'invalid': [
      '',
      'Vml2YW11cyBmZXJtZtesting123',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['pt-BR'],
    'valid': [
      '55-17-3332-2155',
      '55-15-25661234',
      '551223456789',
      '01523456987',
      '022995678947',
      '+55-12-996551215',
    ],
    'invalid': [
      '+017-123456789',
      '5501599623874',
      '+55012962308',
      '+55-015-1234-3214',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['zh-CN'],
    'valid': [
      '15323456787',
      '13523333233',
      '13898728332',
      '+086-13238234822',
      '08613487234567',
      '8617823492338',
      '86-17823492338',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '010-38238383',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['zh-TW'],
    'valid': [
      '0987123456',
      '+886987123456',
      '886987123456',
      '+886-987123456',
      '886-987123456',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '0-987123456',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-ZA'],
    'valid': [
      '0821231234',
      '+27821231234',
      '27821231234',
    ],
    'invalid': [
      '082123',
      '08212312345',
      '21821231234',
      '+21821231234',
      '+0821231234',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-AU'],
    'valid': [
      '61404111222',
      '+61411222333',
      '0417123456',
    ],
    'invalid': [
      '082123',
      '08212312345',
      '21821231234',
      '+21821231234',
      '+0821231234',
      '04123456789',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-HK'],
    'valid': [
      '91234567',
      '9123-4567',
      '61234567',
      '51234567',
      '+85291234567',
      '+852-91234567',
      '+852-9123-4567',
      '852-91234567',
    ],
    'invalid': [
      '999',
      '+852-912345678',
      '123456789',
      '+852-1234-56789',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-KE'],
    'valid': [
      '+254728590432',
      '+254733875610',
      '254728590234',
      '0733346543',
      '0700459022',
    ],
    'invalid': [
      '999',
      '+25489032',
      '123456789',
      '+254800723845',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-UG'],
    'valid': [
          '+256728590432',
          '+256733875610',
          '256728590234',
          '0773346543',
          '0700459022',
    ],
    'invalid': [
      '999',
      '+25489032',
      '123456789',
      '+254800723845',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-RW'],
    'valid': [
      '+250728590432',
      '+250733875610',
      '250738590234',
      '0753346543',
      '0780459022',
    ],
    'invalid': [
      '999',
      '+254728590432',
      '+25089032',
      '123456789',
      '+250800723845',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-TZ'],
    'valid': [
          '+255728590432',
          '+255733875610',
          '255628590234',
          '0673346543',
          '0600459022',
    ],
    'invalid': [
      '999',
      '+254728590432',
      '+25589032',
      '123456789',
      '+255800723845'
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['fr-FR'],
    'valid': [
      '0612457898',
      '+33612457898',
      '33612457898',
      '0712457898',
      '+33712457898',
      '33712457898',
    ],
    'invalid': [
      '061245789',
      '06124578980',
      '0112457898',
      '0212457898',
      '0312457898',
      '0412457898',
      '0512457898',
      '0812457898',
      '0912457898',
      '+34612457898',
      '+336124578980',
      '+3361245789',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['el-GR'],
    'valid': [
      '+306944848966',
      '6944848966',
      '306944848966',
    ],
    'invalid': [
      '2102323234',
      '+302646041461',
      '120000000',
      '20000000000',
      '68129485729',
      '6589394827',
      '298RI89572',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-GB'],
    'valid': [
      '447789345856',
      '+447861235675',
      '07888814488',
    ],
    'invalid': [
      '67699567',
      '0773894868',
      '077389f8688',
      '+07888814488',
      '0152456999',
      '442073456754',
      '+443003434751',
      '05073456754',
      '08001123123',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-SG'],
    'valid': [
      '87654321',
      '98765432',
      '+6587654321',
      '+6598765432',
    ],
    'invalid': [
      '987654321',
      '876543219',
      '8765432',
      '9876543',
      '12345678',
      '+98765432',
      '+9876543212',
      '+15673628910',
      '19876543210',
      '8005552222',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-US'],
    'valid': [
      '19876543210',
      '8005552222',
      '+15673628910',
    ],
    'invalid': [
      '564785',
      '0123456789',
      '1437439210',
      '8009112340',
      '+10345672645',
      '11435213543',
      '2436119753',
      '16532116190',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-CA'],
    'valid': [
      '19876543210',
      '8005552222',
      '+15673628910',
    ],
    'invalid': [
      '564785',
      '0123456789',
      '1437439210',
      '8009112340',
      '+10345672645',
      '11435213543',
      '2436119753',
      '16532116190',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-ZM'],
    'valid': [
      '0956684590',
      '0966684590',
      '0976684590',
      '+260956684590',
      '+260966684590',
      '+260976684590',
      '260976684590',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '010-38238383',
      '966684590',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ru-RU'],
    'valid': [
      '+79676338855',
      '79676338855',
      '89676338855',
      '9676338855',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '010-38238383',
      '+9676338855',
      '19676338855',
      '6676338855',
      '+99676338855',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['sr-RS'],
    'valid': [
      '0640133338',
      '063333133',
      '0668888878',
      '+381645678912',
      '+381611314000',
      '0655885010',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '010-38238383',
      '+9676338855',
      '19676338855',
      '6676338855',
      '+99676338855',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['en-NZ'],
    'valid': [
      '+6427987035',
      '642240512347',
      '0293981646',
      '029968425'
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '010-38238383',
      '+9676338855',
      '19676338855',
      '6676338855',
      '+99676338855',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['nb-NO'],
    'valid': [
      '+4796338855',
      '+4746338855',
      '4796338855',
      '4746338855',
      '46338855',
      '96338855',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '+4676338855',
      '19676338855',
      '+4726338855',
      '4736338855',
      '66338855',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['nn-NO'],
    'valid': [
      '+4796338855',
      '+4746338855',
      '4796338855',
      '4746338855',
      '46338855',
      '96338855',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '+4676338855',
      '19676338855',
      '+4726338855',
      '4736338855',
      '66338855',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['vi-VN'],
    'valid': [
      '01636012403',
      '+841636012403',
      '1636012403',
      '841636012403',
      '+84999999999',
      '84999999999',
      '0999999999',
      '999999999',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '010-38238383',
      '260976684590',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['es-ES'],
    'valid': [
      '+34654789321',
      '654789321',
      '+34714789321',
      '714789321',
      '+34744789321',
      '744789321',
    ],
    'invalid': [
      '12345',
      '',
      'Vml2YW11cyBmZXJtZtesting123',
      '+3465478932',
      '65478932',
      '+346547893210',
      '6547893210',
      '+34704789321',
      '704789321',
      '+34754789321',
      '754789321',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['et-EE'],
    'valid': [
      '+372 512 34 567',
      '372 512 34 567',
      '+37251234567',
      '51234567',
      '81234567',
      '+372842345678',
    ],
    'invalid': [
      '12345',
      '',
      'NotANumber',
      '+333 51234567',
      '61234567',
      '+51234567',
      '+372 539 57 4',
      '+372 900 1234',
      '12345678',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['pl-PL'],
    'valid': [
          '+48512689767',
          '+48 56 376 87 47',
          '56 566 78 46',
          '657562855',
          '+48657562855',
          '+48 887472765',
          '+48 56 6572724',
          '+48 67 621 5461',
          '48 67 621 5461',
    ],
    'invalid': [
          '+48  67 621 5461',
          '+55657562855',
          '3454535',
          'teststring',
          '',
          '1800-88-8687',
          '+6019-5830837',
          '357562855',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['fa-IR'],
    'valid': [
          '+989123456789',
          '989223456789',
          '09323456789',
          '09021456789',
          '+98-990-345-6789',
          '+98 938 345 6789',
          '0938 345 6789',
    ],
    'invalid': [
          '',
          '+989623456789',
          '+981123456789',
          '01234567890',
          '09423456789',
          '09823456789',
          '9123456789',
          '091234567890',
          '0912345678',
          '+98 912 3456 6789',
          '0912 345 678',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['fi-FI'],
    'valid': [
          '+358505557171',
          '0455571',
          '0505557171',
          '358505557171',
          '04412345',
          '0457 123 45 67',
          '+358457 123 45 67',
          '+358 50 555 7171',
    ],
    'invalid': [
          '12345',
          '',
          '045557',
          '045555717112312332423423421',
          'Vml2YW11cyBmZXJtZtesting123',
          '010-38238383',
          '+3-585-0555-7171',
          '+9676338855',
          '19676338855',
          '6676338855',
          '+99676338855',
          '044123',
          '019123456789012345678901',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ms-MY'],
    'valid': [
          '+60128228789',
          '+60195830837',
          '+6019-5830837',
          '+6019-5830837',
          '0128737867',
          '01468987837',
          '016-2838768',
          '016 2838768',
    ],
    'invalid': [
          '12345',
          '601238788657',
          '088387675',
          '16-2838768',
          '032551433',
          '6088-387888',
          '088-261987',
          '1800-88-8687',
          '088-320000',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ko-KR'],
    'valid': [
          '+82-010-1234-5678',
          '+82-10-1234-5678',
          '82-010-1234-5678',
          '82-10-1234-5678',
          '+82 10 1234 5678',
          '010-123-5678',
          '10-1234-5678',
          '+82 10 1234 5678',
          '011 1234 5678',
          '+820112345678',
          '01012345678',
          '+82 016 1234 5678',
          '82 19 1234 5678',
          '+82 010 12345678',
    ],
    'invalid': [
          'abcdefghi',
          '+82 10 1234 567',
          '+82 10o 1234 1234',
          '+82 101 1234 5678',
          '+82 10 12 5678',
          '+011 7766 1234',
          '011_7766_1234',
          '+820 11 7766 1234',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ja-JP'],
    'valid': [
          '09012345688',
          '090 123 45678',
          '+8190-123-45678',
    ],
    'invalid': [
          '12345',
          '',
          '045555717112312332423423421',
          'Vml2YW11cyBmZXJtZtesting123',
          '+3-585-0555-7171',
          '0 1234 5689',
          '16 1234 5689',
          '03_1234_5689',
          '0312345678',
          '0721234567',
          '08002345678',
          '06 1234 5678',
          '072 123 4567',
          '0729 12 3456',
          '07296 1 2345',
          '072961 2345',
          '03-1234-5678',
          '+81312345678',
          '+816-1234-5678',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['it-IT'],
    'valid': [
          '370 3175423',
          '333202925',
          '+39 310 7688449',
          '+39 3339847632',
    ],
    'invalid': [
          '011 7387545',
          '12345',
          '+45 345 6782395',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['fr-BE'],
    'valid': [
         '0470123456',
          '+32470123456',
          '32470123456',
          '021234567',
          '+3221234567',
          '3221234567',
    ],
    'invalid': [
          '12345',
          '+3212345',
          '3212345',
          '04701234567',
          '+3204701234567',
          '3204701234567',
          '0212345678',
          '+320212345678',
          '320212345678',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['nl-BE'],
    'valid': [
          '0470123456',
          '+32470123456',
          '32470123456',
          '021234567',
          '+3221234567',
          '3221234567',
    ],
    'invalid': [
          '12345',
          '+3212345',
          '3212345',
          '04701234567',
          '+3204701234567',
          '3204701234567',
          '0212345678',
          '+320212345678',
          '320212345678',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['ro-RO'],
    'valid': [
          '+40740123456',
          '+40 740123456',
          '+40740 123 456',
          '+40740.123.456',
          '+40740-123-456',
          '40740123456',
          '40 740123456',
          '40740 123 456',
          '40740.123.456',
          '40740-123-456',
          '0740123456',
          '0740/123456',
          '0740 123 456',
          '0740.123.456',
          '0740-123-456',
    ],
    'invalid': [
          '',
          'Vml2YW11cyBmZXJtZtesting123',
          '123456',
          '740123456',
          '+40640123456',
          '+40210123456',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['id-ID'],
    'valid': [
          '0217123456',
          '0811 778 998',
          '089931236181900',
          '622178878890',
          '62811 778 998',
          '62811778998',
          '6289931236181900',
          '6221 740123456',
          '62899 740123456',
          '62899 7401 2346',
          '0341 8123456',
          '0778 89800910',
          '0741 123456',
          '+6221740123456',
          '+62811 778 998',
          '+62811778998',
    ],
    'invalid': [
          '+65740 123 456',
          '',
          'ASDFGJKLmZXJtZtesting123',
          '123456',
          '740123456',
          '+65640123456',
          '+64210123456',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['lt-LT'],
    'valid': [
          '+37051234567',
          '851234567',
    ],
    'invalid': [
          '+65740 123 456',
          '',
          'ASDFGJKLmZXJtZtesting123',
          '123456',
          '740123456',
          '+65640123456',
          '+64210123456',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['uk-UA'],
    'valid': [
          '+380982345679',
          '380982345679',
          '80982345679',
          '0982345679',
    ],
    'invalid': [
          '+30982345679',
          '982345679',
          '+380 98 234 5679',
          '+380-98-234-5679',
          '',
          'ASDFGJKLmZXJtZtesting123',
          '123456',
          '740123456',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['da-DK'],
    'valid': [
          '12345678',
          '12 34 56 78',
          '45 12345678',
          '4512345678',
          '45 12 34 56 78',
          '+45 12 34 56 78',
    ],
    'invalid': [
          '',
          '+45010203',
          'ASDFGJKLmZXJtZtesting123',
          '123456',
          '12 34 56',
          '123 123 12',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['fo-FO'],
    'valid': [
          '123456',
          '12 34 56',
          '298 123456',
          '298123456',
          '298 12 34 56',
          '+298 12 34 56',
    ],
    'invalid': [
          '',
          '+4501020304',
          'ASDFGJKLmZXJtZtesting123',
          '12345678',
          '12 34 56 78',
    ],
  });

  test({
    'validator': v.isMobilePhone,
    'args': ['kl-GL'],
    'valid': [
          '123456',
          '12 34 56',
          '299 123456',
          '299123456',
          '299 12 34 56',
          '+299 12 34 56',
    ],
    'invalid': [
          '',
          '+4501020304',
          'ASDFGJKLmZXJtZtesting123',
          '12345678',
          '12 34 56 78',
    ],
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
  testIsMd5();
  testIsMd4();
  testIsSha1();
  testIsSha256();
  testIsSha384();
  testIsSha512();
  testIsRipemd128();
  testIsRipemd160();
  testIsTiger128();
  testIsTiger160();
  testIsTiger192();
  testIsCrc32();
  testIsCrc32b();
  testIsPort();
  testIsMACAddress();
  testIsMobilePhone();

  print('-------------------------------------');
  print('All tests in validator.dart complete.');
  print('-------------------------------------');
}
