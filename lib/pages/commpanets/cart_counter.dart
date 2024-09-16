import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            onPressed: () =>setState(() =>numOfItems-- ),

            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                )),
            child: Icon(
              Icons.remove,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            numOfItems.toString().padLeft(2,  "0"),
            style: TextStyle(fontSize: 25),
          ),
        ),
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            onPressed: () =>setState(() =>numOfItems++ ),
            child: Icon(
              Icons.add,
            ),
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                )),
          ),
        ),
      ],
    );
  }
}
