class InputValidators {
  static String? requireNonEmpty(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? tunisianPhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    final phoneRegex = RegExp(r'^\+216\d{8}$');
    if (!phoneRegex.hasMatch(value.trim())) return 'Enter a valid Tunisian phone (+216########)';
    return null;
  }

  static String? passwordStrong(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'At least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Include an uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(value)) return 'Include a lowercase letter';
    if (!RegExp(r'\d').hasMatch(value)) return 'Include a number';
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>\-_=+\\/\[\];\']').hasMatch(value)) return 'Include a special character';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Confirm your password';
    if (value != original) return 'Passwords do not match';
    return null;
  }

  static String? identifierEmailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter email or phone number';
    final v = value.trim();
    final isEmail = v.contains('@');
    if (isEmail) {
      return email(v);
    } else {
      return tunisianPhone(v);
    }
  }
}