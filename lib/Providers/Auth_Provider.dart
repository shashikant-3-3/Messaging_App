import 'package:flutter/material.dart';



import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/services/navigation.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {

  late User user;

  late AuthStatus status;
  late FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider (){
     _auth = FirebaseAuth.instance;
     status = AuthStatus.NotAuthenticated;
  }
  
  
  void loginUserWithEmailAndPassword(String _email, String _password)async{
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      user = _result.user!;
      status = AuthStatus.Authenticated;
      NavigationService.instance.navigateToReplacement("home");
    } catch (e) {
      status = AuthStatus.Error;
    }
    notifyListeners();
  }

  void registerUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async{
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
      user = _result.user!;
      status = AuthStatus.Authenticated;
      await onSuccess(user.uid);
      NavigationService.instance.goBack();
      NavigationService.instance.navigateToReplacement("home");
    } catch (e) {
      status = AuthStatus.Error;
    }
    notifyListeners();
  }
}