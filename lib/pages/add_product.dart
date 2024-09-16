import 'package:flutter/material.dart';
import 'package:store/services/product_servies.dart';

class AddProduct extends StatefulWidget {
  final Map? Product;

  const AddProduct({super.key, this.Product});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool isEdit = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final product = widget.Product;
    if (product != null) {
      isEdit = true;
      nameController.text = product['name'];
      descriptionController.text = product['description'];
      priceController.text = product['price'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          isEdit ? "Edit Product" : "Add Product",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Description"),
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(hintText: "Price"),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: isEdit?updateProduct: createproduct,
            child: Text(
              isEdit ? "Save" : "Create",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createproduct() async {
    final name = nameController.text;
    final description = descriptionController.text;
    final price = priceController.text;
    if (name.isEmpty || price.isEmpty) {
      print("error");
    } else {
      final date = {
        "name": name,
        "type": "simple",
        "regular_price": price,
        "descripdtion": description,
      };
      final success = await ProductService.createProduct(date);
      if (success) {
        nameController.text = "";
        descriptionController.text = "";
        priceController.text = "";
        showSuccessMessage("Product created successfully.", false);
      } else {
        showSuccessMessage("Faild to create product.", true);
      }
    }
  }

  Future<void> updateProduct() async {
    final proudctId = widget.Product?["id"];
    final name = nameController.text;
    final description = descriptionController.text;
    final price = priceController.text;
    if (name.isEmpty || price.isEmpty) {
      print("error");
    } else {
      final date = {
        "name": name,
        "type": "simple",
        "regular_price": price,
        "descripdtion": description,
      };
      final success = await ProductService.updateProduct(proudctId,date);
      if (success) {
        nameController.text = "";
        descriptionController.text = "";
        priceController.text = "";
        showSuccessMessage("Product update successfully.", false);
      } else {
        showSuccessMessage("Faild to update product.", true);
      }
    }
  }

  void showSuccessMessage(String message, bool isError) {
    SnackBar snackBar = SnackBar(content: Text(message));
    if (isError) {
      snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
