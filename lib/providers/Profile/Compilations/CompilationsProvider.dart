import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lms/http/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CompilationsProvider with ChangeNotifier {
  // ------------------ feilds -----------------
  static final _baseUrl = '${Api.instance.baseUrl}81/api/profile/compilation-record';
  List _compilations = [];
  Map<String, dynamic>? _compilationDetails;
  // ------------------ getter -----------------
  List get compilations => _compilations;
  Map<String, dynamic> get compilationDetails => _compilationDetails!;
  // ------------------ methods -----------------

  Future<void> fetchAllCompilations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      final response = await http.get(
        Uri.parse(_baseUrl + '?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch all compilations');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _compilations = responseData?['result']['data'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchCompilationDetails(int compilationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final response = await http.get(
        Uri.parse(_baseUrl + '/show/$compilationId?user_id=$userId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to fetch compilation details');
      final Map<String, dynamic>? responseData = jsonDecode(response.body) as Map<String, dynamic>?;
      _compilationDetails = responseData?['result'];
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addCompilation(Map<String, dynamic> compilationInfo, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + '/store'));
      request.fields['user_id'] = compilationInfo['user_id'];
      request.fields['compilation_type_id'] = compilationInfo['compilation_type_id'];
      request.fields['title'] = compilationInfo['title'];
      request.fields['language_id'] = compilationInfo['language_id'];
      request.fields['publish_place'] = compilationInfo['publish_place'];
      request.fields['year'] = compilationInfo['year'];
      request.fields['description'] = compilationInfo['description'];
      request.fields['status'] = compilationInfo['status'];
      request.fields['is_related'] = compilationInfo['is_related'];
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      // Send the request
      var response = await request.send();
      // Get the response
      if (response.statusCode == 200) {
        print('compilation added successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to add compilation course');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> editCompilation(int compilationId, Map<String, dynamic> compilationInfo, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_baseUrl + '/update/$compilationId'));
      request.fields['_method'] = 'put';
      request.fields['user_id'] = compilationInfo['user_id'];
      request.fields['compilation_type_id'] = compilationInfo['compilation_type_id'];
      request.fields['title'] = compilationInfo['title'];
      request.fields['language_id'] = compilationInfo['language_id'];
      request.fields['publish_place'] = compilationInfo['publish_place'];
      request.fields['year'] = compilationInfo['year'];
      request.fields['description'] = compilationInfo['description'];
      request.fields['status'] = compilationInfo['status'];
      request.fields['is_related'] = compilationInfo['is_related'];

      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      // Send the request
      var response = await request.send();
      // Get the response
      if (response.statusCode == 200) {
        print('compilation added successfully');
        notifyListeners();
      } else {
        throw Exception('Failed to add compilation course');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> deleteCompilation(int compilationId) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl + '/destroy/$compilationId'),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) throw Exception('failed to delete compilation');
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
