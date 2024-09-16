import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoritState();
}

class _FavoritState extends State<Favorite> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isFavorite = !isFavorite),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 32,
          width: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle
        ),
        child: SvgPicture.asset("assets/icons/heart.svg"),
        color: isFavorite? Colors.red:Colors.grey
      ),
    );
  }
}
