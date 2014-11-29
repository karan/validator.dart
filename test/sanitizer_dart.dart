library sanitizer_dart;

import 'package:validator/validator.dart' as s;


void test(Map options) {
  List args = options['args'];

  options.keys.forEach((input) {
    args.insert(0, input);

    var f = options["sanitizer"].toString();
    var result = Function.apply(options['sanitizer'], args);
    var expected = options['expected'];

    if (result != expected) {
      throw new Exception('sanitizer.$f($args) failed but should have passed');
    }
  });
}


void main() {

}