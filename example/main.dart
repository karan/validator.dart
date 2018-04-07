import 'package:asynchronous_validator/asynchronous_validator.dart'
    as validator;

main() {
  validator
      .validateEmail('not a valid email',
          errorMessage: 'Please insert a valid email address.')
      .then((validEmail) {
    print('$validEmail is valid email address.');
  }).catchError((error) {
    print(error);
  });

  validator.validateURL('hello.com').then((validURL) {
    print(validURL);
  }).catchError((error) {
    print(error);
  });

  validator.validateIP('192.168.10.01', version: 6).then((validIP) {
    print(validIP);
  }).catchError((error) {
    print(error);
  });

  validator.validateEmail('good@example.co.id').then((validEmail) {
    print('$validEmail is a valid email address.');
    return validator.validateFloat('43.022');
  }).then((number) {
    print(number + 100);
    return validator.validateIP('100.12.23.10', version: 90);
  }).then((ipAddress) {
    print(ipAddress);
  }).catchError((error) {
    print(error);
  });

  validator
      .validateURL('https://rest-api.io/posts?limit=10&filter[status]=current')
      .then((validUri) {
    print(validUri.toString());
  }).catchError((error) {
    print(error);
  });

  validator.validateDate('1995-10-05').then((date) {
    print(date.toIso8601String());
    return validator.validateAfter('1996-12-28', after: date);
  }).then((date) {
    print(date.toIso8601String());
  }).catchError((error) {
    print(error);
  });

  validator.validateAfter('2010-10-04').then((date) {
    print('${date.toIso8601String()} is after today.');
  }).catchError((error) {
    print(error);
  });

  validator.validateISBN('979-97221-0-1').then((validISBN) {
    print('$validISBN is a valid ISBN.');
  }).catchError((error) {
    print(error);
  });
}
