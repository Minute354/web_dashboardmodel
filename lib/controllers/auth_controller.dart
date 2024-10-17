import 'package:flutter/material.dart';
import 'package:school_web_app/services/api_services.dart';


class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _token;

  String? get token => _token; // Getter to access the token

  Future<bool> login(String email, String password) async {
    final String? token = await _authService.login(email, password);
    if (token != null) {
      _token = token;
      notifyListeners(); // Notify listeners when token is updated
      return true;
    } else {
      return false; // Login failed
    }
  }

  void logout() {
    _token = null;
    notifyListeners(); // Notify listeners on logout
  }
}
