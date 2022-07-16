import 'package:flutter/material.dart';

class FruitDrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 131,
      left: 282,
      child: Image.asset(
        'assets/images/welcome_fruit_drop.png',
        width: 50,
        height: 37,
      ),
    );
  }
}
