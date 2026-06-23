class Validators {
  Validators._();

  // ── Email ────────────────────────────────────────────
   static final RegExp _emailRegex = RegExp(
    r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$',
  );

  static String? email(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email is required';
    }

    if (!_emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }


  // ── Password ─────────────────────────────────────────
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  // ── Confirm Password ──────────────────────────────────
  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }

      if (value != password) {
        return 'Passwords do not match';
      }

      return null;
    };
  }

  // ── Name ─────────────────────────────────────────────
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (value.trim().length > 50) {
      return 'Name must be less than 50 characters';
    }

    return null;
  }

  // ── Required (generic) ───────────────────────────────
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  // ── Task Title ───────────────────────────────────────
  static String? taskTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Task title is required';
    }

    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }

    if (value.trim().length > 100) {
      return 'Title must be less than 100 characters';
    }

    return null;
  }

  // ── Description (optional but has max length) ────────
  static String? description(String? value) {
    if (value == null || value.trim().isEmpty) return null; // optional

    if (value.trim().length > 500) {
      return 'Description must be less than 500 characters';
    }

    return null;
  }
}