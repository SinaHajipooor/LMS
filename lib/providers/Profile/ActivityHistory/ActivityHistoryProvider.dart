import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ActivityHistoryProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static const _baseUrl = 'http://45.149.77.156:8081/api/profile/activity-history';
  List _activities = [];
  Map<String, dynamic>? _activityDetails;
  // ------------------- getter --------------------
  List get activities => _activities;
  Map<String, dynamic> get activityDetails => _activityDetails!;
  // ------------------- methods --------------------
  Future<void> fetchAllActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      final response = await http.get(
        Uri.parse(_baseUrl + '?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch all activities');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _activities = responseData?['result']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchActivityDetails(int activityId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      final response = await http.get(
        Uri.parse(_baseUrl + '/show/$activityId?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch activity details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _activityDetails = responseData?['result'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addActivity(Map<String, dynamic> activityInfo, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + '/store'));

      request.fields['user_id'] = activityInfo['user_id'];
      request.fields['title'] = activityInfo['title'];
      request.fields['institute_title'] = 'nothing';
      request.fields['has_certificate'] = '0';
      request.fields['address'] = activityInfo['address'];
      request.fields['start_date'] = activityInfo['start_date'];
      request.fields['end_date'] = activityInfo['end_date'];
      request.fields['position'] = activityInfo['position'];
      request.fields['status'] = activityInfo['status'];
      request.fields['is_related'] = activityInfo['is_related'];
      request.fields['current_position'] = activityInfo['current_position'];
      request.fields['work_type_id'] = activityInfo['work_type_id'];

      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      // Send the request
      var response = await request.send();

      // Get the response
      if (response.statusCode == 200) {
        print('activity added successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to add external course');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteActivity(int activityId) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl + '/destroy/$activityId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to delete activity ');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
