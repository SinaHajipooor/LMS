import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CourseProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static const _baseUrl = 'http://45.149.77.156:8082/api/course/electronic';
  static const _courseDetailUrl = 'http://45.149.77.156:8082/api/course/electronic/show';
  static const _courseShippingUrl = 'http://45.149.77.156:8082/api/course/electronic/shipping';

  List _courses = [];
  Map<String, dynamic>? _courseDetails;
  Map<String, dynamic>? _courseShippingDetails;
  List _coursePaymentGateways = [];
  List _courseAssessmentQuestions = [];
  List _courseAssessmentAnswers = [];

  // ------------------- getter --------------------

  List get courses => _courses;
  Map<String, dynamic> get courseDetails => _courseDetails!;
  Map<String, dynamic> get courseShippingDetails => _courseShippingDetails!;
  List get coursePaymentGateways => _coursePaymentGateways;
  List get courseAssessmentQuestions => _courseAssessmentQuestions;
  List get courseAssessmentAnswers => _courseAssessmentAnswers;
  // ------------------- methods --------------------

  Future<void> fetchAllCourses() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('Failed to fetch all courses');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _courses = responseData?['result']['courses']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchCourseDetails(int courseId) async {
    try {
      final response = await http.get(
        Uri.parse(_courseDetailUrl + '/$courseId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('Failed to get the course details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _courseDetails = responseData?['result']?['course'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchCourseShippingDetails(int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      final response = await http.get(
        Uri.parse(_courseShippingUrl + '/$courseId?student_id=' + userId!),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to get the course shipping details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _courseShippingDetails = responseData?['result']?['course'];
      _coursePaymentGateways = responseData?['result']?['gateways'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchCourseAssessmentDetails(int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final courseAssessmentUrl = _courseDetailUrl + '/$courseId/survey/$userId';
    try {
      final response = await http.get(
        Uri.parse(courseAssessmentUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to get the course assessment details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _courseAssessmentQuestions = responseData?['result']['questions'];
      _courseAssessmentAnswers = responseData?['result']['answers'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> saveCourseAssessmentAnswers() async {}
}
