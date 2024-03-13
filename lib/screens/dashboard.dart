// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_store/screens/bottommenu/home.dart';
import 'package:flutter_store/screens/bottommenu/notification.dart';
import 'package:flutter_store/screens/bottommenu/profile.dart';
import 'package:flutter_store/screens/bottommenu/report.dart';
import 'package:flutter_store/screens/bottommenu/setting.dart';
import 'package:flutter_store/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // ส่วนของการกำหนด BottomNavigationBar ------
  // กำหนดตัวแปรเพื่อเก็บค่า index ของแต่ละหน้า
  int _currentIndex = 0;

  // สร้างตัวแปรเก็บ title ของแต่ละหน้า
  String _title = 'Flutter Store';

  // สร้าง List ของหน้าที่ต้องการเปลี่ยนไป
  final List<Widget> _children = [
    Home(),
    Report(),
    Notificationpage(),
    Setting(),
    Profile()
  ];

  // สร้างฟังก์ชันเพื่อเปลี่ยนหน้า
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0: _title = 'Home'; break;
        case 1: _title = 'Report'; break;
        case 2: _title = 'Notification'; break;
        case 3: _title = 'Setting'; break;
        case 4: _title = 'Profile'; break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLogin', false);
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          onTabTapped(index);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: icons,
        unselectedItemColor: divider,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 24),
        backgroundColor: primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: 'Report'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notification'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile'
          ),
        ]
      ),
    );
  }
}