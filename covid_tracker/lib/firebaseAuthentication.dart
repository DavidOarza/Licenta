import 'package:firebase_auth/firebase_auth.dart';

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  weakPassword,
  undefined,
}

class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthResultStatus.weakPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.successful:
        errorMessage = "";
        break;
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.weakPassword:
        errorMessage = "Password must have at leas 6 characters";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "The email has already been registered.";
        break;
      default:
        errorMessage = "";
    }

    return errorMessage;
  }
}

class FirebaseAuthHelper {
  final _auth = FirebaseAuth.instance;

  AuthResultStatus _status;
  String error = "";


  Future<String> createAccount(email, pass) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (authResult.user != null) {

        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      String error = e.code;
      print('Exception @createAccount: $error');
      _status = AuthExceptionHandler.handleException(e);
    }
    error = AuthExceptionHandler.generateExceptionMessage(_status);
    return error;
  }

  Future<String> login(email, pass) async {
    try {
      final authResult =
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (authResult.user != null) {

        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      String error = e.code;
      print('Exception @login: $error');
      _status = AuthExceptionHandler.handleException(e);
    }

      error = AuthExceptionHandler.generateExceptionMessage(_status);

    return error;
  }

  logout() {
    _auth.signOut();
  }
}