import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeachersPanelProvider with ChangeNotifier {
  // --------------- feilds ------------------
  // static const _baseUrl = '';
  static const _teacherCurrentCoursesUrl = '';
  static const _allTeacherCoursesUrl = '';
  List _teacherCurrentCourses = [];
  List _allTeacherCourses = [];
  // --------------- getter ------------------
  List get teacherCurrentCourses => _teacherCurrentCourses;
  List get allTeacherCourses => _allTeacherCourses;
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

  Future<void> fetchAllTeacherCourses() async {
    try {
      final response = await http.get(
        Uri.parse(_allTeacherCoursesUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('Failed to fetch all teachers courses');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _allTeacherCourses = responseData?['result']['courses']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
