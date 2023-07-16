import 'dart:convert';

import 'package:flutter/material.dart';
import 'auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  // ---------------- feilds ------------------
  String? _token;
  String? _otpToken;
  int? _userId;
  // ---------------- getter ------------------
  bool get isAuth => _token != null;
  String? get token => _token;
  int? get userId => _userId;
  // ---------------- methods ------------------

  Future<void> loadSavedToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }

  Future<void> userPassLogin(Map<String, dynamic> userData) async {
    try {
      String loginUrl = AuthApi.instance.userPassLoginUrl;
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
          {'username': userData['username'], 'password': userData['password']},
        ),
      );
      if (response.statusCode != 200) throw Exception('Failed to login with userpass');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _token = responseData?['result']?['token'];
      _userId = responseData?['result']?['user']?['id'];
      // store user data in device storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token!);
      prefs.setString('userId', _userId.toString());
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> mobileLogin(String mobile) async {
    try {
      String loginUrl = AuthApi.instance.mobileLoginUrl;
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': mobile}),
      );
      if (response.statusCode != 200) throw Exception('Failed to login with mobile');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _otpToken = responseData?['result']?['token'];

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> mobileConfirmLogin(String otpCode) async {
    try {
      String confirmLoginUrl = AuthApi.instance.mobileConfirmUrl;
      final response = await http.post(
        Uri.parse(confirmLoginUrl + '/' + _otpToken!),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode({'otp': '11111'}),
      );
      if (response.statusCode != 200) throw Exception('Failed to login with mobile');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _token = responseData?['result']?['token'];
      _userId = responseData?['result']?['user']?['id'];
// store the user data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token!);
      prefs.setString('userId', _userId.toString());

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
    _token = null;
  }
}
