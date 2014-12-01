part of validator;


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
