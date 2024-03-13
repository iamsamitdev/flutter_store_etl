// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item $index'),
                Text('Description $index'),
                Text('Price $index'),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              print('Item $index');
            },
          );
        },
      ),
    );
  }
}
