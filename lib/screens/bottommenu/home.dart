// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/models/product_model.dart';
import 'package:flutter_store/services/rest_api.dart';
import 'package:flutter_store/themes/colors.dart';
import 'package:flutter_store/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Test Call getAllProducts API
  // void getAllProducts() async {
  //   var data = await CallAPI().getAllProducts();
  //   var jsonData = jsonEncode(data);
  //   print(jsonData);
  // }

  @override
  void initState() {
    super.initState();
    // getAllProducts();
  }

  // ตัวแปรสำหรับสลับระหว่าง ListView และ GridView
  bool _isListView = true;

  // สร้างเมธอดสำหรับสลับระหว่าง ListView และ GridView
  void _toggleView() {
    setState(() {
      _isListView = !_isListView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _toggleView();
          },
          icon: Icon(
            _isListView ? Icons.grid_view : Icons.view_list,          ),
        ),
      ),
      body: FutureBuilder(
        future: CallAPI().getAllProducts(), 
        builder: (context, AsyncSnapshot snapshot) {
          // Loading... กำลังโหลดข้อมูล
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Load complete ข้อมูลเสร็จแล้ว
            if(snapshot.hasData) {
              // อ่่านค่าจาก API สำเร็จ แล้วส่งค่ามาใส่ใน model
              List<ProductModel> products = snapshot.data;
              return _isListView ? _listView(products) : _gridView(products);
            } else {
              // ถ้าไม่มีข้อมูล
              return const Center(child: Text('No Data'));
            }
          }
        }
      )
    );
  }

  // _listView Widget ---------------------
  Widget _listView(List<ProductModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {

        ProductModel product = products[index];

        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: SizedBox(
            height: 350,
            child: InkWell(
              onTap: () {
                // print('You tapped on: ${product.id}');
                Navigator.pushNamed(
                  context, 
                  AppRouter.productDetail,
                  arguments: { 'product': product.toJson() }
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2, 2),
                      blurRadius: 3.0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    product.image == null
                      ? Image.asset(
                          'assets/images/noavartar.png',
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '$baseURLImage${product.image}',
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name.toString(), 
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                '${product.price} THB',
                                style: const TextStyle(fontSize: 18, color: primary),
                              ),
                              const Spacer(),
                              Text(
                                'Stock: ${product.stock}',
                                style: const TextStyle(fontSize: 18, color: primaryDark),
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
        );
      }
    );
  }

  // _gridView Widget ---------------------
  Widget _gridView(List<ProductModel> products) {
    return GridView.builder(
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index){

        ProductModel product = products[index];

        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: SizedBox(
            child: InkWell(
              onTap: () {
                // print('You tapped on: ${product.id}');
                Navigator.pushNamed(
                  context, 
                  AppRouter.productDetail,
                  arguments: { 'product': product.toJson() }
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2, 2),
                      blurRadius: 3.0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    product.image == null
                      ? Image.asset(
                          'assets/images/noavartar.png',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '$baseURLImage${product.image}',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text('${product.price} THB',),
                              const Spacer(),
                              Text('Stock: ${product.stock}'),
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
        );
      }
    );
  }

}
