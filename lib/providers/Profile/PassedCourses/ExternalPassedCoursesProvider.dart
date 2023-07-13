import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExternalPassedCoursesProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static const _baseUrl = 'http://45.149.77.156:8081/api/profile/';
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

  Future<void> addExternalCourse(Map<String, dynamic> externalCourseInfo, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_externalCoursesUrl + '/store'));

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
        print('External course added successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to add external course');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> editExternalCourse(int id, Map<String, dynamic> externalCourseInfo, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_externalCoursesUrl + '/update/$id'));
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      // Add other fields to the request if needed
      request.fields['_method'] = 'put';
      request.fields['user_id'] = userId!;
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
        print('External course edited successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to edit external course');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteExternalCourse(int id) async {
    try {
      final response = await http.delete(
        Uri.parse(_externalCoursesUrl + '/destroy/$id'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to delete external course');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
