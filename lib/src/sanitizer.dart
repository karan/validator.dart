part of validator;

Map default_normalize_email_options = { 'lowercase': true };


// convert the input to a string
String toString(input) {
  if (input == null || (input is List && input.length == 0)) {
    input = '';
  }
  return input.toString();
}


// convert the input to a date, or null if the input is not a date
DateTime toDate(String str) {
  try {
    return DateTime.parse(str);
  } catch(e) {
    return null;
  }
}


// convert the input to a float, or NaN if the input is not a float
double toFloat(String str) {
  try{
    return double.parse(str);
  } catch (e) {
    return double.NAN;
  }
}

// convert the input to a float, or NaN if the input is not a float
double toDouble(String str) {
  return toFloat(str);
}


// convert the input to an integer, or NaN if the input is not an integer
num toInt(String str, {int radix:10}) {
  try {
    return int.parse(str, radix:radix);
  } catch (e) {
    try {
      return double.parse(str).toInt();
    } catch (e) {
      return double.NAN;
    }
  }
}


// convert the input to a boolean
bool toBoolean(String str, [bool strict]) {
  if (strict == true) {
    return str == '1' || str == 'true';
  }
  return str != '0' && str != 'false' && str != '';
}


// trim characters (whitespace by default) from both sides of the input
String trim(String str, [String chars]) {
  RegExp pattern = (chars != null) ? new RegExp('^[$chars]+|[$chars]+\$') : new RegExp(r'^\s+|\s+$');
  return str.replaceAll(pattern, '');
}


// trim characters from the left-side of the input
String ltrim(String str, [String chars]) {
  var pattern = chars != null ? new RegExp('^[$chars]+') : new RegExp(r'^\s+');
  return str.replaceAll(pattern, '');
}


// trim characters from the right-side of the input
String rtrim(String str, [String chars]) {
  var pattern = chars != null ? new RegExp('[$chars]+\$') : new RegExp(r'\s+$');
  return str.replaceAll(pattern, '');
}


// remove characters that do not appear in the whitelist
String whitelist(String str, String chars) {
  return str.replaceAll(new RegExp('[^' + chars + ']+'), '');
}


// remove characters that appear in the blacklist
String blacklist(String str, String chars) {
  return str.replaceAll(new RegExp('[' + chars + ']+'), '');
}


// remove characters with a numerical value < 32 and 127
String stripLow(String str, [bool keep_new_lines]) {
  String chars = keep_new_lines == true ? '\x00-\x09\x0B\x0C\x0E-\x1F\x7F' : '\x00-\x1F\x7F';
  return blacklist(str, chars);
}


// replace <, >, &, ' and " with HTML entities
String escape(String str) {
  return (str.replaceAll(new RegExp(r'&'), '&amp;')
             .replaceAll(new RegExp(r'"'), '&quot;')
             .replaceAll(new RegExp(r"'"), '&#x27;')
             .replaceAll(new RegExp(r'<'), '&lt;')
             .replaceAll(new RegExp(r'>'), '&gt;'));
}


// canonicalize an email address
String normalizeEmail(String email, [Map options]) {
  options = _merge(options, default_normalize_email_options);
  if (isEmail(email) == false) {
      return '';
  }

  List parts = email.split('@');
  parts[1] = parts[1].toLowerCase();

  if (options['lowercase'] == true) {
      parts[0] = parts[0].toLowerCase();
  }

  if (parts[1] == 'gmail.com' || parts[1] == 'googlemail.com') {
    if (options['lowercase'] == false) {
        parts[0] = parts[0].toLowerCase();
    }
    parts[0] = parts[0].replaceAll('\.', '').split('+')[0];
    parts[1] = 'gmail.com';
  }
  return parts.join('@');
}
