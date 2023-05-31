import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
import 'package:wisata_tenjolaya/models/wisata_model.dart';
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

  String? _currentAddress;
  Position? _currentPosition;
  double? _cLat;
  double? _cLong;
  bool _isActive = false;
  bool onSearching = false;

  @override
  void initState() {
    super.initState();
    _cekLokasi();
    onGetNearby();
    setState(() {
      // listItemOnSearch = listItem;
    });
  }

  onSearch(String search) {
    // listItemOnSearch = widget.listItem;
    // listItemOnSearch = widget.listItem.where(
    //     (element) => element.data()['nama'].toLowerCase().contains(search));

    FirebaseFirestore.instance
        .collection('wisata')
        .where('nama', isGreaterThanOrEqualTo: search)
        .where('nama', isLessThanOrEqualTo: search + 'z')
        .get()
        .then(((QuerySnapshot querySnapshot) {
      listItemOnSearch = querySnapshot.docs;
    }));
    onSearching = true;

    setState(() {});
  }

  onGetNearby() {
    if (_isActive) {
      for (var i = 0; i < listItemOnSearch.length; i++) {
        listItemOnSearch[i].data()['latitude'] = double.parse(nearby(
            listItemOnSearch[i].data()['latitude'],
            listItemOnSearch[i].data()['longitude']));
      }
    }
    return;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  String nearby(double vLat, double vLong) {
    var distance;
    if (_isActive) {
      distance = calculateDistance(
          _currentPosition!.latitude, _currentPosition!.longitude, vLat, vLong);
    } else {
      distance = 0;
    }
    return distance.toStringAsFixed(2);
  }

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
          listItemOnSearch[i].distance = double.parse(calculateDistance(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                  listItemOnSearch[i].data()['latitude'],
                  listItemOnSearch[i].data()['longitude'])
              .toStringAsFixed(2));
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
          listItemOnSearch[i].distance = double.parse(calculateDistance(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                  listItemOnSearch[i].data()['latitude'],
                  listItemOnSearch[i].data()['longitude'])
              .toStringAsFixed(2));
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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Cari Wisata',
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
          actions: [
            PopupMenuButton(
              elevation: 3,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                PopupMenuItem(
                  height: kMinInteractiveDimension * 0.7,
                  child: const Text('A-Z',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                  onTap: () {
                    listItemOnSearch.sort(
                        (a, b) => a.data()['nama'].compareTo(b.data()['nama']));
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  height: kMinInteractiveDimension * 0.7,
                  child: const Text('Z-A',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                  onTap: () {
                    listItemOnSearch.sort(
                        (a, b) => b.data()['nama'].compareTo(a.data()['nama']));
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                    height: kMinInteractiveDimension * 0.7,
                    child: const Text('Jarak',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        )),
                    onTap: () {
                      if (_isActive) {
                        setState(() {
                          listItemOnSearch.sort((a, b) => a
                              .data()['distance']
                              .compareTo(b.data()['distance']));
                        });
                      } else {
                        _listTerdekat();
                      }
                    }),
              ],
              //
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Iconsax.filter,
                  color: Colors.black,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
        body: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 60,
              titleSpacing: 0.0,
              automaticallyImplyLeading: false,
              title: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                ),
                child: TextField(
                  // controller: _textEditingController,
                  // onChanged: (value) {
                  //   setState(() {
                  //     listNamaOnSearch = listItem
                  //         .where((element) =>
                  //             element.toLowerCase().contains(value.toLowerCase()))
                  //         .toList();
                  //   });
                  // },

                  onChanged: ((value) => onSearch(value)),
                  style: const TextStyle(height: 1.2, color: Colors.black54),
                  // autofocus: true,
                  cursorColor: Colors.black54,
                  cursorWidth: 1.5,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    filled: true,
                    fillColor: Colors.grey.shade100,
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
            body: !onSearching
                ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: db.collection('wisata').snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshots.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                      var listItem = snapshots.data!.docs;
                      listItemOnSearch = listItem;
                      return listItemOnSearch.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'Wisata tidak ditemukan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ),
                            )
                          : Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 0),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                itemCount: listItemOnSearch.length,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          DetailScreen(
                                              wisata: listItemOnSearch[index]),
                                          transition: Transition.downToUp);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 4,
                                        left: 20,
                                        right: 20,
                                        bottom: 15,
                                      ),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20)),
                                              child: Image(
                                                height: 80,
                                                width: 80,
                                                image: AssetImage(
                                                    listItemOnSearch[index]
                                                        .data()['image']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 3),
                                              leading: Container(
                                                padding: const EdgeInsets.only(
                                                    right: 60),
                                                child: const Text(''),
                                              ),
                                              title: Text(
                                                listItemOnSearch[index]
                                                    .data()['nama'],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .locationArrow,
                                                        size: 13,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Flexible(
                                                      flex: 5,
                                                      child: Text(
                                                        listItemOnSearch[index]
                                                            .data()['desa'],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        overflow:
                                                            TextOverflow.fade,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              trailing: _isActive
                                                  ? Text(
                                                      '${listItemOnSearch[index].data()['distance'].toString()} km',
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.right,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_right_rounded,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 30.0,
                                                      ),
                                                    )),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    })
                : listItemOnSearch.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Wisata tidak ditemukan',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 0),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: listItemOnSearch.length,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    DetailScreen(
                                        wisata: listItemOnSearch[index]),
                                    transition: Transition.downToUp);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 4,
                                  left: 20,
                                  right: 20,
                                  bottom: 15,
                                ),
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
                                        child: Image(
                                          height: 80,
                                          width: 80,
                                          image: AssetImage(
                                              listItemOnSearch[index]
                                                  .data()['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 3),
                                        leading: Container(
                                          padding:
                                              const EdgeInsets.only(right: 60),
                                          child: const Text(''),
                                        ),
                                        title: Text(
                                          listItemOnSearch[index]
                                              .data()['nama'],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                        ),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Icon(
                                                  FontAwesomeIcons
                                                      .locationArrow,
                                                  size: 13,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Flexible(
                                                flex: 5,
                                                child: Text(
                                                  listItemOnSearch[index]
                                                      .data()['desa'],
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
                                        trailing: _isActive
                                            ? Text(
                                                '${listItemOnSearch[index].data()['distance'].toString()} km',
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 2,
                                                textAlign: TextAlign.right,
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Icon(
                                                  Icons
                                                      .keyboard_arrow_right_rounded,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: 30.0,
                                                ),
                                              )),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )));
  }
}
