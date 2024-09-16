import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:store/pages/add_product.dart';
import 'package:store/pages/product_details.dart';
import 'package:store/services/product_servies.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List Products = [];

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:getAllProducts ,
      child: GridView.builder(
        padding: EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount:Products.length ,
        itemBuilder: (context, index) {
          final Product = Products[index];
          String imageUrl = "";
          if (Product['images'].isEmpty) {
            imageUrl = "https://placehold.co/600x400/000000/FFFFFF/png";
          } else {
            imageUrl = Product['images'][0]['src'];
          }
          return Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => navigateToProduct(Product),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(imageUrl))),
                  ),
                ),
              ),
              Text(
                "\$${Product['Price']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(Product['name']),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 80, height: 25),
                    child: ElevatedButton(
                      onPressed: () =>navigateToEditProduct(Product),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.all(2)),
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 80, height: 25),
                    child: ElevatedButton(
                      onPressed: () => deleteProduct(Product["id"]),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.all(2)),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
  void navigateToProduct(Product){
    final route =MaterialPageRoute(builder: (context)=>productDetails(Product:Product));
    Navigator.push(context, route);
  }

  Future<void> getAllProducts() async {
    final response = await ProductService.getAllProducts();
    if (response != null) {
      setState(() {
        Products = response;
      });
    } else {
      print('Response:  $response');
    }
  }
  void navigateToEditProduct(Product){
    final route = MaterialPageRoute(builder: (context) =>AddProduct(Product: Product));
    Navigator.push(context, route);
  }
  Future<void>deleteProduct(int ProductId)async{
    final success = await ProductService.deletProduct(ProductId);
    if(success){
      final newProducts =
      Products.where(
              (product)=> product['id']!=ProductId).toList();
      setState(() {
        Products = newProducts;
      });
    }
    else{
      print("Failed to delete product");
    }
  }
}
