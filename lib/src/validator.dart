part of validator;

RegExp _email = new RegExp(r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

RegExp _ipv4Maybe = new RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
RegExp _ipv6 = new RegExp(r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$');

RegExp _surrogatePairsRegExp = new RegExp(r'[\uD800-\uDBFF][\uDC00-\uDFFF]');

RegExp _alpha = new RegExp(r'^[a-zA-Z]+$');
RegExp _alphanumeric = new RegExp(r'^[a-zA-Z0-9]+$');
RegExp _numeric = new RegExp(r'^-?[0-9]+$');
RegExp _int = new RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
RegExp _float = new RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
RegExp _hexadecimal = new RegExp(r'^[0-9a-fA-F]+$');
RegExp _hexcolor = new RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

RegExp _base64 = new RegExp(r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');

RegExp _creditCard = new RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$');

RegExp _isbn10Maybe = new RegExp(r'^(?:[0-9]{9}X|[0-9]{10})$');
RegExp _isbn13Maybe = new RegExp(r'^(?:[0-9]{13})$');

Map _uuid = {
  '3': new RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$'),
  '4': new RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  '5': new RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  'all': new RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$')
};

RegExp _multibyte = new RegExp(r'[^\x00-\x7F]');
RegExp _ascii = new RegExp(r'^[\x00-\x7F]+$');
RegExp _fullWidth = new RegExp(r'[^\u0020-\u007E\uFF61-\uFF9F\uFFA0-\uFFDC\uFFE8-\uFFEE0-9a-zA-Z]');
RegExp _halfWidth = new RegExp(r'[\u0020-\u007E\uFF61-\uFF9F\uFFA0-\uFFDC\uFFE8-\uFFEE0-9a-zA-Z]');


/// check if the string matches the comparison
bool equals(String str, comparison) {
  return str == comparison.toString();
}


/// check if the string contains the seed
bool contains(String str, seed) {
  return str.indexOf(seed.toString()) >= 0;
}


/// check if string matches the pattern.
bool matches(String str, pattern) {
  RegExp re = new RegExp(pattern);
  return re.hasMatch(str);
}


/// check if the string is an email
bool isEmail(String str) {
  return _email.hasMatch(str.toLowerCase());
}


/// check if the string is a URL
///
/// `options` is a `Map` which defaults to
/// `{ 'protocols': ['http','https','ftp'], 'require_tld': true,
/// 'require_protocol': false, 'allow_underscores': false,
/// 'host_whitelist': false, 'host_blacklist': false }`.
bool isURL(String str, [Map options]) {
  if (str == null || str.length == 0 || str.length > 2083 ||
      str.indexOf('mailto:') == 0) {
    return false;
  }

  Map default_url_options = {
    'protocols': [ 'http', 'https', 'ftp' ],
    'require_tld': true,
    'require_protocol': false,
    'allow_underscores': false
  };

  options = _merge(options, default_url_options);

  var protocol, user, pass, auth, host, hostname, port, port_str, path, query,
      hash, split;

  // check protocol
  split = str.split('://');
  if (split.length > 1) {
    protocol = _shift(split);
    if (options['protocols'].indexOf(protocol) == -1) {
      return false;
    }
  } else if (options['require_protocols'] == true) {
    return false;
  }
  str = split.join('://');

  // check hash
  split = str.split('#');
  str = _shift(split);
  hash = split.join('#');
  if (hash != null && hash != "" && new RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str.split('?');
  str = _shift(split);
  query = split.join('?');
  if (query != null && query != "" && new RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str.split('/');
  str = _shift(split);
  path = split.join('/');
  if (path != null && path != "" && new RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str.split('@');
  if (split.length > 1) {
    auth = _shift(split);
    if (auth.indexOf(':') >= 0) {
      auth = auth.split(':');
      user = _shift(auth);
      if (!new RegExp(r'^\S+$').hasMatch(user)) {
        return false;
      }
      pass = auth.join(':');
      if (!new RegExp(r'^\S*$').hasMatch(user)) {
        return false;
      }
    }
  }

  // check hostname
  hostname = split.join('@');
  split = hostname.split(':');
  host = _shift(split);
  if (split.length > 0) {
    port_str = split.join(':');
    try {
      port = int.parse(port_str, radix: 10);
    } catch (e) {
      return false;
    }
    if (!new RegExp(r'^[0-9]+$').hasMatch(port_str) || port <= 0 ||
        port > 65535) {
      return false;
    }
  }

  if (!isIP(host) && !isFQDN(host, options) && host != 'localhost') {
    return false;
  }

  if (options['host_whitelist'] == true &&
      options['host_whitelist'].indexOf(host) == -1) {
    return false;
  }

  if (options['host_blacklist'] == true &&
      options['host_blacklist'].indexOf(host) != -1) {
    return false;
  }

  return true;

}


/// check if the string is an IP (version 4 or 6)
///
/// `version` is a String or an `int`.
bool isIP(String str, [version]) {
  version = version.toString();
  if (version == 'null') {
    return isIP(str, 4) || isIP(str, 6);
  } else if (version == '4') {
    if (!_ipv4Maybe.hasMatch(str)) {
      return false;
    }
    var parts = str.split('.');
    parts.sort((a, b) => int.parse(a) - int.parse(b));
    return int.parse(parts[3]) <= 255;
  }
  return version == '6' && _ipv6.hasMatch(str);
}


/// check if the string is a fully qualified domain name (e.g. domain.com).
///
/// `options` is a `Map` which defaults to `{ 'require_tld': true, 'allow_underscores': false }`.
bool isFQDN(str, [options]) {
  Map default_fqdn_options = {
    'require_tld': true,
    'allow_underscores': false
  };

  options = _merge(options, default_fqdn_options);
  List parts = str.split('.');
  if (options['require_tld']) {
    var tld = parts.removeLast();
    if (parts.length == 0 || !new RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
      return false;
    }
  }

  for (var part, i = 0; i < parts.length; i++) {
    part = parts[i];
    if (options['allow_underscores']) {
      if (part.indexOf('__') >= 0) {
        return false;
      }
    }
    if (!new RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
      return false;
    }
    if (part[0] == '-' || part[part.length - 1] == '-' ||
        part.indexOf('---') >= 0) {
      return false;
    }
  }
  return true;
}


/// check if the string contains only letters (a-zA-Z).
bool isAlpha(String str) {
  return _alpha.hasMatch(str);
}


/// check if the string contains only numbers
bool isNumeric(String str) {
  return _numeric.hasMatch(str);
}


/// check if the string contains only letters and numbers
bool isAlphanumeric(String str) {
  return _alphanumeric.hasMatch(str);
}


/// check if a string is base64 encoded
bool isBase64(String str) {
  return _base64.hasMatch(str);
}


/// check if the string is an integer
bool isInt(String str) {
  return _int.hasMatch(str);
}


/// check if the string is a float
bool isFloat(String str) {
  return _float.hasMatch(str);
}


/// check if the string is a hexadecimal number
bool isHexadecimal(String str) {
  return _hexadecimal.hasMatch(str);
}


/// check if the string is a hexadecimal color
bool isHexColor(String str) {
  return _hexcolor.hasMatch(str);
}


/// check if the string is lowercase
bool isLowercase(String str) {
  return str == str.toLowerCase();
}


/// check if the string is uppercase
bool isUppercase(String str) {
  return str == str.toUpperCase();
}


/// check if the string is a number that's divisible by another
///
/// [n] is a String or an int.
bool isDivisibleBy(String str, n) {
  try {
    return double.parse(str) % int.parse(n) == 0;
  } catch(e) {
    return false;
  }
}


/// check if the string is null
bool isNull(String str) {
  return str == null || str.length == 0;
}


/// check if the string's length falls in a range
///
/// Note: this function takes into account surrogate pairs.
bool isLength(String str, int min, [int max]) {
  List surrogatePairs = _surrogatePairsRegExp.allMatches(str).toList();
  int len = str.length - surrogatePairs.length;
  return len >= min && (max == null || len <= max);
}


/// check if the string's length (in bytes) falls in a range.
bool isByteLength(String str, int min, [int max]) {
  return str.length >= min && (max == null || str.length <= max);
}


/// check if the string is a UUID (version 3, 4 or 5).
bool isUUID(String str, [version]) {
  if (version == null) {
    version = 'all';
  } else {
    version = version.toString();
  }

  RegExp pat = _uuid[version];
  return (pat != null && pat.hasMatch(str.toUpperCase()));
}


/// check if the string is a date
bool isDate(String str) {
  try {
    DateTime.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}


/// check if the string is a date that's after the specified date
///
/// If `date` is not passed, it defaults to now.
bool isAfter(String str, [date]) {
  if (date == null) {
    date = new DateTime.now();
  } else if (isDate(date)) {
    date = DateTime.parse(date);
  } else {
    return false;
  }

  DateTime str_date;
  try {
    str_date = DateTime.parse(str);
  } catch(e) {
    return false;
  }

  return str_date.isAfter(date);
}

/// check if the string is a date that's before the specified date
///
/// If `date` is not passed, it defaults to now.
bool isBefore(String str, [date]) {
  if (date == null) {
    date = new DateTime.now();
  } else if (isDate(date)) {
    date = DateTime.parse(date);
  } else {
    return false;
  }

  DateTime str_date;
  try {
    str_date = DateTime.parse(str);
  } catch(e) {
    return false;
  }

  return str_date.isBefore(date);
}


/// check if the string is in a array of allowed values
bool isIn(String str, values) {
  if (values == null || values.length == 0) {
    return false;
  }

  if (values is List) {
    values = values.map((e) => e.toString()).toList();
  }

  return values.indexOf(str) >= 0;
}


/// check if the string is a credit card
bool isCreditCard(String str) {
  String sanitized = str.replaceAll(new RegExp(r'[^0-9]+'), '');
  if (!_creditCard.hasMatch(sanitized)) {
    return false;
  }

  // Luhn algorithm
  int sum = 0;
  String digit;
  bool shouldDouble = false;

  for (int i = sanitized.length - 1; i >= 0; i--) {
    digit = sanitized.substring(i, (i + 1));
    int tmpNum = int.parse(digit);

    if (shouldDouble == true) {
        tmpNum *= 2;
        if (tmpNum >= 10) {
            sum += ((tmpNum % 10) + 1);
        } else {
            sum += tmpNum;
        }
    } else {
        sum += tmpNum;
    }
    shouldDouble = !shouldDouble;
  }

  return (sum % 10 == 0);
}


/// check if the string is an ISBN (version 10 or 13)
bool isISBN(String str, [version]) {
  if (version == null) {
    return isISBN(str, '10') || isISBN(str, '13');
  }

  version = version.toString();

  String sanitized = str.replaceAll(new RegExp(r'[\s-]+'), '');
  int checksum = 0;

  if (version == '10') {
    if (!_isbn10Maybe.hasMatch(sanitized)) {
      return false;
    }
    for (int i = 0; i < 9; i++) {
      checksum += (i + 1) * int.parse(sanitized[i]);
    }
    if (sanitized[9] == 'X') {
      checksum += 10 * 10;
    } else {
      checksum += 10 * int.parse(sanitized[9]);
    }
    return (checksum % 11 == 0);
  } else if (version == '13') {
    if (!_isbn13Maybe.hasMatch(sanitized)) {
      return false;
    }
    var factor = [1, 3];
    for (int i = 0; i < 12; i++) {
      checksum += factor[i % 2] * int.parse(sanitized[i]);
    }
    return (int.parse(sanitized[12]) - ((10 - (checksum % 10)) % 10) == 0);
  }

  return false;
}


/// check if the string is valid JSON
bool isJSON(str) {
  try {
    json.decode(str);
  } catch (e) {
    return false;
  }
  return true;
}


/// check if the string contains one or more multibyte chars
bool isMultibyte(String str) {
  return _multibyte.hasMatch(str);
}


/// check if the string contains ASCII chars only
bool isAscii(String str) {
  return _ascii.hasMatch(str);
}


/// check if the string contains any full-width chars
bool isFullWidth(String str) {
  return _fullWidth.hasMatch(str);
}


/// check if the string contains any half-width chars
bool isHalfWidth(String str) {
  return _halfWidth.hasMatch(str);
}


/// check if the string contains a mixture of full and half-width chars
bool isVariableWidth(String str) {
  return isFullWidth(str) && isHalfWidth(str);
}


/// check if the string contains any surrogate pairs chars
bool isSurrogatePair(String str) {
  return _surrogatePairsRegExp.hasMatch(str);
}


/// check if the string is a valid hex-encoded representation of a MongoDB ObjectId
bool isMongoId(String str) {
  return (isHexadecimal(str) && str.length == 24);
}