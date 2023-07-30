import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms/http/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InternalPassedCoursesProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static final _baseUrl = '${Api.instance.baseUrl}8081/api/profile/course/internal';
  List<dynamic> _internalPassedCourses = [];
  // ------------------- getter --------------------
  List get internalPassedCourses => _internalPassedCourses;
  // ------------------- methods --------------------
  Future<void> fetchAllInternalPassedCourses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final response = await http.get(
        Uri.parse('$_baseUrl?student_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _internalPassedCourses = responseData?['result']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
