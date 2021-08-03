import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../services/snackbar.dart';
import '../services/navigation.dart';
import '../services/database.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {
  late User user;
  AuthStatus status = AuthStatus.NotAuthenticated;

  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _checkCurrentUserIsAuthenticated();
    // status = AuthStatus.Authenticating;
  }

  void _autoLogin() async {
    await DBService.instance.updateUserLastSeenTime(user.uid);
    return NavigationService.instance.navigateToReplacement("home");
  }

  void _checkCurrentUserIsAuthenticated() async {
    user = _auth.currentUser!;
    if (user != null) {
      notifyListeners();
      _autoLogin();
    }
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user!;
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess("Welcome, ${user.email}");
      await DBService.instance.updateUserLastSeenTime(user.uid);
      NavigationService.instance.navigateToReplacement("home");
    } catch (e) {
      print(e);
      status = AuthStatus.Error;
      //user = null;
      SnackBarService.instance.showSnackBarError("Error Authenticating");
    }
    notifyListeners();
  }

  void registerUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user!;
      status = AuthStatus.Authenticated;
      await onSuccess(user.uid);
      SnackBarService.instance.showSnackBarSuccess("Welcome, ${user.email}");
      await DBService.instance.updateUserLastSeenTime(user.uid);
      NavigationService.instance.goBack();
      NavigationService.instance.navigateToReplacement("home");
    } catch (e) {
      print(e);
      status = AuthStatus.Error;
      // user = null;
      SnackBarService.instance.showSnackBarError("Error Registering User");
    }
    notifyListeners();
  }

  void logoutUser(Future<void> onSuccess()) async {
    try {
      await _auth.signOut();
      // user = null;
      status = AuthStatus.NotAuthenticated;
      await onSuccess();
      await NavigationService.instance.navigateToReplacement("login");
      SnackBarService.instance.showSnackBarSuccess("Logged Out Successfully!");
    } catch (e) {
      SnackBarService.instance.showSnackBarError("Error Logging Out");
    }
    notifyListeners();
  }
}
