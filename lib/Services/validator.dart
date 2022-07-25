bool validateEmail(String email) {
  if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
    return false;
  } else {
    return true;
  }
}

bool validatePhone(String phone) {
  if (phone.isEmpty || phone.length < 10) {
    return false;
  } else if ((phone.startsWith('+91') && phone.length > 13) ||
      (phone.startsWith('91') && phone.length > 12)) {
    return false;
  } else {
    return true;
  }
}

bool validateRegularText(String text) {
  if (text.isEmpty) {
    return false;
  } else {
    return true;
  }
}

bool validatePassword(String password) {
  if (password.isEmpty || password.length < 6) {
    return false;
  } else {
    return true;
  }
}

bool validateConfirmPassword(String password, String confirmPassword) {
  if (confirmPassword.isEmpty || confirmPassword != password) {
    return false;
  } else {
    return true;
  }
}
