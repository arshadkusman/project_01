import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/models/user_model.dart';

class UserProvider with ChangeNotifier {
  final Dio _dio = Dio();
  User? _user;

  User? get user => _user;

  Future<void> register(User user) async {
    try {
      final response = await _dio.post(
          'https://669f6598b132e2c136fdb292.mockapi.io/api/v1/products/registration',
          data: user.toJson());
      _user = User.fromJson(response.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await _dio.get(
          'https://669f6598b132e2c136fdb292.mockapi.io/api/v1/products/registration',
          data: {
            'username': username,
            'password': password,
          });
      _user = User.fromJson(response.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
