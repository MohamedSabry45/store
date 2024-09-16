import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {
  static const String apiUrl =
      "https://hosamalnajar.com/wp-json/wc/v3/products";
  static const String key = "ck_b889a51653d0210c1ac79fee13c99180c5285eea";
  static const String secret = "cs_2d11c2fbeed8e926fab8cdf090e9bbcd774bf8dd";

  static Map<String, String> getHeader() {
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$key:$secret'))}';
    return {'Authorization': basicAuth, 'Content-Type': 'application/json'};
  }

  static Future<List> getAllProducts() async {
    List Products = [];
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: getHeader(),
      );
      if (response.statusCode == 200) {
        Products = jsonDecode(response.body);
        print('************** Products *********');
        print(Products);
      } else {
        print('final to get Products .Status Code:${response.statusCode} ');
        print('Respose:${response.body}');
      }
    } catch (e) {
      print(e);
    }

    return Products;
  }

  static Future<bool> createProduct(date) async {
    bool success = false;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: getHeader(), body: jsonEncode(date));
      if (response.statusCode == 201) {
        success = true;
      } else {
        print("faield to create proudct . Status code :${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return success;
  }

  static Future<bool> updateProduct(proudctId,date) async {
    bool success = false;
    String url="$apiUrl/$proudctId";
    try {
      final response = await http.put(Uri.parse(url),
          headers: getHeader(), body: jsonEncode(date));
      if (response.statusCode == 200) {
        success = true;
      } else {
        print("faield to update proudct . Status code :${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return success;
  }
  static Future<bool> deletProduct(proudctId) async {
    bool success = false;
    String url="$apiUrl/$proudctId";
    try {
      final response = await http.delete(Uri.parse(url),
          headers: getHeader()
      );
      if (response.statusCode == 200) {
        success = true;
      } else {
        print("faield to delet proudct . Status code :${response.statusCode}");
        print("Response :${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return success;
  }
}
