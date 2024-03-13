import 'dart:convert';

import 'package:flutter_store/utils/constants.dart';
import 'package:http/http.dart' as http;

class CallAPI {

  // Set Headers for login / register
  _setHeaders() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Register User API
  registerAPI(data) async {
    return await http.post(
      Uri.parse('${baseURLAPI}auth/register'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // Login User API
  loginAPI(data) async {
    return await http.post(
      Uri.parse('${baseURLAPI}auth/login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

}