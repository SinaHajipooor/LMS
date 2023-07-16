import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms/http/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NonUniversityTeachingProvider with ChangeNotifier {
  // ---------------  feilds -----------------
  static final _baseUrl = '${Api.instance.baseUrl}81/api/profile/teach/history';
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

  Future<void> fetchNonUniversityTeachingDetails(int nonUniversityTeachingId) async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl + '/show/$nonUniversityTeachingId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch non university teaching details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _nonUniversityTeachingDetails = responseData?['result'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addNonUniversityTeaching(Map<String, dynamic> nonUniversityTeachingInfo, File file) async {
    var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + '/store'));
    request.fields['user_id'] = nonUniversityTeachingInfo['user_id'];
    request.fields['title'] = nonUniversityTeachingInfo['title'];
    request.fields['start_date'] = nonUniversityTeachingInfo['start_date'];
    request.fields['activity_description'] = nonUniversityTeachingInfo['activity_description'];
    request.fields['status'] = nonUniversityTeachingInfo['status'];
    request.fields['end_date'] = nonUniversityTeachingInfo['end_date'];
    request.fields['is_related'] = nonUniversityTeachingInfo['is_related'];
    request.fields['is_current'] = nonUniversityTeachingInfo['is_current'];

    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();
    // Get the response
    if (response.statusCode == 200) {
      print('non university teaching added successfully');
      notifyListeners();
    } else {
      throw Exception('Failed to add non university teaching');
    }
  }

  Future<void> editNonUniversityTeaching(int nonUniversityTeachingId, Map<String, dynamic> nonUniversityTeachingInfo, File file) async {
    var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + '/update/$nonUniversityTeachingId'));
    request.fields['_method'] = 'put';
    request.fields['user_id'] = nonUniversityTeachingInfo['user_id'];
    request.fields['title'] = nonUniversityTeachingInfo['title'];
    request.fields['start_date'] = nonUniversityTeachingInfo['start_date'];
    request.fields['activity_description'] = nonUniversityTeachingInfo['activity_description'];
    request.fields['status'] = nonUniversityTeachingInfo['status'];
    request.fields['end_date'] = nonUniversityTeachingInfo['end_date'];
    request.fields['is_related'] = nonUniversityTeachingInfo['is_related'];
    request.fields['is_current'] = nonUniversityTeachingInfo['is_current'];

    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();
    // Get the response
    if (response.statusCode == 200) {
      print('non university teaching edited successfully');
      notifyListeners();
    } else {
      throw Exception('Failed to edit non university teaching');
    }
  }

  Future<void> deleteNonUniversityTeaching(int nonUniversityTeachingId) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl + '/destroy/$nonUniversityTeachingId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to delete non university teaching');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
