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
int toInt(String str, [radix]) {
  try {
    radix = radix == null ? 10 : radix;
    return int.parse(str, radix:radix);
  } catch (e) {
    return double.NAN.toInt();
  }
}
