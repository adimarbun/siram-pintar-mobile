String? emptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String? emailValidator(String? value) {
  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value != null && !emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }

  return null;
}

String? minimaLengthValidator(String? value, int minLength) {
  if ((value?.length ?? 0) < minLength) {
    return 'Please enter min $minLength character';
  }
  return null;
}
