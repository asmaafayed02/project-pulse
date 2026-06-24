import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorMapper {
  FirebaseErrorMapper._();

  static String map(FirebaseAuthException e) {
    switch (e.code) {
    case 'user-not-found':
      return 'No account found with this email';

    case 'wrong-password':
      return 'Incorrect password';

    case 'invalid-credential':
      return 'Invalid email or password';

    case 'email-already-in-use':
      return 'This email is already registered';

    case 'invalid-email':
      return 'Please enter a valid email address';

    case 'weak-password':
      return 'Password should be at least 6 characters';

    case 'too-many-requests':
      return 'Too many attempts. Please try again later';

    case 'network-request-failed':
      return 'No internet connection';

    default:
      return 'Something went wrong. Please try again';
    }
  }
}