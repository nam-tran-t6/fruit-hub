import 'package:flutter/material.dart';

class IntroImage extends StatelessWidget {
  final String imageUrl;
  final String shadowUrl;
  final String dropUrl;

  IntroImage({required this.imageUrl, required this.shadowUrl, required this.dropUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Image.network(this.imageUrl),
        Positioned(
          child: Image.network(this.shadowUrl),
          bottom: -20,
          left: 0,
          right: 0,
        ),
        Positioned(
          child: Image.network(this.dropUrl),
          top: -30,
          right: 0,
        ),
      ],
    );
  }
}
