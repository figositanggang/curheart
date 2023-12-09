// ! Variables
const String isOpenedKey = "isOpen";

// RegExp
final RegExp regExpEmail = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp regExpPassword =
    RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
final RegExp regExpName = RegExp('[a-zA-Z]');

// Emoji
List<Map<String, dynamic>> emoji = [
  {
    "type": "Senang",
    "emoji": "😁",
  },
  {
    "type": "Sedih",
    "emoji": "😔",
  },
];

// ------------------------------------------------------------
// ----

// ! Methods
String? emailValidator(String? value) {
  if (!regExpEmail.hasMatch(value!)) {
    return "Email belum valid";
  }

  return null;
}

String? passwordValidator(String? value) {
  if (!regExpPassword.hasMatch(value!)) {
    return "Password masih lemah";
  }
  if (value.length < 8) {
    return "Password masih pendek";
  }

  return null;
}
