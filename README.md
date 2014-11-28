validator.dart
=============

String validation and sanitization for Dart.

| Build | Tweet |
| ----- | ----- |
| [![Build Status](https://drone.io/github.com/karan/validator.dart/status.png)](https://drone.io/github.com/karan/validator.dart/latest) | [![](http://sopins.herokuapp.com/twitter/https://github.com/karan/validator.dart/pin.png)](https://twitter.com/intent/tweet?text=String+validation+and+sanitization+for+Dart.&amp;url=https://github.com/karan/validator.dart&amp;via=KaranGoel) |

Port of [chriso's library](https://github.com/chriso/validator.js).

**The docs below will continue to evolve.**

## Validators

| Method | Description | Status |
| ------ | ----------- | ------ |
| equals(str, comparison) | check if the string matches the comparison. | ✓ |
| contains(str, seed) | check if the string contains the seed. | ✓ |
| matches(str, pattern [, modifiers]) | check if string matches the pattern. Either `matches('foo', /foo/i)` or `matches('foo', 'foo', 'i')`. | x |
| isEmail(str) | check if the string is an email. | ✓ |
| isURL(str [, options]) | check if the string is an URL. | ✓ |
| isFQDN(str [, options]) | check if the string is a fully qualified domain name (e.g. `domain.com`). `options` is an object which defaults to `{ require_tld: true, allow_underscores: false }`. | ✓ |
| isIP(str [, version]) | check if the string is an IP (`version` `4` or `6`). | ✓ |
| isAlpha(str) | check if the string contains only letters (a-zA-Z). | ✓ |
| isNumeric(str) | check if the string contains only numbers. | ✓ |
| isAlphanumeric(str) | check if the string contains only letters and numbers. | ✓ |
| isBase64(str) | check if a string is base64 encoded. | ✓ |
| isHexadecimal(str) | check if the string is a hexadecimal number. | ✓ |
| isHexColor(str) | check if the string is a hexadecimal color. | ✓ |
| isLowercase(str) | check if the string is lowercase. | ✓ |
| isUppercase(str) | check if the string is uppercase. | ✓ |
| isInt(str) | check if the string is an integer. | ✓ |
| isFloat(str) | check if the string is a float. | ✓ |
| isDivisibleBy(str, number) | check if the string is a number that's divisible by another. | ✓ |
| isNull(str) | check if the string is null. | ✓ |
| isLength(str, min [, max]) | check if the string's length falls in a range. Note: this function takes into account surrogate pairs. | ✓ |
| isByteLength(str, min [, max]) | check if the string's length (in bytes) falls in a range. | ✓ |
| isUUID(str [, version]) | check if the string is a UUID (version 3, 4 or 5). | ✓ |
| isDate(str) | check if the string is a date. | ✓ |
| isAfter(str [, date]) | check if the string is a date that's after the specified date (defaults to now). | ✓ |
| isBefore(str [, date]) | check if the string is a date that's before the specified date. | ✓ |
| isIn(str, values) | check if the string is in a array of allowed values. | ✓ |
| isCreditCard(str) | check if the string is a credit card. | ✓ |
| isISBN(str [, version]) | check if the string is an ISBN (version 10 or 13). | ✓ |
| isJSON(str) | check if the string is valid JSON (note: uses JSON.parse). | ✓ |
| isMultibyte(str) | check if the string contains one or more multibyte chars. | ✓ |
| isAscii(str) | check if the string contains ASCII chars only. | ✓ |
| isFullWidth(str) | check if the string contains any full-width chars. | ✓ |
| isHalfWidth(str) | check if the string contains any half-width chars. | ✓ |
| isVariableWidth(str) | check if the string contains a mixture of full and half-width chars. | x |
| isSurrogatePair(str) | check if the string contains any surrogate pairs chars. | x |
| isMongoId(str) | check if the string is a valid hex-encoded representation of a MongoDB ObjectId. | x |

## Sanitizers

| Method | Description | Status |
| ------ | ----------- | ------ |
| toString(input) | convert the input to a string. | x |
| toDate(input) | convert the input to a date, or `null` if the input is not a date. | x |
| toFloat(input) | convert the input to a float, or `NaN` if the input is not a float. | x |
| toInt(input [, radix]) | convert the input to an integer, or `NaN` if the input is not an integer. | x |
| toBoolean(input [, strict]) | convert the input to a boolean. Everything except for `'0'`, `'false'` and `''` returns `true`. In strict mode only `'1'` and `'true'` return `true`. | x |
| trim(input [, chars]) | trim characters (whitespace by default) from both sides of the input. | x |
| ltrim(input [, chars]) | trim characters from the left-side of the input. | x |
| rtrim(input [, chars]) | trim characters from the right-side of the input. | x |
| escape(input) | replace `<`, `>`, `&`, `'` and `"` with HTML entities. | x |
| stripLow(input [, keep_new_lines]) | remove characters with a numerical value < 32 and 127, mostly control characters. If `keep_new_lines` is `true`, newline characters are preserved (`\n` and `\r`, hex `0xA` and `0xD`). Unicode-safe in JavaScript. | x |
| whitelist(input, chars) | remove characters that do not appear in the whitelist. The characters are used in a RegExp and so you will need to escape some chars, e.g. whitelist(input, '\\[\\]'). | x |
| blacklist(input, chars) | remove characters that appear in the blacklist. The characters are used in a RegExp and so you will need to escape some chars, e.g. blacklist(input, '\\[\\]').
| normalizeEmail(email [, options]) | canonicalize an email address. `options` is an object which defaults to `{ lowercase: true }`. With `lowercase` set to `true`, the local part of the email address is lowercased for all domains; the hostname is always lowercased and the local part of the email address is always lowercased for hosts that are known to be case-insensitive (currently only GMail). Normalization follows special rules for known providers: currently, GMail addresses have dots removed in the local part and are stripped of tags (e.g. `some.one+tag@gmail.com` becomes `someone@gmail.com`) and all `@googlemail.com` addresses are normalized to `@gmail.com`. | x |
