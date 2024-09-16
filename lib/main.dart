import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/pages/home.dart';

void main(){
  runApp(const MyAPP());
}
class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Home(),
      );

  }
}
