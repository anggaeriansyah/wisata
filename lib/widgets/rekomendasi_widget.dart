import 'package:flutter/material.dart';
import 'package:wisata_tenjolaya/widgets/carousel/rek1_carousel.dart';
import 'package:wisata_tenjolaya/widgets/carousel/rek2_carousel.dart';
import 'package:wisata_tenjolaya/widgets/carousel/rek3_carousel.dart';

class RekomendasiWidget extends StatefulWidget {
  const RekomendasiWidget({Key? key}) : super(key: key);

  @override
  State<RekomendasiWidget> createState() => _RekomendasiWidgetState();
}

class _RekomendasiWidgetState extends State<RekomendasiWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  List<Widget> widgets = const [
    Rek1Carousel(),
    Rek2Carousel(),
    Rek3Carousel(),
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: widgets.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(
            physics: const BouncingScrollPhysics(),
            children: widgets,
            controller: _controller,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TabPageSelector(
              borderStyle: BorderStyle.none,
              indicatorSize: 7,
              selectedColor: Theme.of(context).primaryColor,
              color: Colors.grey.shade400,
              controller: _controller,
            ),
          )
        ],
      ),
    );
  }
}
