import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms/http/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExternalPassedCoursesProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static final _externalCoursesUrl = '${Api.instance.baseUrl}8081/api/profile/course/external';
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
        Uri.parse('$_externalCoursesUrl?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch the external passed courses index');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _externalCourses = responseData?['result']?['data'];

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchExternalCourseDetails(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      final response = await http.get(
        Uri.parse('$_externalCoursesUrl/show/$id?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch external ccourse details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _externalCourseDetails = responseData?['result'];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addExternalCourse(Map<String, dynamic> externalCourseInfo, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$_externalCoursesUrl/store'));

      // Add other fields to the request if needed
      request.fields['user_id'] = externalCourseInfo['user_id'];
      request.fields['title'] = externalCourseInfo['title'];
      request.fields['address'] = externalCourseInfo['address'];
      request.fields['start_date'] = externalCourseInfo['start_date'];
      request.fields['end_date'] = externalCourseInfo['end_date'];
      request.fields['duration'] = externalCourseInfo['duration'];
      request.fields['institute_title'] = externalCourseInfo['institute_title'];
      request.fields['has_certificate'] = externalCourseInfo['has_certificate'].toString();
      request.fields['status'] = externalCourseInfo['status'].toString();
      request.fields['is_related'] = externalCourseInfo['is_related'].toString();

      // Add file to the request
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      // Send the request
      var response = await request.send();

      // Get the response
      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Exception('Failed to add external course');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editExternalCourse(int id, Map<String, dynamic> externalCourseInfo, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$_externalCoursesUrl/update/$id'));
      // Add other fields to the request if needed
      request.fields['_method'] = 'put';
      request.fields['user_id'] = externalCourseInfo['user_id'];
      request.fields['title'] = externalCourseInfo['title'];
      request.fields['address'] = externalCourseInfo['address'];
      request.fields['start_date'] = externalCourseInfo['start_date'];
      request.fields['end_date'] = externalCourseInfo['end_date'];
      request.fields['duration'] = externalCourseInfo['duration'];
      request.fields['institute_title'] = externalCourseInfo['institute_title'];
      request.fields['has_certificate'] = externalCourseInfo['has_certificate'].toString();
      request.fields['status'] = externalCourseInfo['status'].toString();
      request.fields['is_related'] = externalCourseInfo['is_related'].toString();
      // Add file to the request
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      // Send the request
      var response = await request.send();
      // Get the response
      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        // throw Exception('Failed to edit external course');

        // print(response.statusCode);
        // print(await response.stream.bytesToString());
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteExternalCourse(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$_externalCoursesUrl/destroy/$id'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to delete external course');
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
