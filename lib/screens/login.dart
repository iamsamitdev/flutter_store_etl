// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/services/rest_api.dart';
import 'package:flutter_store/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // สร้าง key สำหรับ form
  final _formLoginKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้เก็บค่า email และ password
  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryLight, primary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/images/login.png',
                        width: 75,
                      ),
                      SizedBox(height: 30),
                      Form(
                        key: _formLoginKey,
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: 'somjai@email.com',
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: primary,
                                    width: 2
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _email = value!.trim();
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              initialValue: '123456',
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color: primary,
                                    width: 2
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!.trim();
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                // เช็คการ validate ของ form
                                if(_formLoginKey.currentState!.validate()){
                                  // ถ้า validate ผ่าน ให้ทำการ save ค่าของ form
                                  _formLoginKey.currentState!.save();
                                  // แสดงค่าที่ได้จากการ save ของ form
                                  // print('Email: $_email');
                                  // print('Password: $_password');

                                  // เช็คว่าเชื่อมต่อ Internet หรือไม่
                                  final connectivityResult = await (Connectivity().checkConnectivity());

                                  if (connectivityResult != ConnectivityResult.none) {

                                    var response = await CallAPI().loginAPI(
                                      {
                                        'email': _email,
                                        'password': _password,
                                      }
                                    );

                                    var body = jsonDecode(response.body);
                                    // print(body);

                                    // ถ้า login สำเร็จ
                                    if(body['status'] == 'ok'){
                                      // login success
                                      // แสดง popup แจ้งเตือน
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text('Login success'),
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      
                                      // บันทึกข้อมูลการ login ลงในเครื่อง
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('token', body['token']);
                                      prefs.setString('firstname', body['user']['firstname']);
                                      prefs.setString('lastname', body['user']['lastname']);
                                      prefs.setString('email', body['user']['email']);
                                      prefs.setBool('isLogin', true);

                                      // ส่งไปหน้า Dashboard
                                      Navigator.pushReplacementNamed(context, AppRouter.dashboard);
                                      
                                    } else {
                                      // login fail
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text('Login fail'),
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }

                                  } else {
                                    // ถ้าไม่ได้เชื่อมต่อ Internet
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text('No Internet connection'),
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)
                                )
                              ),
                              child: Text('Login', style: TextStyle(fontSize: 20),),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Don\'t have an account?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, 'register');
                                  },
                                  child: Text('Register'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}