part of validator;

RegExp email = new RegExp(r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

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

  var default_url_options = {
    'protocols': [ 'http', 'https', 'ftp' ],
    'require_tld': true,
    'require_protocol': false,
    'allow_underscores': false
  };



}
