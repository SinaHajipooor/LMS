import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms/http/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ElectronicCourseProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static final _baseUrl = '${Api.instance.baseUrl}8082/api/course/electronic';
  static final _courseDetailUrl = '${Api.instance.baseUrl}8082/api/course/electronic/show';
  static final _courseShippingUrl = '${Api.instance.baseUrl}8082/api/course/electronic/shipping';
  List _allCourses = [];
  List _courseGroups = [];
  Map<String, dynamic>? _courseDetails;
  Map<String, dynamic>? _courseShippingDetails;
  List _coursePaymentGateways = [];
  List _courseAssessmentQuestions = [];
  List _courseAssessmentAnswers = [];

  // ------------------- getter --------------------

  List get allCourses => _allCourses;
  List get courseGroups => _courseGroups;
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
      _allCourses = responseData?['result']['courses']['data'];
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

  Future<void> fetchElectronicCourseGroups() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch the electronic course groups');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _courseGroups = responseData?['result']['course_groups'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<dynamic>> fetchElectronicCoursesByGroupId(int groupId) async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl + '?group_id=$groupId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch electronic courses by group id');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      notifyListeners();
      return responseData?['result']['courses']['data'];
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
