// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Banner3 extends StatefulWidget {
  const Banner3({Key? key}) : super(key: key);

  @override
  State<Banner3> createState() => _Banner3State();
}

class _Banner3State extends State<Banner3> {
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                height: 110,
                width: MediaQuery.of(context).size.width * 0.9,
                image: const AssetImage('assets/images/banner3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
