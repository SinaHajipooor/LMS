import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ActivityHistoryProvider with ChangeNotifier {
  // ------------------- feilds --------------------
  static const _baseUrl = 'http://192.168.2.136:81/api/profile/activity-history';
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
}
