part of validator;

  RegExp _email = new RegExp(
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

RegExp _ipv4Maybe =
    new RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
RegExp _ipv6 =
    new RegExp(r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$');

RegExp _surrogatePairsRegExp = new RegExp(r'[\uD800-\uDBFF][\uDC00-\uDFFF]');

RegExp _alpha = new RegExp(r'^[a-zA-Z]+$');
RegExp _alphanumeric = new RegExp(r'^[a-zA-Z0-9]+$');
RegExp _numeric = new RegExp(r'^-?[0-9]+$');
RegExp _int = new RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
RegExp _float =
    new RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
RegExp _hexadecimal = new RegExp(r'^[0-9a-fA-F]+$');
RegExp _hexcolor = new RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

RegExp _base64 = new RegExp(
    r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');

RegExp _creditCard = new RegExp(
    r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$');

RegExp _isbn10Maybe = new RegExp(r'^(?:[0-9]{9}X|[0-9]{10})$');
RegExp _isbn13Maybe = new RegExp(r'^(?:[0-9]{13})$');

final Map<String, RegExp> _uuid = {
  '3': new RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$'),
  '4': new RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  '5': new RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  'all': new RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$')
};

RegExp _multibyte = new RegExp(r'[^\x00-\x7F]');
RegExp _ascii = new RegExp(r'^[\x00-\x7F]+$');
RegExp _fullWidth = new RegExp(
    r'[^\u0020-\u007E\uFF61-\uFF9F\uFFA0-\uFFDC\uFFE8-\uFFEE0-9a-zA-Z]');
RegExp _halfWidth = new RegExp(
    r'[\u0020-\u007E\uFF61-\uFF9F\uFFA0-\uFFDC\uFFE8-\uFFEE0-9a-zA-Z]');

RegExp _md5 = new RegExp(r'^[a-fA-F0-9]{32}$');
RegExp _md4 = new RegExp(r'^[a-fA-F0-9]{32}$');
RegExp _sha1 = new RegExp(r'^[a-fA-F0-9]{40}$');
RegExp _sha256 = new RegExp(r'^[a-fA-F0-9]{64}$');
RegExp _sha384 = new RegExp(r'^[a-fA-F0-9]{96}$');
RegExp _sha512 = new RegExp(r'^[a-fA-F0-9]{128}$');
RegExp _ripemd128 = new RegExp(r'^[a-fA-F0-9]{32}$');
RegExp _ripemd160 = new RegExp(r'^[a-fA-F0-9]{40}$');
RegExp _tiger128 = new RegExp(r'^[a-fA-F0-9]{32}$');
RegExp _tiger160 = new RegExp(r'^[a-fA-F0-9]{40}$');
RegExp _tiger192 = new RegExp(r'^[a-fA-F0-9]{48}$');
RegExp _crc32 = new RegExp(r'^[a-fA-F0-9]{8}$');
RegExp _crc32b = new RegExp(r'^[a-fA-F0-9]{8}$');

RegExp _macAddress = new RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');

final Map<String, RegExp> _phones = {
  'ar-AE': new RegExp(r'^((\+?971)|0)?5[024568]\d{7}$'),
  'ar-DZ': new RegExp(r'^(\+?213|0)(5|6|7)\d{8}$'),
  'ar-EG': new RegExp(r'^((\+?20)|0)?1[012]\d{8}$'),
  'ar-JO': new RegExp(r'^(\+?962|0)?7[789]\d{7}$'),
  'ar-SA': new RegExp(r'^(!?(\+?966)|0)?5\d{8}$'),
  'ar-SY': new RegExp(r'^(!?(\+?963)|0)?9\d{8}$'),
  'cs-CZ': new RegExp(r'^(\+?420)? ?[1-9][0-9]{2} ?[0-9]{3} ?[0-9]{3}$'),
  'da-DK': new RegExp(r'^(\+?45)?\s?\d{2}\s?\d{2}\s?\d{2}\s?\d{2}$'),
  'de-DE': new RegExp(
      r'^(\+?49[ \.\-])?([\(]{1}[0-9]{1,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$'),
  'el-GR': new RegExp(r'^(\+?30|0)?(69\d{8})$'),
  'en-AU': new RegExp(r'^(\+?61|0)4\d{8}$'),
  'en-GB': new RegExp(r'^(\+?44|0)7\d{9}$'),
  'en-CA': new RegExp(r'^(\+?1)?[2-9]\d{2}[2-9](?!11)\d{6}$'),
  'en-HK': new RegExp(r'^(\+?852\-?)?[456789]\d{3}\-?\d{4}$'),
  'en-IN': new RegExp(r'^(\+?91|0)?[789]\d{9}$'),
  'en-KE': new RegExp(r'^(\+?254|0)?[7]\d{8}$'),
  'en-NG': new RegExp(r'^(\+?234|0)?[789]\d{9}$'),
  'en-NZ': new RegExp(r'^(\+?64|0)2\d{7,9}$'),
  'en-PK': new RegExp(
      r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$'),
  'en-RW': new RegExp(r'^(\+?250|0)?[7]\d{8}$'),
  'en-SG': new RegExp(r'^(\+65)?[89]\d{7}$'),
  'en-TZ': new RegExp(r'^(\+?255|0)?[67]\d{8}$'),
  'en-UG': new RegExp(r'^(\+?256|0)?[7]\d{8}$'),
  'en-US': new RegExp(r'^(\+?1)?[2-9]\d{2}[2-9](?!11)\d{6}$'),
  'en-ZA': new RegExp(r'^(\+?27|0)\d{9}$'),
  'en-ZM': new RegExp(r'^(\+?26)?09[567]\d{7}$'),
  'es-ES': new RegExp(r'^(\+?34)?(6\d{1}|7[1234])\d{7}$'),
  'et-EE': new RegExp(r'^(\+?372)?\s?(5|8[1-4])\s?([0-9]\s?){6,7}$'),
  'fa-IR': new RegExp(r'^(\+?98[\-\s]?|0)9[0-39]\d[\-\s]?\d{3}[\-\s]?\d{4}$'),
  'fi-FI': new RegExp(r'^(\+?358|0)\s?(4(0|1|2|4|5|6)?|50)\s?(\d\s?){4,8}\d$'),
  'fo-FO': new RegExp(r'^(\+?298)?\s?\d{2}\s?\d{2}\s?\d{2}$'),
  'fr-BE': new RegExp(r'^(\+?32|0)4?\d{8}$'),
  'fr-FR': new RegExp(r'^(\+?33|0)[67]\d{8}$'),
  'he-IL': new RegExp(r'^(\+972|0)([23489]|5[0248]|77)[1-9]\d{6}'),
  'hu-HU': new RegExp(r'^(\+?36)(20|30|70)\d{7}$'),
  'id-ID': new RegExp(r'^(\+?62|0[1-9])[\s|\d]+$'),
  'it-IT': new RegExp(r'^(\+?39)?\s?3\d{2} ?\d{6,7}$'),
  'ja-JP': new RegExp(r'^(\+?81|0)[789]0[ \-]?[1-9]\d{2}[ \-]?\d{5}$'),
  'kl-GL': new RegExp(r'^(\+?299)?\s?\d{2}\s?\d{2}\s?\d{2}$'),
  'ko-KR': new RegExp(
      r'^((\+?82)[ \-]?)?0?1([0|1|6|7|8|9]{1})[ \-]?\d{3,4}[ \-]?\d{4}$'),
  'lt-LT': new RegExp(r'^(\+370|8)\d{8}$'),
  'ms-MY': new RegExp(
      r'^(\+?6?01){1}(([145]{1}(\-|\s)?\d{7,8})|([236789]{1}(\s|\-)?\d{7}))$'),
  'nb-NO': new RegExp(r'^(\+?47)?[49]\d{7}$'),
  'nl-BE': new RegExp(r'^(\+?32|0)4?\d{8}$'),
  'nn-NO': new RegExp(r'^(\+?47)?[49]\d{7}$'),
  'pl-PL': new RegExp(r'^(\+?48)? ?[5-8]\d ?\d{3} ?\d{2} ?\d{2}$'),
  'pt-BR': new RegExp(r'^(\+?55|0)\-?[1-9]{2}\-?[2-9]{1}\d{3,4}\-?\d{4}$'),
  'pt-PT': new RegExp(r'^(\+?351)?9[1236]\d{7}$'),
  'ro-RO':
      new RegExp(r'^(\+?4?0)\s?7\d{2}(\/|\s|\.|\-)?\d{3}(\s|\.|\-)?\d{3}$'),
  'ru-RU': new RegExp(r'^(\+?7|8)?9\d{9}$'),
  'sk-SK': new RegExp(r'^(\+?421)? ?[1-9][0-9]{2} ?[0-9]{3} ?[0-9]{3}$'),
  'sr-RS': new RegExp(r'^(\+3816|06)[- \d]{5,9}$'),
  'tr-TR': new RegExp(r'^(\+?90|0)?5\d{9}$'),
  'uk-UA': new RegExp(r'^(\+?38|8)?0\d{9}$'),
  'vi-VN': new RegExp(
      r'^(\+?84|0)?((1(2([0-9])|6([2-9])|88|99))|(9((?!5)[0-9])))([0-9]{7})$'),
  'zh-CN': new RegExp(r'^(\+?0?86\-?)?1[345789]\d{9}$'),
  'zh-HK': new RegExp(r'^(\+?852\-?)?[456789]\d{3}\-?\d{4}$'),
  'zh-TW': new RegExp(r'^(\+?886\-?|0)?9\d{8}$')
};

/// check if the string matches the comparison
bool equals(final String str, comparison) {
  return str == comparison.toString();
}

/// check if the string contains the seed
bool contains(final String str, seed) {
  return str.indexOf(seed.toString()) >= 0;
}

/// check if string matches the pattern.
bool matches(final String str, final String pattern) {
  RegExp re = new RegExp(pattern);
  return re.hasMatch(str);
}

/// check if the string is an email
bool isEmail(final String str) {
  return _email.hasMatch(str.toLowerCase());
}

/// check if the string is a URL
///
/// `options` is a `Map` which defaults to
/// `{ 'protocols': ['http','https','ftp'], 'require_tld': true,
/// 'require_protocol': false, 'allow_underscores': false,
/// 'host_whitelist': false, 'host_blacklist': false }`.
bool isURL(String str, [Map options]) {
  if (str == null ||
      str.length == 0 ||
      str.length > 2083 ||
      str.indexOf('mailto:') == 0) {
    return false;
  }

  final Map default_url_options = {
    'protocols': ['http', 'https', 'ftp'],
    'require_tld': true,
    'require_protocol': false,
    'allow_underscores': false
  };

  options = _merge(options, default_url_options);

  // check protocol
  List<String> split = str.split('://');
  if (split.length > 1) {
    String protocol = _shift(split);
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
  String hash = split.join('#');
  if (hash != null && hash != "" && new RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str.split('?');
  str = _shift(split);
  String query = split.join('?');
  if (query != null && query != "" && new RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str.split('/');
  str = _shift(split);
  String path = split.join('/');
  if (path != null && path != "" && new RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str.split('@');
  if (split.length > 1) {
    String auth = _shift(split);
    if (auth.indexOf(':') >= 0) {
      List authSplit = auth.split(':');
      String user = _shift(authSplit);
      if (!new RegExp(r'^\S+$').hasMatch(user)) {
        return false;
      }
      if (!new RegExp(r'^\S*$').hasMatch(user)) {
        return false;
      }
    }
  }

  // check hostname
  String hostname = split.join('@');
  split = hostname.split(':');
  String host = _shift(split);
  if (split.length > 0) {
    int port;
    String port_str = split.join(':');
    try {
      port = int.parse(port_str, radix: 10);
    } catch (e) {
      return false;
    }
    if (!new RegExp(r'^[0-9]+$').hasMatch(port_str) ||
        port <= 0 ||
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
bool isFQDN(String str, [options]) {
  final Map<String, bool> default_fqdn_options = {
    'require_tld': true,
    'allow_underscores': false
  };

  options = _merge(options, default_fqdn_options);
  List parts = str.split('.');
  if (options['require_tld']) {
    String tld = parts.removeLast();
    if (parts.length == 0 || !new RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
      return false;
    }
  }

  for (int i = 0; i < parts.length; i++) {
    String part = parts[i];
    if (options['allow_underscores']) {
      if (part.indexOf('__') >= 0) {
        return false;
      }
    }
    if (!new RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
      return false;
    }
    if (part[0] == '-' ||
        part[part.length - 1] == '-' ||
        part.indexOf('---') >= 0) {
      return false;
    }
  }
  return true;
}

/// check if the string contains only letters (a-zA-Z).
bool isAlpha(final String str) {
  return _alpha.hasMatch(str);
}

/// check if the string contains only numbers
bool isNumeric(final String str) {
  return _numeric.hasMatch(str);
}

/// check if the string contains only letters and numbers
bool isAlphanumeric(final String str) {
  return _alphanumeric.hasMatch(str);
}

/// check if a string is base64 encoded
bool isBase64(final String str) {
  return _base64.hasMatch(str);
}

/// check if the string is an integer
bool isInt(final String str) {
  return _int.hasMatch(str);
}

/// check if the string is a float
bool isFloat(final String str) {
  return _float.hasMatch(str);
}

/// check if the string is a hexadecimal number
bool isHexadecimal(final String str) {
  return _hexadecimal.hasMatch(str);
}

/// check if the string is a hexadecimal color
bool isHexColor(final String str) {
  return _hexcolor.hasMatch(str);
}

/// check if the string is lowercase
bool isLowercase(final String str) {
  return str == str.toLowerCase();
}

/// check if the string is uppercase
bool isUppercase(final String str) {
  return str == str.toUpperCase();
}

/// check if the string is a number that's divisible by another
///
/// [n] is a String or an int.
bool isDivisibleBy(final String str, n) {
  try {
    return double.parse(str) % int.parse(n) == 0;
  } catch (e) {
    return false;
  }
}

/// check if the string is null
bool isNull(final String str) {
  return str == null || str.length == 0;
}

/// check if the string's length falls in a range
///
/// Note: this function takes into account surrogate pairs.
bool isLength(final String str, int min, [int max]) {
  List surrogatePairs = _surrogatePairsRegExp.allMatches(str).toList();
  int len = str.length - surrogatePairs.length;
  return len >= min && (max == null || len <= max);
}

/// check if the string's length (in bytes) falls in a range.
bool isByteLength(final String str, int min, [int max]) {
  return str.length >= min && (max == null || str.length <= max);
}

/// check if the string is a UUID (version 3, 4 or 5).
bool isUUID(final String str, [version]) {
  if (version == null) {
    version = 'all';
  } else {
    version = version.toString();
  }

  RegExp pat = _uuid[version];
  return (pat != null && pat.hasMatch(str.toUpperCase()));
}

/// check if the string is a date
bool isDate(final String str) {
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
bool isAfter(final String str, [dynamic date]) {
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
  } catch (e) {
    return false;
  }

  return str_date.isAfter(date);
}

/// check if the string is a date that's before the specified date
///
/// If `date` is not passed, it defaults to now.
bool isBefore(final String str, [dynamic date]) {
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
  } catch (e) {
    return false;
  }

  return str_date.isBefore(date);
}

/// check if the string is in a array of allowed values
bool isIn(final String str, dynamic values) {
  if (values == null || values.length == 0) {
    return false;
  }

  if (values is List) {
    values = values.map((e) => e.toString()).toList();
  }

  return values.indexOf(str) >= 0;
}

/// check if the string is a credit card
bool isCreditCard(final String str) {
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
bool isISBN(final String str, [dynamic version]) {
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
bool isJSON(final String str) {
  try {
    JSON.decode(str);
  } catch (e) {
    return false;
  }
  return true;
}

/// check if the string contains one or more multibyte chars
bool isMultibyte(final String str) {
  return _multibyte.hasMatch(str);
}

/// check if the string contains ASCII chars only
bool isAscii(final String str) {
  return _ascii.hasMatch(str);
}

/// check if the string contains any full-width chars
bool isFullWidth(final String str) {
  return _fullWidth.hasMatch(str);
}

/// check if the string contains any half-width chars
bool isHalfWidth(final String str) {
  return _halfWidth.hasMatch(str);
}

/// check if the string contains a mixture of full and half-width chars
bool isVariableWidth(final String str) {
  return isFullWidth(str) && isHalfWidth(str);
}

/// check if the string contains any surrogate pairs chars
bool isSurrogatePair(final String str) {
  return _surrogatePairsRegExp.hasMatch(str);
}

/// check if the string is a valid hex-encoded representation of a MongoDB ObjectId
bool isMongoId(final String str) {
  return (isHexadecimal(str) && str.length == 24);
}

/// check if the string is a MD5 hash
bool isMd5(final String str) {
  return _md5.hasMatch(str);
}

/// check if the string is a MD5 hash
bool isMd4(final String str) {
  return _md4.hasMatch(str);
}

/// check if the string is a sha1 hash
bool isSha1(final String str) {
  return _sha1.hasMatch(str);
}

/// check if the string is a sha256 hash
bool isSha256(final String str) {
  return _sha256.hasMatch(str);
}

/// check if the string is a sha384 hash
bool isSha384(final String str) {
  return _sha384.hasMatch(str);
}

/// check if the string is a sha512 hash
bool isSha512(final String str) {
  return _sha512.hasMatch(str);
}

/// check if the string is a ripemd128 hash
bool isRipemd128(final String str) {
  return _ripemd128.hasMatch(str);
}

/// check if the string is a ripemd160 hash
bool isRipemd160(final String str) {
  return _ripemd160.hasMatch(str);
}

/// check if the string is a tiger128 hash
bool isTiger128(final String str) {
  return _tiger128.hasMatch(str);
}

/// check if the string is a tiger160 hash
bool isTiger160(final String str) {
  return _tiger160.hasMatch(str);
}

/// check if the string is a tiger192 hash
bool isTiger192(final String str) {
  return _tiger192.hasMatch(str);
}

/// check if the string is a crc32 hash
bool isCrc32(final String str) {
  return _crc32.hasMatch(str);
}

/// check if the string is a crc32b hash
bool isCrc32b(final String str) {
  return _crc32b.hasMatch(str);
}

/// check if the string is a valid port number
bool isPort(final String str) {
  int value = int.parse(str, onError: (source) => -1);
  return value >= 0 && value <= 65535;
}

/// check if the string is a MAC address
bool isMACAddress(final String str) {
  return _macAddress.hasMatch(str);
}

/// check if the string is a mobile phone number
bool isMobilePhone(final String str, final String locale) {
  if (_phones.containsKey(locale)) {
    return _phones[locale].hasMatch(str);
  } else if (locale == 'any') {
    _phones.forEach((key, value) {
      if (_phones.containsKey(key)) {
        RegExp phone = _phones[key];
        if (phone.hasMatch(str) == true) {
          return true;
        }
      }
    });
    return false;
  }
  throw new Exception('Invalid locale ${locale}');
}
