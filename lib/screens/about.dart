// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            // ไปหน้า contact
            Navigator.pushNamed(context, AppRouter.contact);
          },
          child: Text('Go to Contact'),
        )
      ),
    );
  }
}