part of validator;

Future<String> validateEmail(String str, {String errorMessage}) {
  if (isEmail(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str is not a valid email address.');
  }
}

Future<String> validateURL(String str, {Map options, String errorMessage}) {
  if (isURL(str, options)) {
    return new Future(() => Uri.encodeFull(str));
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid URL.');
  }
}

Future<String> validateFQDN(String str, {Map options, String errorMessage}) {
  if (isFQDN(str)) {
    return new Future(() => Uri.encodeFull(str));
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid FQDN.');
  }
}

Future<String> validateIP(String str, {version, String errorMessage}) {
  if (isIP(str, version)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid IP address.');
  }
}

Future<String> validateAlpha(String str, {String errorMessage}) {
  if (isAlpha(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str is not only contains alphabet.');
  }
}

Future<String> validateNumeric(String str, {String errorMessage}) {
  if (isNumeric(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str is not only contains number.');
  }
}

Future<String> validateAlphanumeric(String str, {String errorMessage}) {
  if (isAlphanumeric(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str is not only contains alphabet and number');
  }
}

Future<String> validateBase64(String str, {String errorMessage}) {
  if (isBase64(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid Base 64');
  }
}

Future<String> validateHexadecimal(String str, {String errorMessage}) {
  if (isHexadecimal(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid hexadecimal.');
  }
}

Future<String> validateHexColor(String str, {String errorMessage}) {
  if (isHexColor(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid hex color.');
  }
}

Future<String> validateLowercase(String str, {String errorMessage}) {
  if (isLowercase(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str is not only contains lowercase.');
  }
}

Future<String> validateUppercase(String str, {String errorMessage}) {
  if (isUppercase(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str is not only contains uppercase.');
  }
}

Future<int> validateInt(String str, {String errorMessage}) {
  if (isInt(str)) {
    return new Future(() => int.parse(str));
  } else {
    return new Future.error(
        errorMessage ?? '$str is not a valid integer value.');
  }
}

Future<double> validateFloat(String str, {String errorMessage}) {
  if (isFloat(str)) {
    return new Future(() => double.parse(str));
  } else {
    return new Future.error(
        errorMessage ?? '$str is not a valid decimal value.');
  }
}

Future<double> validateDivisibleBy(String str, n, {String errorMessage}) {
  if (isDivisibleBy(str, n)) {
    return new Future(() => double.parse(str));
  } else {
    return new Future.error(errorMessage ?? '$str is not divisible by $n.');
  }
}

Future<Null> validateNull(String str, {String errorMessage}) {
  if (isNull(str)) {
    return new Future(() => null);
  } else {
    return new Future.error(errorMessage ?? '$str is not null.');
  }
}

Future<String> validateNotNull(String str, {String errorMessage}) {
  if (!isNull(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is null.');
  }
}

Future<String> validateLength(String str, int min,
    {int max, String errorMessage}) {
  if (isLength(str, min, max)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str invalid length.');
  }
}

Future<String> validateByteLength(String str, int min,
    {int max, String errorMessage}) {
  if (isByteLength(str, min, max)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str invalid byte length.');
  }
}

Future<String> validateUUID(String str, {int version, String errorMessage}) {
  if (isUUID(str, version)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid UUID.');
  }
}

Future<DateTime> validateDate(String str, {String errorMessage}) {
  try {
    return new Future(() => DateTime.parse(str));
  } catch (_) {
    return new Future.error(errorMessage ?? '$str is not a valid date.');
  }
}

Future<DateTime> validateAfter(String str,
    {DateTime after, String errorMessage}) {
  return validateDate(str).then((date) {
    var _after = after ?? new DateTime.now();
    if (date.isAfter(_after)) {
      return new Future(() => date);
    } else {
      return new Future.error(
          errorMessage ?? '$str is not after ${_after.toIso8601String()}');
    }
  }).catchError((error) {
    return new Future.error(error);
  });
}

Future<DateTime> validateBefore(String str,
    {DateTime before, String errorMessage}) {
  return validateDate(str).then((date) {
    var _before = before ?? new DateTime.now();
    if (date.isBefore(_before)) {
      return new Future(() => date);
    } else {
      return new Future.error(
          errorMessage ?? '$str is not before ${_before.toIso8601String()}');
    }
  }).catchError((error) {
    return new Future.error(error);
  });
}

Future<String> validateIn(String str, values, {String errorMessage}) {
  if (isIn(str, values)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is not one of the values.');
  }
}

Future<String> validateCreditCard(String str, {String errorMessage}) {
  if (isCreditCard(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str is not a valid credit card number.');
  }
}

Future<String> validateISBN(String str, {int version, String errorMessage}) {
  if (isISBN(str, version)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid ISBN.');
  }
}

Future<Map> validateJson(String str, {String errorMessage}) {
  try {
    return new Future(() => json.decode(str));
  } catch (_) {
    return new Future.error(errorMessage ?? '$str is not a valid JSON.');
  }
}

Future<String> validateMultibyte(String str, {String errorMessage}) {
  if (isMultibyte(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str doesn\'t contain one or more multibyte chars');
  }
}

Future<String> validateAscii(String str, {String errorMessage}) {
  if (isAscii(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str not only contains ASCII chars.');
  }
}

Future<String> validateFullWidth(String str, {String errorMessage}) {
  if (isFullWidth(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str doesn\'t have any full width characters.');
  }
}

Future<String> validateHalfWidth(String str, {String errorMessage}) {
  if (isHalfWidth(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str doesn\'t have any half width characters.');
  }
}

Future<String> validateVariableWidth(String str, {String errorMessage}) {
  if (isVariableWidth(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ??
        '$str doesn\'t have any full and half width characters.');
  }
}

Future<String> validateSurrogatePair(String str, {String errorMessage}) {
  if (isSurrogatePair(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(
        errorMessage ?? '$str doesn\'t have any surrogate pairs characters.');
  }
}

Future<String> validateMongoId(String str, {String errorMessage}) {
  if (isMongoId(str)) {
    return new Future(() => str);
  } else {
    return new Future.error(errorMessage ?? '$str is not a valid Mongo ID.');
  }
}
