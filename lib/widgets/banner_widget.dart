import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wisata_tenjolaya/widgets/carousel/banner1.dart';
import 'package:wisata_tenjolaya/widgets/carousel/banner2.dart';
import 'package:wisata_tenjolaya/widgets/carousel/banner3.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  late PageController _pageController;
  late Timer _timer;
  bool _isHold = false;
  int _currentIndex = 0;
  List<Widget> widgets = const [
    Banner1(),
    Banner2(),
    Banner3(),
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: widgets.length, vsync: this, initialIndex: 0);
    _pageController = PageController(initialPage: _currentIndex);
    _startTimer();
    // _controller.animation!.addListener(() {
    //   if (_controller.animation!.isCompleted) {
    //     final newIndex = (_currentIndex + 1) % widgets.length;
    //     _controller.animateTo(newIndex);
    //   }
    // });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    const duration = Duration(seconds: 8);
    // _timer = Timer.periodic(duration, (_) {
    //   final newIndex = (_currentIndex + 1) % widgets.length;
    //   _controller.animateTo(newIndex);
    // });
    _timer = Timer.periodic(duration, (_) {
      if (!_isHold) {
        final newIndex = (_currentIndex + 1) % widgets.length;
        _pageController.animateToPage(
          newIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onLongPressStart: (_) {
          setState(() {
            _isHold = true;
          });
        },
        onLongPressEnd: (_) {
          setState(() {
            _isHold = false;
          });
        },
        child: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          children: widgets,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
