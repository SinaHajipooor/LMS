import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms/http/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class JobProvider with ChangeNotifier {
  // --------------- feilds ---------------
  static final _baseUrl = '${Api.instance.baseUrl}8081';
  List _jobs = [];
  Map<String, dynamic>? _jobDetails;
  // --------------- getter ---------------
  List get jobs => _jobs;
  Map<String, dynamic> get jobDetails => _jobDetails!;
  // --------------- methods ---------------
  Future<void> fetchAllJobs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final response = await http.get(
        Uri.parse('$_baseUrl?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch all jobs');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _jobs = responseData?['result']?['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
