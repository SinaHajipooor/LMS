import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms/http/api.dart';

class LandingProvider with ChangeNotifier {
// ---------------- feilds ------------------
  static final _baseUrl = '${Api.instance.baseUrl}8081/api/landing';
  List _slides = [];
  List _news = [];
  List _announcements = [];
  List _teachers = [];
  List _tms = [];
// ---------------- getter ------------------
  List get slides => _slides;
  List get news => _news;
  List get announcements => _announcements;
  List get teachers => _teachers;
  List get tms => _tms;
// ---------------- methods ------------------
  Future<void> fetchLandingData() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('Failed to fetch landing data');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _slides = responseData?['result']?['slides'];
      _news = responseData?['result']?['news'];
      _announcements = responseData?['result']?['announcements'];
      _teachers = responseData?['result']?['teachers'];
      _tms = responseData?['result']?['tms'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
