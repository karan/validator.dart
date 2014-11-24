library validator_test;

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

void testIsURL() {
  test_this({
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
  test_this({
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

void main() {
  testEquals();
  testContains();
  testIsEmail();
  testIsURL();
  testIsIP();

  print('All tests complete');
}
