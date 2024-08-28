import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider({required this.prefs}) {
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  final SharedPreferences prefs;
  final Dio _dio = Dio();
  String? errorMessage;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    try {
      final response = await _dio.get(
        'https://669f6598b132e2c136fdb292.mockapi.io/api/v1/products/registration',
      );

      final List<dynamic> users = response.data;

      final user = users.firstWhere(
        (user) => user['username'] == username && user['password'] == password,
        orElse: () => null,
      );

      if (user != null) {
        _isLoggedIn = true;
        await prefs.setBool('isLoggedIn', true);
        errorMessage = null;
      } else {
        errorMessage = 'Invalid username or password';
        throw Exception(errorMessage);
      }
    } catch (e) {
      errorMessage = 'An error occurred during login: $e';
      notifyListeners();
      throw Exception(errorMessage);
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    await prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }
}
