import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static const _baseUrl = 'http://192.168.2.136:81/api/profile/';
  static const _externalCoursesUrl = _baseUrl + 'course/external';
  List _externalCourses = [];
  // ------------------- getter --------------------
  List get externalCourses => _externalCourses;

  // ------------------- methods --------------------
  Future<void> fetchAllExternalCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      final response = await http.get(
        Uri.parse(_externalCoursesUrl + '?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch the external passed courses index');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _externalCourses = responseData?['result']?['data'];

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
