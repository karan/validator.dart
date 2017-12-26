validator.dart
=============

[![Build Status](https://drone.io/github.com/karan/validator.dart/status.png)](https://drone.io/github.com/karan/validator.dart/latest)

String validation and sanitization for Dart.

Port of [chriso's library](https://github.com/chriso/validator.js).

## Usage

#### Documentation

Complete documentation of the package is available at http://www.dartdocs.org/documentation/validator/0.0.7/index.html#validator/validator

For a list of methods, refer to the sections below.

#### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

    dependencies:
      validator: ">=0.0.4 <0.1.0"

#### 2. Install it

You can install packages from the command line:

    $ pub get

Alternatively, your editor might support pub. Check the docs for your editor to learn more.

#### 3. Import it

Now in your Dart code, you can use:

    import 'package:validator/validator.dart';

## Validators

- **equals(String str, comparison)** - check if the string matches the comparison.
- **contains(String str, seed)** - check if the string contains the seed.
- **matches(String str, pattern)** - check if string matches the pattern. `matches('foobar', 'foo')`.
- **isEmail(String str)** - check if the string is an email.
- **isURL(String str [, options])** - check if the string is an URL. `options` is an object which defaults to `{ protocols: ['http','https','ftp'], require_tld: true, require_protocol: false, allow_underscores: false, host_whitelist: false, host_blacklist: false }`.
- **isFQDN(String str [, options])** - check if the string is a fully qualified domain name (e.g. domain.com). `options` is an object which defaults to `{ require_tld: true, allow_underscores: false }`.
- **isIP(String str [, version])** - check if the string is an IP (version 4 or 6).
- **isAlpha(String str)** - check if the string contains only letters (a-zA-Z).
- **isNumeric(String str)** - check if the string contains only numbers.
- **isAlphanumeric(String str)** - check if the string contains only letters and numbers.
- **isBase64(String str)** - check if a string is base64 encoded.
- **isHexadecimal(String str)** - check if the string is a hexadecimal number.
- **isHexColor(String str)** - check if the string is a hexadecimal color.
- **isLowercase(String str)** - check if the string is lowercase.
- **isUppercase(String str)** - check if the string is uppercase.
- **isInt(String str)** - check if the string is an integer.
- **isFloat(String str)** - check if the string is a float.
- **isDivisibleBy(String str, number)** - check if the string is a number that's divisible by another.
- **isNull(String str)** - check if the string is null.
- **isLength(String str, min [, max])** - check if the string's length falls in a range. Note: this function takes into account surrogate pairs.
- **isByteLength(String str, min [, max])** - check if the string's length (in bytes) falls in a range.
- **isUUID(String str [, version])** - check if the string is a UUID (version 3, 4 or 5).
- **isDate(String str)** - check if the string is a date.
- **isAfter(String str [, date])** - check if the string is a date that's after the specified date (defaults to now).
- **isBefore(String str [, date])** - check if the string is a date that's before the specified date.
- **isIn(String str, values)** - check if the string is in a array of allowed values.
- **isCreditCard(String str)** - check if the string is a credit card.
- **isISBN(String str [, version])** - check if the string is an ISBN (version 10 or 13).
- **isJSON(String str)** - check if the string is valid JSON (note: uses JSON.parse).
- **isMultibyte(String str)** - check if the string contains one or more multibyte chars.
- **isAscii(String str)** - check if the string contains ASCII chars only.
- **isFullWidth(String str)** - check if the string contains any full-width chars.
- **isHalfWidth(String str)** - check if the string contains any half-width chars.
- **isVariableWidth(String str)** - check if the string contains a mixture of full and half-width chars.
- **isSurrogatePair(String str)** - check if the string contains any surrogate pairs chars.
- **isMongoId(String str)** - check if the string is a valid hex-encoded representation of a [MongoDB ObjectId][mongoid].
- ***isMd5(String str)*** check if the string is a MD5 hash.
- ***isMd4(String str)*** check if the string is a MD4 hash.
- ***isSha1(String str)*** check if the string is a Sha1 hash.
- ***isSha256(String str)*** check if the string is a Sha256 hash.
- ***isSha384(String str)*** check if the string is a Sha384 hash.
- ***isSha512(String str)*** check if the string is a Sha512 hash.
- ***isRipemd128(String str)*** check if the string is a Ripemd128 hash.
- ***isRipemd160(String str)*** check if the string is a Ripemd160 hash.
- ***isTiger128(String str)*** check if the string is a Tiger128 hash.
- ***isTiger160(String str)*** check if the string is a Tiger160 hash.
- ***isTiger192(String str)*** check if the string is a Tiger192 hash.
- ***isCrc32(String str)*** check if the string is a Crc32 hash.
- ***isCrc32b(String str)*** check if the string is a Crc32b hash.
- ***isPort(String str)*** check if the string is a valid port number.
- ***isMACAddress(String str)*** check if the string is a MAC address.
- ***isMobilePhone(String str)*** |check if the string is a is a mobile phone number.
`['ar-AE', 'ar-DZ','ar-EG', 'ar-JO', 'ar-SA', 'ar-SY', 'cs-CZ', 'de-DE', 'da-DK', 'el-GR', 'en-AU', 'en-CA', 'en-GB', 'en-HK', 'en-IN',  'en-KE', 'en-NG', 'en-NZ', 'en-RW', 'en-SG', 'en-UG', 'en-US', 'en-TZ', 'en-ZA', 'en-ZM', 'en-PK', 'es-ES', 'et-EE', 'fa-IR', 'fi-FI', 'fr-FR', 'he-IL', 'hu-HU', 'it-IT', 'ja-JP', 'ko-KR', 'lt-LT', 'ms-MY', 'nb-NO', 'nn-NO', 'pl-PL', 'pt-PT', 'ro-RO', 'ru-RU', 'sk-SK', 'sr-RS', 'tr-TR', 'uk-UA', 'vi-VN', 'zh-CN', 'zh-HK', 'zh-TW']` OR 'any'. If 'any' is used, function will check if any of the locales match).

## Sanitizers

- **toString(String input)** - convert the input to a string.
- **toDate(String input)** - convert the input to a date, or `null` if the input is not a date.
- **toFloat(String input)** - convert the input to a float, or `NaN` if the input is not a float.
- **toInt(String input [, radix])** - convert the input to an integer, or `NaN` if the input is not an integer.
- **toBoolean(String input [, strict])** - convert the input to a boolean. Everything except for `'0'`, `'false'` and `''` returns `true`. In strict mode only `'1'` and `'true'` return `true`.
- **trim(String input [, chars])** - trim characters (whitespace by default) from both sides of the input.
- **ltrim(String input [, chars])** - trim characters from the left-side of the input.
- **rtrim(String input [, chars])** - trim characters from the right-side of the input.
- **escape(String input)** - replace `<`, `>`, `&`, `'` and `"` with HTML entities.
- **stripLow(String input [, keep_new_lines])** - remove characters with a numerical value < 32 and 127, mostly control characters. If `keep_new_lines` is `true`, newline characters are preserved (`\n` and `\r`, hex `0xA` and `0xD`). Unicode-safe in JavaScript.
- **whitelist(String input, chars)** - remove characters that do not appear in the whitelist. The characters are used in a RegExp and so you will need to escape some chars, e.g. whitelist(String input, '\\[\\]').
- **blacklist(String input, chars)** - remove characters that appear in the blacklist. The characters are used in a RegExp and so you will need to escape some chars, e.g. blacklist(String input, '\\[\\]').
- **normalizeEmail(String email [, options])** - canonicalize an email address. `options` is an object which defaults to `{ lowercase: true }`. With `lowercase` set to `true`, the local part of the email address is lowercased for all domains; the hostname is always lowercased and the local part of the email address is always lowercased for hosts that are known to be case-insensitive (currently only GMail). Normalization follows special rules for known providers: currently, GMail addresses have dots removed in the local part and are stripped of tags (e.g. `some.one+tag@gmail.com` becomes `someone@gmail.com`) and all `@googlemail.com` addresses are normalized to `@gmail.com`.

## Tests

To test the package, run:

    $ ./tool/run_tests.sh

