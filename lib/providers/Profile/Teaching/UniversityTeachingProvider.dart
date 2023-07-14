import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UniversityTeachingProvider with ChangeNotifier {
  // ---------------- feilds ----------------
  static const _baseUrl = 'http://45.149.77.156:8081/api/profile/teach/university';
  List _universityTeachings = [];
  Map<String, dynamic>? _universityTeachingDetails;
  // ---------------- getter ----------------
  List get universityTeachings => _universityTeachings;
  Map<String, dynamic> get universityTeachingDetails => _universityTeachingDetails!;
  // ---------------- methods ----------------

  Future<void> fetchAllUniversityTeachings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final response = await http.get(
        Uri.parse(_baseUrl + '?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch all university teachings');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _universityTeachings = responseData?['result']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchUniversityTeachingDetails(int universityTeachingId) async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl + '/show/$universityTeachingId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch university twaching details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _universityTeachingDetails = responseData?['result'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addUniversityTeaching(Map<String, dynamic> universityTeachingInfo, File file) async {
    var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + '/store'));
    request.fields['user_id'] = universityTeachingInfo['user_id'];
    request.fields['title'] = universityTeachingInfo['title'];
    request.fields['start_date'] = universityTeachingInfo['start_date'];
    request.fields['end_date'] = universityTeachingInfo['end_date'];
    request.fields['activity_description'] = universityTeachingInfo['activity_description'];
    request.fields['status'] = universityTeachingInfo['status'];
    request.fields['is_related'] = universityTeachingInfo['is_related'];
    request.fields['is_current'] = universityTeachingInfo['is_current'];
    request.fields['academic_field_id'] = '1';

    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();
    // Get the response
    if (response.statusCode == 200) {
      print('university teaching added successfully');
      notifyListeners();
    } else {
      throw Exception('Failed to add university teaching');
    }
  }

  Future<void> editUniversityTeaching(int universityTeachingId, Map<String, dynamic> universityTeachingInfo, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + '/update/$universityTeachingId'));
      request.fields['_method'] = 'put';
      request.fields['user_id'] = universityTeachingInfo['user_id'];
      request.fields['title'] = universityTeachingInfo['title'];
      request.fields['start_date'] = universityTeachingInfo['start_date'];
      request.fields['end_date'] = universityTeachingInfo['end_date'];
      request.fields['activity_description'] = universityTeachingInfo['activity_description'];
      request.fields['status'] = universityTeachingInfo['status'];
      request.fields['is_related'] = universityTeachingInfo['is_related'];
      request.fields['is_current'] = universityTeachingInfo['is_current'];
      request.fields['academic_field_id'] = '1';

      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      var response = await request.send();
      // Get the response
      if (response.statusCode == 200) {
        print('university teaching0 added successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to add university teaching');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteUniversityTeaching(int universityTeachingId) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl + '/destroy/$universityTeachingId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to delete university teaching');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
