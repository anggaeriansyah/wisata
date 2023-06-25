// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Banner1 extends StatefulWidget {
  const Banner1({Key? key}) : super(key: key);

  @override
  State<Banner1> createState() => _Banner1State();
}

class _Banner1State extends State<Banner1> {
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  bool _isActive = false;
  bool get isActive => _isActive;
  // List wisata = listWisata;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Stack(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  height: 110,
                  width: MediaQuery.of(context).size.width * 0.9,
                  image: const AssetImage('assets/images/banner1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
