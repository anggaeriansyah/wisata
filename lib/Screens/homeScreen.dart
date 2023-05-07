import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
import 'package:wisata_tenjolaya/Screens/maps.dart';
import 'package:wisata_tenjolaya/Screens/searchScreen.dart';
import 'package:wisata_tenjolaya/Screens/weatherScreen.dart';
import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';
import 'package:wisata_tenjolaya/widgets/airTerjun_widget.dart';
import 'package:wisata_tenjolaya/widgets/allCategories_widget.dart';
import 'package:wisata_tenjolaya/widgets/big_app_text.dart';
import 'package:wisata_tenjolaya/widgets/rekomendasi_widget.dart';
import 'package:wisata_tenjolaya/widgets/rekreasi_widget.dart';
import 'package:wisata_tenjolaya/widgets/situs_widget.dart';
import 'package:wisata_tenjolaya/widgets/tabBar_widget.dart';
import '../widgets/big_app_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Future<List<Wisata2>>? futurWisata = null;
  // bool circular = false;
  bool _isActive = false;

  String? _currentAddress;
  Position? _currentPosition;
  final List air = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    _getCurrentPosition();
    // getData();
  }

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

  Future<Wisata2?> getDataRekreasi() async {
    var res = await http.get(Uri.parse(
        "https://wisata-server-production.up.railway.app/wisata/api/rekreasi"));
    if (res.statusCode == 200) {
      // circular = true;
      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>);
      return Wisata2.fromJson(data);
    } else {
      return null;
    }
  }

  Future<bool> _handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
      return false;
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      setState(() {
        _isActive = false;
      });
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    Geolocator.getLastKnownPosition;
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      await Geolocator.checkPermission();
      setState(() {
        _isActive = false;
      });
    } else {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
          .then((Position position) {
        setState(
          () => _currentPosition = position,
        );
        _getAddressFromLatLng(_currentPosition!);
        _isActive = true;
      }).catchError((e) {
        debugPrint(e);
      });
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.subLocality}, ${place.locality}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
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

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // int _selectedDestination = 0;
    // TabController _tabController = TabController(length: 4, vsync: this);

    return Scaffold(
        appBar: _isActive
            ? AppBar(
                toolbarHeight: kToolbarHeight * 0.7,
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.place,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        _currentAddress ?? "",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            overflow: TextOverflow.fade),
                      ),
                    ),
                  ],
                ),
              )
            : AppBar(
                elevation: 0,
                toolbarHeight: 0,
                backgroundColor: Colors.white,
              ),
        body: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Get.to(const WeatherScreen(), transition: Transition.downToUp);
              },
              child: const Icon(
                Iconsax.cloud,
                // FontAwesomeIcons.cloudBolt,
                size: 30,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            title: GestureDetector(
              onTap: () {
                Get.to(const SearchScreen(), transition: Transition.downToUp);
              },
              child: const SizedBox(
                height: 50,
                width: 50,
                child: Icon(
                  Iconsax.search_normal,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                  onTap: () async {
                    // if (_hashData) {
                    // } else {}
                    Get.to(const Maps(), transition: Transition.downToUp);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Icon(
                      Iconsax.map,
                      size: 30,
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
          body: Scaffold(
              appBar: AppBar(
                toolbarHeight: 70,
                elevation: 0,
                backgroundColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BigAppText(
                        text: 'Wisata Tenjolaya',
                        size: 28,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 5),
                      child: Lottie.asset(
                        'assets/lottie/paper-rocket.json',
                        height: 35,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              body: TabBarWidget()

              // SafeArea(
              //   child: ListView(
              //     physics: const BouncingScrollPhysics(),
              //     children: [
              //       Container(
              //           padding: const EdgeInsets.only(left: 20, top: 5),
              //           child: const BigAppText(text: "Rekomendasi", size: 18)),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       const SizedBox(
              //         height: 260,
              //         child: RekomendasiWidget(),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 5),
              //         child: TabBar(
              //             controller: _tabController,
              //             labelColor: Colors.black,
              //             unselectedLabelColor: Colors.grey,
              //             isScrollable: true,
              //             indicator: CircleTabIndicator(
              //                 color: Colors.black, radius: 4),
              //             // UnderlineTabIndicator(
              //             //   borderSide:
              //             //   BorderSide(
              //             //       width: 3, color: Theme.of(context).primaryColor),
              //             //   insets: const EdgeInsets.symmetric(horizontal: 16),
              //             // ),
              //             tabs: const [
              //               Tab(text: 'Semua Kategori'),
              //               Tab(text: 'Air Terjun'),
              //               Tab(text: 'Rekreasi'),
              //               Tab(text: 'Situs Prasejarah')
              //             ]),
              //       ),
              //       const SizedBox(height: 10),
              //       Padding(
              //           padding: const EdgeInsets.only(
              //               left: 10, right: 10, bottom: 10),
              //           child: FutureBuilder<Wisata2?>(
              //               future: getData(),
              //               builder: (context, snapshot) {
              //                 if (snapshot.connectionState ==
              //                     ConnectionState.done) {
              //                   // _hashData = true;
              //                   return Center(
              //                     child: [
              //                       GridView.count(
              //                         crossAxisCount: 2,
              //                         physics:
              //                             const NeverScrollableScrollPhysics(),
              //                         shrinkWrap: true,
              //                         childAspectRatio: (150 /
              //                             (MediaQuery.of(context).size.width *
              //                                 0.5)),
              //                         children: [
              //                           for (int i = 0;
              //                               i < snapshot.data!.data.length;
              //                               i++)
              //                             GestureDetector(
              //                               onTap: () {
              //                                 Get.to(
              //                                     DetailScreen(
              //                                         wisata: snapshot
              //                                             .data!.data[i].id),
              //                                     arguments: {
              //                                       'image': snapshot
              //                                           .data!.data[i].image,
              //                                       'nama': snapshot
              //                                           .data!.data[i].nama,
              //                                       'desa': snapshot.data!
              //                                           .data[i].alamat.desa,
              //                                       'kec': snapshot.data!
              //                                           .data[i].alamat.kec,
              //                                       'lat': snapshot
              //                                           .data!
              //                                           .data[i]
              //                                           .alamat
              //                                           .latitude,
              //                                       'long': snapshot
              //                                           .data!
              //                                           .data[i]
              //                                           .alamat
              //                                           .longitude,
              //                                       'tiket': snapshot.data!
              //                                           .data[i].info.tiket,
              //                                       'desc': snapshot.data!
              //                                           .data[i].info.deskripsi,
              //                                       'tempClosed': snapshot.data!
              //                                           .data[i].tempClosed,
              //                                       'distance': snapshot
              //                                           .data!.data[i].distance,
              //                                       'hSenin': snapshot.data!
              //                                           .data[i].hariOp[0],
              //                                       'hSelasa': snapshot.data!
              //                                           .data[i].hariOp[1],
              //                                       'hRabu': snapshot.data!
              //                                           .data[i].hariOp[2],
              //                                       'hKamis': snapshot.data!
              //                                           .data[i].hariOp[3],
              //                                       'hJumat': snapshot.data!
              //                                           .data[i].hariOp[4],
              //                                       'hSabtu': snapshot.data!
              //                                           .data[i].hariOp[5],
              //                                       'hMinggu': snapshot.data!
              //                                           .data[i].hariOp[6],
              //                                       'jSenin': snapshot
              //                                           .data!.data[i].jamOp[0],
              //                                       'jSelasa': snapshot
              //                                           .data!.data[i].jamOp[1],
              //                                       'jRabu': snapshot
              //                                           .data!.data[i].jamOp[2],
              //                                       'jKamis': snapshot
              //                                           .data!.data[i].jamOp[3],
              //                                       'jJumat': snapshot
              //                                           .data!.data[i].jamOp[4],
              //                                       'jSabtu': snapshot
              //                                           .data!.data[i].jamOp[5],
              //                                       'jMinggu': snapshot
              //                                           .data!.data[i].jamOp[6],
              //                                       'imageGaleries': snapshot
              //                                           .data!
              //                                           .data[i]
              //                                           .imageGaleries,
              //                                       'kategori': snapshot
              //                                           .data!.data[i].kategori
              //                                     },
              //                                     transition:
              //                                         Transition.downToUp);
              //                               },
              //                               child: Container(
              //                                 padding:
              //                                     const EdgeInsets.symmetric(
              //                                         vertical: 10,
              //                                         horizontal: 10),
              //                                 margin: const EdgeInsets.only(
              //                                     top: 10,
              //                                     bottom: 10,
              //                                     left: 10,
              //                                     right: 10),
              //                                 decoration: BoxDecoration(
              //                                   borderRadius:
              //                                       BorderRadius.circular(20),
              //                                   color: Colors.white,
              //                                   boxShadow: const [
              //                                     BoxShadow(
              //                                       color: Colors.black26,
              //                                       offset: Offset(0, 2),
              //                                       blurRadius: 7,
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 child: Column(
              //                                   children: [
              //                                     InkWell(
              //                                       onTap: () {
              //                                         Get.to(
              //                                             DetailScreen(
              //                                                 wisata: snapshot
              //                                                     .data!
              //                                                     .data[i]
              //                                                     .id),
              //                                             arguments: {
              //                                               'image': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .image,
              //                                               'nama': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .nama,
              //                                               'desa': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .alamat
              //                                                   .desa,
              //                                               'kec': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .alamat
              //                                                   .kec,
              //                                               'lat': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .alamat
              //                                                   .latitude,
              //                                               'long': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .alamat
              //                                                   .longitude,
              //                                               'tiket': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .info
              //                                                   .tiket,
              //                                               'desc': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .info
              //                                                   .deskripsi,
              //                                               'tempClosed':
              //                                                   snapshot
              //                                                       .data!
              //                                                       .data[i]
              //                                                       .tempClosed,
              //                                               'distance': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .distance,
              //                                               'hSenin': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .hariOp[0],
              //                                               'hSelasa': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .hariOp[1],
              //                                               'hRabu': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .hariOp[2],
              //                                               'hKamis': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .hariOp[3],
              //                                               'hJumat': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .hariOp[4],
              //                                               'hSabtu': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .hariOp[5],
              //                                               'hMinggu': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .hariOp[6],
              //                                               'jSenin': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .jamOp[0],
              //                                               'jSelasa': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .jamOp[1],
              //                                               'jRabu': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .jamOp[2],
              //                                               'jKamis': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .jamOp[3],
              //                                               'jJumat': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .jamOp[4],
              //                                               'jSabtu': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .jamOp[5],
              //                                               'jMinggu': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .jamOp[6],
              //                                               'imageGaleries':
              //                                                   snapshot
              //                                                       .data!
              //                                                       .data[i]
              //                                                       .imageGaleries,
              //                                               'kategori': snapshot
              //                                                   .data!
              //                                                   .data[i]
              //                                                   .kategori
              //                                             },
              //                                             transition: Transition
              //                                                 .downToUp);
              //                                       },
              //                                       child: ClipRRect(
              //                                           borderRadius:
              //                                               BorderRadius
              //                                                   .circular(20),
              //                                           child: Image.network(
              //                                             snapshot.data!.data[i]
              //                                                 .image,
              //                                             loadingBuilder:
              //                                                 (BuildContext
              //                                                         context,
              //                                                     Widget child,
              //                                                     ImageChunkEvent?
              //                                                         loadingProgress) {
              //                                               if (loadingProgress ==
              //                                                   null) {
              //                                                 return child;
              //                                               } else {
              //                                                 return Container(
              //                                                   color: Colors
              //                                                       .grey[300],
              //                                                   height: MediaQuery.of(
              //                                                               context)
              //                                                           .size
              //                                                           .width *
              //                                                       0.38,
              //                                                   width: MediaQuery.of(
              //                                                               context)
              //                                                           .size
              //                                                           .width *
              //                                                       0.5,
              //                                                   child: Center(
              //                                                     child: Icon(
              //                                                       Icons.image,
              //                                                       color: Colors
              //                                                               .grey[
              //                                                           600],
              //                                                       size: 64.0,
              //                                                     ),
              //                                                   ),
              //                                                 );
              //                                               }
              //                                             },
              //                                             fit: BoxFit.cover,
              //                                             height: MediaQuery.of(
              //                                                         context)
              //                                                     .size
              //                                                     .width *
              //                                                 0.38,
              //                                             width: MediaQuery.of(
              //                                                         context)
              //                                                     .size
              //                                                     .width *
              //                                                 0.5,
              //                                           )),
              //                                     ),
              //                                     const SizedBox(height: 5),
              //                                     Padding(
              //                                       padding:
              //                                           const EdgeInsets.only(
              //                                         top: 5,
              //                                         left: 5,
              //                                         right: 5,
              //                                       ),
              //                                       child: Align(
              //                                         alignment:
              //                                             Alignment.centerLeft,
              //                                         child: Column(
              //                                           // mainAxisAlignment: MainAxisAlignment.end,
              //                                           crossAxisAlignment:
              //                                               CrossAxisAlignment
              //                                                   .start,
              //                                           children: [
              //                                             Expanded(
              //                                               flex: 0,
              //                                               child: Text(
              //                                                 snapshot.data!
              //                                                     .data[i].nama,
              //                                                 maxLines: 1,
              //                                                 overflow:
              //                                                     TextOverflow
              //                                                         .fade,
              //                                                 softWrap: false,
              //                                                 style: const TextStyle(
              //                                                     fontSize: 16,
              //                                                     fontWeight:
              //                                                         FontWeight
              //                                                             .w600,
              //                                                     color: Colors
              //                                                         .black),
              //                                               ),
              //                                             ),
              //                                             const SizedBox(
              //                                                 height: 3),
              //                                             Row(
              //                                               children: <Widget>[
              //                                                 Icon(
              //                                                     FontAwesomeIcons
              //                                                         .locationArrow,
              //                                                     size: 13,
              //                                                     color: Theme.of(
              //                                                             context)
              //                                                         .primaryColor),
              //                                                 const SizedBox(
              //                                                     width: 5),
              //                                                 Text(
              //                                                   snapshot
              //                                                       .data!
              //                                                       .data[i]
              //                                                       .alamat
              //                                                       .desa,
              //                                                   maxLines: 1,
              //                                                   overflow:
              //                                                       TextOverflow
              //                                                           .fade,
              //                                                   softWrap: false,
              //                                                   style: TextStyle(
              //                                                       fontSize:
              //                                                           13,
              //                                                       fontWeight:
              //                                                           FontWeight
              //                                                               .w500,
              //                                                       color: Theme.of(
              //                                                               context)
              //                                                           .accentColor),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                         ],
              //                       ),
              //                       GridView.count(
              //                         crossAxisCount: 2,
              //                         physics:
              //                             const NeverScrollableScrollPhysics(),
              //                         shrinkWrap: true,
              //                         childAspectRatio: (150 / 195),
              //                         children: [
              //                           for (int i = 0;
              //                               i < snapshot.data!.data.length;
              //                               i++)
              //                             GestureDetector(
              //                               onTap: () {
              //                                 // Get.to(DetailScreen(wisata: airTerjun[i]),
              //                                 //     transition: Transition.downToUp);
              //                               },
              //                               child: Container(
              //                                 padding:
              //                                     const EdgeInsets.symmetric(
              //                                         vertical: 10,
              //                                         horizontal: 10),
              //                                 margin: const EdgeInsets.only(
              //                                     top: 10,
              //                                     bottom: 10,
              //                                     left: 10,
              //                                     right: 10),
              //                                 decoration: BoxDecoration(
              //                                   borderRadius:
              //                                       BorderRadius.circular(20),
              //                                   color: Colors.white,
              //                                   boxShadow: const [
              //                                     BoxShadow(
              //                                       color: Colors.black26,
              //                                       offset: Offset(0, 2),
              //                                       blurRadius: 7,
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 child: Column(
              //                                   children: [
              //                                     InkWell(
              //                                       onTap: () {
              //                                         // Get.to(DetailScreen(wisata: airTerjun[i]),
              //                                         //     transition: Transition.downToUp);
              //                                       },
              //                                       child: ClipRRect(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 20),
              //                                         child: Image(
              //                                           image: AssetImage(
              //                                               'assets/images/curug-ciputri-area-camping-ground.jpg'),
              //                                           fit: BoxFit.cover,
              //                                           height: 150,
              //                                           width: 150,
              //                                         ),
              //                                       ),
              //                                     ),
              //                                     const SizedBox(height: 5),
              //                                     Padding(
              //                                       padding:
              //                                           const EdgeInsets.only(
              //                                         top: 5,
              //                                         left: 5,
              //                                         right: 5,
              //                                       ),
              //                                       child: Align(
              //                                         alignment:
              //                                             Alignment.centerLeft,
              //                                         child: Column(
              //                                           mainAxisAlignment:
              //                                               MainAxisAlignment
              //                                                   .end,
              //                                           crossAxisAlignment:
              //                                               CrossAxisAlignment
              //                                                   .start,
              //                                           children: [
              //                                             Text(
              //                                               'airTerjun[i].nama',
              //                                               maxLines: 1,
              //                                               overflow:
              //                                                   TextOverflow
              //                                                       .ellipsis,
              //                                               softWrap: true,
              //                                               style: const TextStyle(
              //                                                   fontSize: 16,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .w600,
              //                                                   color: Colors
              //                                                       .black),
              //                                             ),
              //                                             const SizedBox(
              //                                                 height: 3),
              //                                             Row(
              //                                               children: <Widget>[
              //                                                 Icon(
              //                                                     FontAwesomeIcons
              //                                                         .locationArrow,
              //                                                     size: 13,
              //                                                     color: Theme.of(
              //                                                             context)
              //                                                         .primaryColor),
              //                                                 const SizedBox(
              //                                                     width: 5),
              //                                                 Text(
              //                                                   'airTerjun[i].alamat',
              //                                                   maxLines: 1,
              //                                                   overflow:
              //                                                       TextOverflow
              //                                                           .ellipsis,
              //                                                   style: TextStyle(
              //                                                       fontSize:
              //                                                           13,
              //                                                       fontWeight:
              //                                                           FontWeight
              //                                                               .w500,
              //                                                       color: Theme.of(
              //                                                               context)
              //                                                           .accentColor),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       ),
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                             )
              //                         ],
              //                       ),
              //                       RekreasiWidget(),
              //                       SitusWidget(),
              //                     ][_tabController.index],
              //                   );
              //                 } else {
              //                   return const Center(
              //                     child: Padding(
              //                       padding: EdgeInsets.only(top: 50),
              //                       child: CircularProgressIndicator(
              //                         valueColor: AlwaysStoppedAnimation<Color>(
              //                             Colors.black54),
              //                       ),
              //                     ),
              //                   );
              //                 }
              //               }))
              //     ],
              //   ),
              // )

              // body: ListView(
              //   physics: const BouncingScrollPhysics(),
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Container(
              //             padding: const EdgeInsets.only(left: 20, top: 5),
              //             child: const BigAppText(text: "Rekomendasi", size: 18)),
              //         const SizedBox(
              //           height: 10,
              //         ),
              //         const RekomendasiCarousel(),
              //         // TabBarView(controller: _tabControl, children: [
              //         //   Center(child: Text('req_1')),
              //         //   Center(child: Text('req_2')),
              //         //   Center(child: Text('req_3')),
              //         // ]),

              //         const SizedBox(
              //           height: 10,
              //         ),
              //         Container(
              //           width: double.maxFinite,
              //           child: Align(
              //             alignment: Alignment.centerLeft,
              //             child: TabBar(
              //                 controller: _tabController,
              //                 isScrollable: true,
              //                 labelPadding:
              //                     const EdgeInsets.symmetric(horizontal: 20),
              //                 labelColor: Colors.black,
              //                 unselectedLabelColor: Colors.grey,
              //                 indicator:
              //                     CircleTabIndicator(color: Colors.black, radius: 4),
              //                 tabs: [
              //                   const Tab(text: 'Semua Wisata'),
              //                   const Tab(text: 'Air Terjun'),
              //                   const Tab(text: 'Rekreasi'),
              //                   const Tab(text: 'Situs Prasejarah'),
              //                 ]),
              //           ),
              //         ),
              //         const SizedBox(
              //           height: 5,
              //         ),
              //         // Container(
              //         //   // width: double.maxFinite,
              //         //   height: 100,
              //         //   child: TabBarView(controller: _tabController, children: [
              //         //     SemuaCarousel(),
              //         //     AirCarousel(),
              //         //     RekreasiCarousel(),
              //         //     const Center(child: Text('kul')),
              //         //     const Center(child: Text('sit')),
              //         //   ]),
              //         // ),

              //         // RekreasiCarousel(),
              //         // const SizedBox(
              //         //   height: 10,
              //         // ),

              //         SafeArea(
              //           child: Padding(
              //             padding: const EdgeInsets.only(top: 20),
              //             child: ListView(
              //               children: [
              //                 TabBar(
              //                     controller: _tabController,
              //                     labelColor: Theme.of(context).primaryColor,
              //                     unselectedLabelColor: Colors.grey,
              //                     isScrollable: true,
              //                     indicator: UnderlineTabIndicator(
              //                       borderSide: BorderSide(
              //                           width: 3,
              //                           color: Theme.of(context).primaryColor),
              //                       insets:
              //                           const EdgeInsets.symmetric(horizontal: 16),
              //                     ),
              //                     tabs: [
              //                       Tab(text: 'Semua Kategori'),
              //                       Tab(text: 'Air Terjun'),
              //                       Tab(text: 'Rekreasi'),
              //                       Tab(text: 'Situs Prasejarah')
              //                     ]),
              //                 const SizedBox(height: 20),
              //                 Center(
              //                   child: [
              //                     ItemsWidget(),
              //                     Text('data'),
              //                     ItemsWidget(),
              //                     ItemsWidget(),
              //                   ][_tabController.index],
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              ),
        ));
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

Widget _drawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
