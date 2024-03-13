import 'dart:convert';

import 'package:flutter_store/models/product_model.dart';
import 'package:flutter_store/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallAPI {

  // สร้างตัวแปรเก็บ Token
  static String _token = '';

  // สร้างฟังก์ชันอ่าน Token จาก SharedPreferences
  static _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
  }

  // Set Headers for login / register
  _setHeaders() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Set Headers with Token
  _setHeadersWithToken() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
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

  // ---------------------------------------------------------------------------
  // CRUD Product API
  // ---------------------------------------------------------------------------
  // Get All Products API
  Future<List<ProductModel>> getAllProducts() async {
    await _getToken();
    final response = await http.get(
      Uri.parse('${baseURLAPI}products'),
      headers: _setHeadersWithToken(),
    );
    if(response.body.isNotEmpty) {
      return productModelFromJson(response.body);
    } else {
      return [];
    }
  }

}