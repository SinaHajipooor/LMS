import 'dart:convert';

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
