import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeachersPanelProvider with ChangeNotifier {
  // --------------- feilds ------------------
  // static const _baseUrl = '';
  static const _teacherCurrentCoursesUrl = '';
  List _teacherCurrentCourses = [];
  // --------------- getter ------------------
  List get teacherCurrentCourses => _teacherCurrentCourses;
  // --------------- methods ------------------
  Future<void> fetchAllTeacherCurrentCourses() async {
    try {
      final response = await http.get(
        Uri.parse(_teacherCurrentCoursesUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('Failed to fetch all teacher current courses ');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _teacherCurrentCourses = responseData?['result']['courses']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
