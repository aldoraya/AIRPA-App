class Validator {
  static const String _pattern =
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";
  
  static final RegExp _regex = RegExp(_pattern);

  static bool validateEmail(String value) {
    return _regex.hasMatch(value);
  }
}