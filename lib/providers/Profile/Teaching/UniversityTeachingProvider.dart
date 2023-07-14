import 'dart:convert';

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
  Map<String, dynamic>? get universityTeachingDetails => _universityTeachingDetails!;
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
}
