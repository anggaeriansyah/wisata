import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:wisata_tenjolaya/Screens/maps.dart';
import 'package:wisata_tenjolaya/Screens/searchScreen.dart';
import 'package:wisata_tenjolaya/Screens/weatherScreen.dart';
import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';
import 'package:wisata_tenjolaya/widgets/big_app_text.dart';
import 'package:wisata_tenjolaya/widgets/tabBar_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../widgets/big_app_text.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late TabController _tabController;

  cekKoneksi() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Tidak Ada Koneksi Internet'),
          content: Text('Pastikan Anda terhubung ke internet dan coba lagi.'),
          actions: [
            TextButton(
              child: Text('Tutup'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  // Future<List<Wisata2>>? futurWisata = null;
  // bool circular = false;
  // bool _isActive = false;

  String? _currentAddress;
  Position? _currentPosition;
  final List air = [];

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    // _tabController.addListener(_handleTabSelection);
    // _getCurrentPosition();
    // getData();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  // Future<Wisata2?> getData() async {
  //   var res = await http.get(
  //     Uri.parse("https://wisata-server-production.up.railway.app/wisata/api"),
  //     headers: {
  //       'Cache-Control': 'max-age=3600, public',
  //     },
  //   );
  //   if (res.statusCode == 200) {
  //     // circular = true;
  //     Map<String, dynamic> data =
  //         (json.decode(res.body) as Map<String, dynamic>);
  //     return Wisata2.fromJson(data);
  //   } else {
  //     return null;
  //   }
  // }

  Future<Wisata2?> getDataRekreasi() async {
    var res = await http.get(
      Uri.parse(
          "https://wisata-server-production.up.railway.app/wisata/api/rekreasi"),
      headers: {
        'Cache-Control': 'max-age=3600, public',
      },
    );
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

      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    Geolocator.getLastKnownPosition;
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      await Geolocator.checkPermission();
    } else {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
          .then((Position position) {
        setState(
          () => _currentPosition = position,
        );
        _getAddressFromLatLng(_currentPosition!);
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

  // _handleTabSelection() {
  //   if (_tabController.indexIsChanging) {
  //     setState(() {});
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
    // getData();
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // int _selectedDestination = 0;
    // TabController _tabController = TabController(length: 4, vsync: this);

    return Scaffold(
        // appBar: _isActive
        //     ? AppBar(
        //         toolbarHeight: kToolbarHeight * 0.7,
        //         elevation: 0,
        //         backgroundColor: Theme.of(context).primaryColor,
        //         title: Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             const Icon(
        //               Icons.place,
        //               color: Colors.white,
        //               size: 20,
        //             ),
        //             const SizedBox(
        //               width: 5,
        //             ),
        //             Expanded(
        //               child: Text(
        //                 _currentAddress ?? "",
        //                 style: const TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 14,
        //                     overflow: TextOverflow.fade),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     : AppBar(
        //         elevation: 0,
        //         toolbarHeight: 0,
        //         backgroundColor: Colors.white,
        //       ),
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
                const Expanded(
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
          body: RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: _refresh,
              child: TabBarWidget())),
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
