import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';

class FruitDetailBannerWidget extends StatefulWidget {
  final FruitItem fruitItem;

  final double imageSize;

  final double imageMaxSize;

  final double imageMinSize;

  final bool isLongPressed;

  const FruitDetailBannerWidget(
      {Key? key,
      required this.fruitItem,
      required this.imageSize,
      required this.imageMaxSize,
      required this.imageMinSize,
      required this.isLongPressed})
      : super(key: key);

  @override
  _FruitDetailBannerWidgetState createState() =>
      _FruitDetailBannerWidgetState();
}

class _FruitDetailBannerWidgetState extends State<FruitDetailBannerWidget>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController _animationController;
  int _currentPage = 0;
  double imageSizeCenter = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        final int totalPage = (widget.fruitItem.imageUrl != null)
            ? widget.fruitItem.imageUrl!.length
            : 0;
        _currentPage++;
        if (_currentPage == totalPage) {
          _currentPage = 0;
        }
        _pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 200), curve: Curves.easeInSine);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    imageSizeCenter = (((widget.imageMaxSize - widget.imageMinSize) / 2) +
        widget.imageMinSize);
    return PageView.builder(
      controller: _pageController,
      itemCount: (widget.fruitItem.imageUrl != null)
          ? widget.fruitItem.imageUrl!.length
          : 0,
      onPageChanged: (value) {
        _currentPage = value;
        _animationController.reset();
        _animationController.forward();
      },
      itemBuilder: (context, i) {
        return Center(
          child: AnimatedContainer(
            duration: widget.isLongPressed
                ? Duration(milliseconds: 0)
                : Duration(milliseconds: 200),
            width: widget.isLongPressed
                ? widget.imageSize
                : (widget.imageSize < imageSizeCenter)
                    ? widget.imageMinSize
                    : widget.imageMaxSize,
            height: widget.isLongPressed
                ? widget.imageSize
                : (widget.imageSize < imageSizeCenter)
                    ? widget.imageMinSize
                    : widget.imageMaxSize,
            child: Image.network(
              widget.fruitItem.imageUrl![i],
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}