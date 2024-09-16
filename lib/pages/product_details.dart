import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'commpanets/cart_counter.dart';
import 'commpanets/favoirt.dart';

class productDetails extends StatefulWidget {
  final Map Product;

  const productDetails({super.key, required this.Product});

  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  Map product = {};
  String imageUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = widget.Product;
    if (product['images'].isEmpty) {
      imageUrl = "https://placehold.co/600x400/000000";
    } else {
      imageUrl = product["image"][0]["src"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product["name"],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "price\n",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: "\$${product['price']}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,

                        ))
                  ])),
                  SizedBox(width: 20,),
                  Expanded(child: Image.network(imageUrl,fit:BoxFit.fill ),),
                ],
              ),
             const Text("Description",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(parseHtmlString(product["description"])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                CartCounter(),
                Favorite(),
              ],),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(right:20 ) ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.pink,
                      )

                    ),
                    child: IconButton(icon: SvgPicture.asset("assets/icons/add_to_cart.svg"
                    ),
                     onPressed: (){},
                    )
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color:Colors.pink,borderRadius:BorderRadius.circular(18) ),
                      child: TextButton(onPressed: (){},
                          child: Text(
                        "Add to cart",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  )
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
  String parseHtmlString(String htmlText){
    RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
    return htmlText.replaceAll(htmlText, "");
  }
}
