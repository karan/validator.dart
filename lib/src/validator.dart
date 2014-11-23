part of validator;

// check if the string matches the comparison
bool equals(String str, comparison) {
  return str == comparison.toString();
}

// check if the string contains the seed
bool contains(String str, seed) {
  return str.indexOf(seed.toString()) >= 0;
}
