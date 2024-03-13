import 'package:flutter/material.dart';
import 'package:flutter_store/themes/colors.dart';
import 'package:flutter_store/utils/constants.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    
    // รับค่าที่ส่งมาจากหน้า Home ผ่าน arguments
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // แสดงค่าที่รับมาจาก arguments
    // print(arguments);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['product']['name']),
      ),
      body: ListView(
        children: [
          arguments['product']['image'] != null
              ? Image.network(
                  '$baseURLImage${arguments['product']['image']}',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'ssets/images/noavartar.png',
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arguments['product']['name'], 
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Barcode: ${arguments['product']['barcode']}',
                      style: const TextStyle(fontSize: 18, color: primaryText),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, color: primary),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ]
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${arguments['product']['price']} THB',
                      style: const TextStyle(fontSize: 18, color: primary),
                    ),
                    const Spacer(),
                    Text(
                      'Stock: ${arguments['product']['stock']}',
                      style: const TextStyle(fontSize: 18, color: primaryDark),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(arguments['product']['description']),
                const SizedBox(height: 10),
                Text(
                  'Created: ${arguments['product']['created_at']}',
                  style: const TextStyle(fontSize: 14, color: primaryText),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}