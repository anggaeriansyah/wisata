import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
import 'package:wisata_tenjolaya/Screens/homeScreen.dart';
import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';
import 'package:wisata_tenjolaya/widgets/big_app_text.dart';
import 'package:wisata_tenjolaya/widgets/rekomendasi_widget.dart';
import 'package:wisata_tenjolaya/widgets/rekreasi_widget.dart';
import 'package:wisata_tenjolaya/widgets/situs_widget.dart';

import 'package:http/http.dart' as http;

class TabBarWidget extends StatefulWidget {
  // const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<Wisata2?> getData() async {
    var res = await http.get(Uri.parse(
        "https://wisata-server-production.up.railway.app/wisata/api"));
    if (res.statusCode == 200) {
      // circular = true;
      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>);
      return Wisata2.fromJson(data);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    getData();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: const BigAppText(text: "Rekomendasi", size: 18)),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 260,
            child: RekomendasiWidget(),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicator: CircleTabIndicator(color: Colors.black, radius: 4),
                // UnderlineTabIndicator(
                //   borderSide:
                //   BorderSide(
                //       width: 3, color: Theme.of(context).primaryColor),
                //   insets: const EdgeInsets.symmetric(horizontal: 16),
                // ),
                tabs: const [
                  Tab(text: 'Semua Kategori'),
                  Tab(text: 'Air Terjun'),
                  Tab(text: 'Rekreasi'),
                  Tab(text: 'Situs Prasejarah')
                ]),
          ),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: FutureBuilder<Wisata2?>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // _hashData = true;
                      return Center(
                        child: [
                          GridView.count(
                            crossAxisCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            childAspectRatio: (150 /
                                (MediaQuery.of(context).size.width * 0.5)),
                            children: [
                              for (int i = 0;
                                  i < snapshot.data!.data.length;
                                  i++)
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        DetailScreen(
                                            wisata: snapshot.data!.data[i].id),
                                        arguments: {
                                          'image': snapshot.data!.data[i].image,
                                          'nama': snapshot.data!.data[i].nama,
                                          'desa': snapshot
                                              .data!.data[i].alamat.desa,
                                          'kec':
                                              snapshot.data!.data[i].alamat.kec,
                                          'lat': snapshot
                                              .data!.data[i].alamat.latitude,
                                          'long': snapshot
                                              .data!.data[i].alamat.longitude,
                                          'tiket':
                                              snapshot.data!.data[i].info.tiket,
                                          'desc': snapshot
                                              .data!.data[i].info.deskripsi,
                                          'tempClosed':
                                              snapshot.data!.data[i].tempClosed,
                                          'distance':
                                              snapshot.data!.data[i].distance,
                                          'hSenin':
                                              snapshot.data!.data[i].hariOp[0],
                                          'hSelasa':
                                              snapshot.data!.data[i].hariOp[1],
                                          'hRabu':
                                              snapshot.data!.data[i].hariOp[2],
                                          'hKamis':
                                              snapshot.data!.data[i].hariOp[3],
                                          'hJumat':
                                              snapshot.data!.data[i].hariOp[4],
                                          'hSabtu':
                                              snapshot.data!.data[i].hariOp[5],
                                          'hMinggu':
                                              snapshot.data!.data[i].hariOp[6],
                                          'jSenin':
                                              snapshot.data!.data[i].jamOp[0],
                                          'jSelasa':
                                              snapshot.data!.data[i].jamOp[1],
                                          'jRabu':
                                              snapshot.data!.data[i].jamOp[2],
                                          'jKamis':
                                              snapshot.data!.data[i].jamOp[3],
                                          'jJumat':
                                              snapshot.data!.data[i].jamOp[4],
                                          'jSabtu':
                                              snapshot.data!.data[i].jamOp[5],
                                          'jMinggu':
                                              snapshot.data!.data[i].jamOp[6],
                                          'imageGaleries': snapshot
                                              .data!.data[i].imageGaleries,
                                          'kategori':
                                              snapshot.data!.data[i].kategori
                                        },
                                        transition: Transition.downToUp);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                DetailScreen(
                                                    wisata: snapshot
                                                        .data!.data[i].id),
                                                arguments: {
                                                  'image': snapshot
                                                      .data!.data[i].image,
                                                  'nama': snapshot
                                                      .data!.data[i].nama,
                                                  'desa': snapshot.data!.data[i]
                                                      .alamat.desa,
                                                  'kec': snapshot
                                                      .data!.data[i].alamat.kec,
                                                  'lat': snapshot.data!.data[i]
                                                      .alamat.latitude,
                                                  'long': snapshot.data!.data[i]
                                                      .alamat.longitude,
                                                  'tiket': snapshot
                                                      .data!.data[i].info.tiket,
                                                  'desc': snapshot.data!.data[i]
                                                      .info.deskripsi,
                                                  'tempClosed': snapshot
                                                      .data!.data[i].tempClosed,
                                                  'distance': snapshot
                                                      .data!.data[i].distance,
                                                  'hSenin': snapshot
                                                      .data!.data[i].hariOp[0],
                                                  'hSelasa': snapshot
                                                      .data!.data[i].hariOp[1],
                                                  'hRabu': snapshot
                                                      .data!.data[i].hariOp[2],
                                                  'hKamis': snapshot
                                                      .data!.data[i].hariOp[3],
                                                  'hJumat': snapshot
                                                      .data!.data[i].hariOp[4],
                                                  'hSabtu': snapshot
                                                      .data!.data[i].hariOp[5],
                                                  'hMinggu': snapshot
                                                      .data!.data[i].hariOp[6],
                                                  'jSenin': snapshot
                                                      .data!.data[i].jamOp[0],
                                                  'jSelasa': snapshot
                                                      .data!.data[i].jamOp[1],
                                                  'jRabu': snapshot
                                                      .data!.data[i].jamOp[2],
                                                  'jKamis': snapshot
                                                      .data!.data[i].jamOp[3],
                                                  'jJumat': snapshot
                                                      .data!.data[i].jamOp[4],
                                                  'jSabtu': snapshot
                                                      .data!.data[i].jamOp[5],
                                                  'jMinggu': snapshot
                                                      .data!.data[i].jamOp[6],
                                                  'imageGaleries': snapshot
                                                      .data!
                                                      .data[i]
                                                      .imageGaleries,
                                                  'kategori': snapshot
                                                      .data!.data[i].kategori
                                                },
                                                transition:
                                                    Transition.downToUp);
                                          },
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                snapshot.data!.data[i].image,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return Container(
                                                      color: Colors.grey[300],
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.38,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.image,
                                                          color:
                                                              Colors.grey[600],
                                                          size: 64.0,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                fit: BoxFit.cover,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                              )),
                                        ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                            left: 5,
                                            right: 5,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 0,
                                                  child: Text(
                                                    snapshot.data!.data[i].nama,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    softWrap: false,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .locationArrow,
                                                        size: 13,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      snapshot.data!.data[i]
                                                          .alamat.desa,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          GridView.count(
                            crossAxisCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            childAspectRatio: (150 / 195),
                            children: [
                              for (int i = 0;
                                  i < snapshot.data!.data.length;
                                  i++)
                                GestureDetector(
                                  onTap: () {
                                    // Get.to(DetailScreen(wisata: airTerjun[i]),
                                    //     transition: Transition.downToUp);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Get.to(DetailScreen(wisata: airTerjun[i]),
                                            //     transition: Transition.downToUp);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/curug-ciputri-area-camping-ground.jpg'),
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: 150,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                            left: 5,
                                            right: 5,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'airTerjun[i].nama',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(height: 3),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .locationArrow,
                                                        size: 13,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      'airTerjun[i].alamat',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                          RekreasiWidget(),
                          SitusWidget(),
                        ][_tabController.index],
                      );
                    } else {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black54),
                          ),
                        ),
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
