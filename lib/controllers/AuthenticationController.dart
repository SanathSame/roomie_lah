import 'package:firebase_auth/firebase_auth.dart';

/// Controller which validates users account details from an account information database.
class AuthenticationController {
  static final _auth = FirebaseAuth.instance;

  /// Creates a new user in the database.
  Future<bool> signUp(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser != null) {
        final user = _auth.currentUser;
        print(user?.email);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Validates the account details from database to allow user to log in.
  Future<bool> login(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // ignore: unnecessary_null_comparison
      if (user != null) {
        print('Logged In');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Signs user out.
  void signOut() {
    _auth.signOut();
  }

  /// Gets email of the user currently logged in.
  static String? getCurrentUser() {
    return _auth.currentUser!.email != null ? _auth.currentUser!.email : null;
  }

  static Future<void> changePassword() async {
    String? email = _auth.currentUser!.email;
    // ignore: unnecessary_null_comparison
    if (email != null) {
      _auth
          .sendPasswordResetEmail(email: email)
          .then((value) => {print('Sent')})
          // ignore: argument_type_not_assignable_to_error_handler
          .catchError(() {
        print('Error');
      });
    }
  }
}
