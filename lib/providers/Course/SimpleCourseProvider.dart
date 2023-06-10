import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SimpleCourseProvider with ChangeNotifier {
  // ------------ feilds ---------------
  static const _basUrl = 'http://45.149.77.156:8082/api/course/simple';
  static const _courseDetailUrl = 'http://45.149.77.156:8082/api/course/simple/show';
  static const _courseShippingUrl = 'http://45.149.77.156:8082/api/course/simple/shipping';
  List _allSimpleCourses = [];
  List _courseGroup = [];
  Map<String, dynamic>? _courseDetails;
  Map<String, dynamic>? _courseShippingDetails;
  //------------ getter ---------------
  List get allSimpleCourses => _allSimpleCourses;
  List get courseGroups => _courseGroup;
  Map<String, dynamic> get courseDetails => _courseDetails!;
  Map<String, dynamic> get courseShippingDetails => _courseShippingDetails!;
  //------------ method --------------
  Future<void> fetchAllSimpleCourses() async {
    try {
      final response = await http.get(
        Uri.parse(_basUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch simple courses list');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _allSimpleCourses = responseData?['result']['courses']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchSimpleCourseDetails(int courseId) async {
    try {
      final response = await http.get(
        Uri.parse(_courseDetailUrl + '/$courseId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch simple course detail ');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _courseDetails = responseData?['result']?['course'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchSimpleCourseShippingDetails(int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    try {
      final response = await http.get(
        Uri.parse(_courseShippingUrl + '/$courseId?student_id=' + userId!),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch simple course shipping details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _courseShippingDetails = responseData?['result']['course'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchSimpleCourseGroups() async {
    try {
      final response = await http.get(
        Uri.parse(_basUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch simple course group list');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _courseGroup = responseData?['result']['course_groups'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List<dynamic>> fetchSimpleCoursesByGroupId(int groupId) async {
    try {
      final response = await http.get(
        Uri.parse(_basUrl + '?group_id=$groupId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch the simple courses by group');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      notifyListeners();
      return responseData?['result']['courses']['data'];
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
