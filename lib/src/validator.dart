part of validator;

RegExp email = new RegExp(r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

RegExp ipv4Maybe = new RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
RegExp ipv6 = new RegExp(r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$');

RegExp alpha = new RegExp(r'^[a-zA-Z]+$');
RegExp alphanumeric = new RegExp(r'^[a-zA-Z0-9]+$');
RegExp numeric = new RegExp(r'^-?[0-9]+$');
RegExp _int = new RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
RegExp _float = new RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
RegExp hexadecimal = new RegExp(r'^[0-9a-fA-F]+$');
RegExp hexcolor = new RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

RegExp base64 = new RegExp(r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');


// check if the string matches the comparison
bool equals(String str, comparison) {
  return str == comparison.toString();
}


// check if the string contains the seed
bool contains(String str, seed) {
  return str.indexOf(seed.toString()) >= 0;
}


// check if string matches the pattern. Either matches('foo', /foo/i) or matches('foo', 'foo', 'i').
//bool matches(String str, pattern, [modifiers]) {
//  RegExp re = new RegExp(pattern);
//  return re.hasMatch(str);
////  print(reflect(pattern).type.reflectedType.toString());
//}


bool isEmail(String str) {
  return email.hasMatch(str.toLowerCase());
}


bool isURL(String str, [options]) {
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

  options = merge(options, default_url_options);

  var protocol, user, pass, auth, host, hostname, port, port_str, path, query,
      hash, split;

  // check protocol
  split = str.split('://');
  if (split.length > 1) {
    protocol = shift(split);
    if (options['protocols'].indexOf(protocol) == -1) {
      return false;
    }
  } else if (options['require_protocols'] == true) {
    return false;
  }
  str = split.join('://');

  // check hash
  split = str.split('#');
  str = shift(split);
  hash = split.join('#');
  if (hash != null && hash != "" && new RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str.split('?');
  str = shift(split);
  query = split.join('?');
  if (query != null && query != "" && new RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str.split('/');
  str = shift(split);
  path = split.join('/');
  if (path != null && path != "" && new RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str.split('@');
  if (split.length > 1) {
    auth = shift(split);
    if (auth.indexOf(':') >= 0) {
      auth = auth.split(':');
      user = shift(auth);
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
  host = shift(split);
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


// check if the string is an IP (version 4 or 6)
bool isIP(String str, [version]) {
  version = version.toString();
  if (version == 'null') {
    return isIP(str, 4) || isIP(str, 6);
  } else if (version == '4') {
    if (!ipv4Maybe.hasMatch(str)) {
      return false;
    }
    var parts = str.split('.');
    parts.sort((a, b) => int.parse(a) - int.parse(b));
    return int.parse(parts[3]) <= 255;
  }
  return version == '6' && ipv6.hasMatch(str);
}


// check if the string is a fully qualified domain name (e.g. domain.com).
bool isFQDN(str, [options]) {
  Map default_fqdn_options = {
    'require_tld': true,
    'allow_underscores': false
  };

  options = merge(options, default_fqdn_options);
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


// check if the string contains only letters (a-zA-Z).
bool isAlpha(String str) {
  return alpha.hasMatch(str);
}


// check if the string contains only numbers
bool isNumeric(String str) {
  return numeric.hasMatch(str);
}


// check if the string contains only letters and numbers
bool isAlphanumeric(String str) {
  return alphanumeric.hasMatch(str);
}


// check if a string is base64 encoded
bool isBase64(String str) {
  return base64.hasMatch(str);
}


// check if the string is an integer
bool isInt(String str) {
  return _int.hasMatch(str);
}


// check if the string is a float
bool isFloat(String str) {
  return _float.hasMatch(str);
}


// check if the string is a hexadecimal number
bool isHexadecimal(String str) {
  return hexadecimal.hasMatch(str);
}


// check if the string is a hexadecimal color
bool isHexColor(String str) {
  return hexcolor.hasMatch(str);
}


// check if the string is lowercase
bool isLowercase(String str) {
  return str == str.toLowerCase();
}


// check if the string is uppercase
bool isUppercase(String str) {
  return str == str.toUpperCase();
}


// check if the string is a number that's divisible by another
bool isDivisibleBy(String str, n) {
  try {
    return double.parse(str) % int.parse(n) == 0;
  } catch(e) {
    return false;
  }
}


// check if the string is null
bool isNull(String str) {
  return str == null || str.length == 0;
}


// check if the string's length falls in a range
bool isLength(String str, int min, [int max]) {
  List surrogatePairs = new RegExp(r'[\uD800-\uDBFF][\uDC00-\uDFFF]').allMatches(str).toList();
  int len = str.length - surrogatePairs.length;
  return len >= min && (max == null || len <= max);
}
