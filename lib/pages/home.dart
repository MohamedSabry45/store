import 'package:flutter/material.dart';
import 'package:store/pages/product_page.dart';

import 'add_product.dart';

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
        title: Text(
          "My Shop",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.pink,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navifgateToAddProduct,
        label: Text("Add Product"),
      ),
      body: ProductPage(),
    );
  }
  void navifgateToAddProduct(){
    final route =MaterialPageRoute(builder: (context)=> AddProduct(),);
    Navigator.push(context, route);
  }
}
