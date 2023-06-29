import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wisata_tenjolaya/Screens/detailScreen.dart';
import 'package:wisata_tenjolaya/Utils/shapeBorder.dart';
import 'dart:math' show cos, sqrt, asin;

class SearchScreen extends StatefulWidget {
  // const SearchScreen({Key? key}) : super(key: key);

  // final listItem;

  // SearchScreen({required this.listItem});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

void updateList(String value) {}

class _SearchScreenState extends State<SearchScreen> {
  // TextEditingController? _textEditingController = TextEditingController();
  var db = FirebaseFirestore.instance;
  // var listItem;
  var listItemOnSearch;
  TextEditingController _searchController = TextEditingController();
  QuerySnapshot? _searchResults;

  String? _currentAddress;
  Position? _currentPosition;
  double? _cLat;
  double? _cLong;
  bool _isActive = false;
  bool onSearching = false;
  bool isAscending = false;
  // List<DocumentSnapshot> sortedResults = [];

  @override
  void initState() {
    super.initState();
    // _cekLokasi();
    // onGetNearby();
    // _searchData('');
    searchDocuments('');
    // sortedResults = searchResults;
    // setState(() {
    // listItemOnSearch = listItem;
    // });
  }

  // onSearch(String search) {
  //   // listItemOnSearch = widget.listItem;
  //   // listItemOnSearch = widget.listItem.where(
  //   //     (element) => element.data()['nama'].toLowerCase().contains(search));

  //   FirebaseFirestore.instance
  //       .collection('wisata')
  //       .where('nama', isGreaterThanOrEqualTo: search)
  //       .where('nama', isLessThanOrEqualTo: search + 'z')
  //       .get()
  //       .then(((QuerySnapshot querySnapshot) {
  //     listItemOnSearch = querySnapshot.docs;
  //   }));
  //   onSearching = true;

  //   setState(() {});
  // }
  List<QueryDocumentSnapshot> searchResults = [];

  void searchDocuments(String keyword) {
    FirebaseFirestore.instance
        .collection('wisata')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<QueryDocumentSnapshot> results = [];
      querySnapshot.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>;
        // if (data['field'].contains(keyword)) {
        //   results.add(doc);
        // }
        var searchNama = data['nama'].toString().toLowerCase();
        if (data != null && searchNama.contains(keyword)) {
          results.add(doc);
        }
      });
      setState(() {
        searchResults = results;
      });
    });
  }

  void _searchData(value) async {
    final query = value;
    final queryLetters = query.split('');
    if (query == '') {
      final snapshot = await FirebaseFirestore.instance
          .collection('wisata') // Ganti dengan nama koleksi Firebase Anda
          // .orderBy('nama')
          .get();

      setState(() {
        _searchResults = snapshot;
      });
    } else {
      final snapshot = await FirebaseFirestore.instance
          .collection('wisata') // Ganti dengan nama koleksi Firebase Anda
          .orderBy('nama')
          .where('nama',
              isGreaterThanOrEqualTo: query) // Pencarian di tengah kata
          .where('nama',
              isLessThanOrEqualTo: query + '\uf8ff') // Pencarian di tengah kata
          .get();

      setState(() {
        _searchResults = snapshot;
      });
    }
  }

  // onGetNearby() {
  //   if (_isActive) {
  //     for (var i = 0; i < listItemOnSearch.length; i++) {
  //       listItemOnSearch[i].data()['latitude'] = double.parse(nearby(
  //           listItemOnSearch[i].data()['latitude'],
  //           listItemOnSearch[i].data()['longitude']));
  //     }
  //   }
  //   return;
  // }

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  // String nearby(double vLat, double vLong) {
  //   var distance;
  //   if (_isActive) {
  //     distance = calculateDistance(
  //         _currentPosition!.latitude, _currentPosition!.longitude, vLat, vLong);
  //   } else {
  //     distance = 0;
  //   }
  //   return distance.toStringAsFixed(2);
  // }

  void _cekLokasi() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      _getCurrentPosition();
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
      // ignore: use_build_context_synchronously
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
        for (var i = 0; i < listItemOnSearch.length; i++) {
          // listItemOnSearch[i].distance = double.parse(calculateDistance(
          //         _currentPosition!.latitude,
          //         _currentPosition!.longitude,
          //         listItemOnSearch[i].data()['latitude'],
          //         listItemOnSearch[i].data()['longitude'])
          //     .toStringAsFixed(2));
        }
        _isActive = true;
      }).catchError((e) {
        debugPrint(e);
      });
    }
  }

  Future<void> _listTerdekat() async {
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
        for (var i = 0; i < listItemOnSearch.length; i++) {
          // listItemOnSearch[i].distance = double.parse(calculateDistance(
          //         _currentPosition!.latitude,
          //         _currentPosition!.longitude,
          //         listItemOnSearch[i].data()['latitude'],
          //         listItemOnSearch[i].data()['longitude'])
          //     .toStringAsFixed(2));
        }
        listItemOnSearch.sort(
            (a, b) => a.data()['distance'].compareTo(b.data()['distance']));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Cari Wisata',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
          actions: [
            PopupMenuButton(
              tooltip: 'Filter data',
              elevation: 3,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                PopupMenuItem(
                  height: kMinInteractiveDimension * 0.7,
                  child: const Text('Urutkan dari nama A-Z',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                  onTap: () {
                    setState(() {
                      searchResults.sort((a, b) =>
                          ((a.data() as Map<String, dynamic>)['nama'] as String)
                              .toLowerCase()
                              .compareTo(
                                  ((b.data() as Map<String, dynamic>)['nama']
                                          as String)
                                      .toLowerCase()));
                    });
                  },
                ),
                PopupMenuItem(
                  height: kMinInteractiveDimension * 0.7,
                  child: const Text('Urutkan dari nama Z-A',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                  onTap: () {
                    setState(() {
                      searchResults.sort((a, b) =>
                          ((b.data() as Map<String, dynamic>)['nama'] as String)
                              .toLowerCase()
                              .compareTo(
                                  ((a.data() as Map<String, dynamic>)['nama']
                                          as String)
                                      .toLowerCase()));
                    });
                  },
                ),
                // PopupMenuItem(
                //     height: kMinInteractiveDimension * 0.7,
                //     child: const Text('Jarak',
                //         style: TextStyle(
                //           fontSize: 13,
                //           color: Colors.black,
                //           fontWeight: FontWeight.w500,
                //         )),
                //     onTap: () {
                //       _cekLokasi();
                //       if (_isActive) {
                //         setState(() {
                //           searchResults.sort((a, b) {
                //             var locationAlat = (a.data()
                //                 as Map<String, dynamic>)['latitude'] as double;
                //             var locationAlong = (a.data()
                //                 as Map<String, dynamic>)['longitude'] as double;
                //             var locationBlat = (b.data()
                //                 as Map<String, dynamic>)['latitude'] as double;
                //             var locationBlong = (b.data()
                //                 as Map<String, dynamic>)['longitude'] as double;

                //             double distanceA = calculateDistance(
                //                 _currentPosition!.latitude,
                //                 _currentPosition!.longitude,
                //                 locationAlat,
                //                 locationAlong);

                //             double distanceB = calculateDistance(
                //                 _currentPosition!.latitude,
                //                 _currentPosition!.longitude,
                //                 locationBlat,
                //                 locationBlong);

                //             return distanceA.compareTo(distanceB);
                //           });
                //         });
                //         print('aktif');
                //       } else {
                //         print('tidak');
                //         _listTerdekat();
                //       }
                //     }),
              ],
              //
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Iconsax.filter,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
        body: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              shape: const MyShapeBorder(),
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              toolbarHeight: 80,
              titleSpacing: 0.0,
              automaticallyImplyLeading: false,
              title: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                ),
                child: TextField(
                  controller: _searchController,
                  // onChanged: (value) {
                  //   setState(() {
                  //     listNamaOnSearch = listItem
                  //         .where((element) =>
                  //             element.toLowerCase().contains(value.toLowerCase()))
                  //         .toList();
                  //   });
                  // },

                  onChanged: ((value) => searchDocuments(value)),
                  style: const TextStyle(height: 1.2, color: Colors.black54),
                  // autofocus: true,
                  cursorColor: Colors.black54,
                  cursorWidth: 1.5,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: 'cari',
                    hintStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(
                      Iconsax.search_normal,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            body:
                // searchResults == null
                //     ? const Center(
                //         child: CircularProgressIndicator(),
                //       )
                //     // const Padding(
                //     //     padding: EdgeInsets.only(top: 20),
                //     //     child: Align(
                //     //       alignment: Alignment.topCenter,
                //     //       child: Text(
                //     //         'Wisata tidak ditemukan',
                //     //         style: TextStyle(
                //     //             fontWeight: FontWeight.w500, color: Colors.black54),
                //     //       ),
                //     //     ),
                //     //   )
                //     :
                Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: searchResults.length,
                itemBuilder: (BuildContext context, index) {
                  final document =
                      searchResults[index].data() as Map<String, dynamic>?;
                  final documentSend = searchResults[index];
                  ;
                  if (document != null) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(DetailScreen(wisata: documentSend),
                            transition: Transition.downToUp);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 15),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                child: document['image']
                                            .toString()
                                            .substring(0, 6) !=
                                        'assets'
                                    ? CachedNetworkImage(
                                        imageUrl: document['image'],
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      )
                                    : Image(
                                        height: 80,
                                        width: 80,
                                        image: AssetImage(document['image']),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 3),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 60),
                                  child: const Text(''),
                                ),
                                title: Text(
                                  document['nama'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Icon(
                                          FontAwesomeIcons.locationArrow,
                                          size: 13,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        flex: 5,
                                        child: Text(
                                          document['desa'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: Theme.of(context).primaryColor,
                                    size: 30.0,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )));
  }
}
