import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';

class FruitViewPagers extends StatefulWidget {
  final List<String> images;

  const FruitViewPagers({Key? key, required this.images}) : super(key: key);

  @override
  FruitViewPagersState createState() => FruitViewPagersState();
}

class FruitViewPagersState extends State<FruitViewPagers>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController _animationController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        final int totalPage = widget.images.length;
        _currentPage++;
        if (_currentPage == totalPage) {
          _currentPage = 0;
        }
        _pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return Container(
      height: heightScreen * 0.3,
      width: widthScreen,
      color: AppColors.texas_rose,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (value) {
          print(_currentPage);
          print("value : $value");
          _currentPage = value;
          _animationController.reset();
          _animationController.forward();
        },
        itemBuilder: (context, i) {
          return Center(
              child: Container(
            width: widthScreen * 0.5,
            height: widthScreen * 0.5,
            child: Image.network(
              widget.images[i],
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ));
        },
      ),
    );
  }
}
