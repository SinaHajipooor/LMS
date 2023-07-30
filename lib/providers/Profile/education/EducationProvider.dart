import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lms/http/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EducationProvider with ChangeNotifier {
  // ------------------ feilds ------------------
  static final _baseUrl = '${Api.instance.baseUrl}8081';
  List _educations = [];
  Map<String, dynamic>? _educationDetails;
  // ------------------ getter ------------------
  List get educations => _educations;
  Map<String, dynamic> get educationDetails => _educationDetails!;
  // ------------------ methods ------------------
  Future<void> fetchAllEducationDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final response = await http.get(
        Uri.parse('$_baseUrl?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch all educations');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _educations = responseData?['result']?['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchEducationDetails(int eduactionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final response = await http.get(
        Uri.parse('$_baseUrl/show/$eduactionId?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch education details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _educationDetails = responseData?['result'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteEducation(int edicationId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/destroy/$edicationId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to delete education');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
