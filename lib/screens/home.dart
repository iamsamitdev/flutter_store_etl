// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าหลัก'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            // ส่งไปหน้า About
            Navigator.pushNamed(context, AppRouter.about);
          },
          child: Text('ไปหน้า About'),
        ),
      ),
    );
  }
}
