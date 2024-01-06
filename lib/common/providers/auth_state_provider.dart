import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthStateProvider extends ChangeNotifier {
  AuthCredential? _authData;
  User? _userData;
  AdditionalUserInfo? _additionalData;

  AuthCredential? get authData => _authData;
  User? get userData => _userData;
  AdditionalUserInfo? get additionalData => _additionalData;

  bool get isLoggedIn => _userData != null;

  void updateAuthData(AuthCredential? data) {
    _authData = data;
    notifyListeners();
  }

  void updateUserData(User? data) {
    _userData = data;
    notifyListeners();
  }

  void updateAdditionalData(AdditionalUserInfo? data) {
    _additionalData = data;
    notifyListeners();
  }
}
