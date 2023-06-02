// import 'dart:html';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
import 'package:wisata_tenjolaya/models/wisata_model.dart';

class Rek1Carousel extends StatefulWidget {
  const Rek1Carousel({Key? key}) : super(key: key);

  @override
  State<Rek1Carousel> createState() => _Rek1CarouselState();
}

class _Rek1CarouselState extends State<Rek1Carousel> {
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
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: db.collection('wisata').doc("wqgsTinO8Rc4QqvoMo6f").snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black54)),
              ),
            );
          }
          if (snapshots.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }

          Map<String, dynamic> data = snapshots.data!.data()!;
          return Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.to(DetailScreen(wisata: snapshots.data),
                        transition: Transition.downToUp);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Stack(children: <Widget>[
                      Hero(
                        tag: Text('tag'),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: data['image'].toString().substring(0, 6) !=
                                  'assets'
                              ? CachedNetworkImage(
                                  imageUrl: data['image'],
                                  height: 220,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  fit: BoxFit.cover,
                                )
                              : Image(
                                  height: 220,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  image: AssetImage(data['image'].toString()),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomLeft,
                              colors: [Colors.transparent, Colors.black38],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data['nama'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  FontAwesomeIcons.locationArrow,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['desa'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      data['kec'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
