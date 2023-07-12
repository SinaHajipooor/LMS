import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExternalPassedCoursesProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static const _baseUrl = 'http://192.168.2.136:81/api/profile/';
  static const _externalCoursesUrl = _baseUrl + 'course/external';
  List _externalCourses = [];
  Map<String, dynamic>? _externalCourseDetails;
  // ------------------- getter --------------------
  List get externalCourses => _externalCourses;
  Map<String, dynamic> get externalCourseDetails => _externalCourseDetails!;
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

  Future<void> fetchExternalCourseDetails(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      final response = await http.get(
        Uri.parse(_externalCoursesUrl + '/show/$id?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch external ccourse details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _externalCourseDetails = responseData?['result'];
      print('external course detail id : ${_externalCourseDetails?['id']}');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addExternalCourse(Map<String, dynamic> externalCourseInfo) async {
    try {
      final response = await http.post(
        Uri.parse(_externalCoursesUrl + '/store'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(externalCourseInfo),
      );
      if (response.statusCode != 200) throw Exception('failed ro add external course');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> editExternalCourse(int id, Map<String, dynamic> externalCourseInfo) async {
    try {
      final response = await http.put(
        Uri.parse(_externalCoursesUrl + '/update/$id'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(externalCourseInfo),
      );
      if (response.statusCode != 200) throw Exception('failded to update external course');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
