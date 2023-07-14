import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NonUniversityTeachingProvider with ChangeNotifier {
  // ---------------  feilds -----------------
  static const _baseUrl = 'http://45.149.77.156:8081/api/profile/teach/history';
  List _nonUniversityTeachings = [];
  Map<String, dynamic>? _nonUniversityTeachingDetails;
  // ---------------  getter -----------------
  List get nonUniversityTeachings => _nonUniversityTeachings;
  Map<String, dynamic> get nonUniverstyTeachingDetails => _nonUniversityTeachingDetails!;
  // ---------------  methods -----------------
  Future<void> fetchAllNonUniversityTeachings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final respons = await http.get(
        Uri.parse(_baseUrl + '?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (respons.statusCode != 200) throw Exception('failed to fetch all the non universuity teachings ');
      final Map<String, dynamic>? responseData = jsonDecode(respons.body) as Map<String, dynamic>?;
      _nonUniversityTeachings = responseData?['result']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
