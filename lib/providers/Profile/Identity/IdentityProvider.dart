import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms/http/api.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class IdentityProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static final _baseUrl = '${Api.instance.baseUrl}8081/api/profile/identity';
  Map<String, dynamic>? _identityInfo;
  // ------------------- getter --------------------
  Map<String, dynamic> get identityInfo => _identityInfo!;
  // ------------------- methods --------------------

  Future<void> fetchAllIdentityInfo() async {
    try {
      // final prefs = await SharedPreferences.getInstance();
      // final userId = prefs.getString('userId');
      final response = await http.get(
        Uri.parse('$_baseUrl?user_id=103'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch all identity info');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _identityInfo = responseData?['result'];
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
