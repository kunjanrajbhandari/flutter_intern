class Validation {
  String validatePassword(String value) {
    if ((value.length < 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    } else if (value.isEmpty) {
      return "Cannot be Empty";
    }
    return '';
  }
}
