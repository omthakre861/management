import 'package:firebase_auth/firebase_auth.dart';
import 'package:management/database/auth_exception.dart';


/// Auth class contains Authentication methods  
class Auth {
  late AuthResultStatus _status;

  /// Create a new user account with the given email address and password
  Future<AuthResultStatus> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  /// Sign in a user with the given email address and password.
  Future<AuthResultStatus> signIn(String email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  /// Signs out current user
  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
