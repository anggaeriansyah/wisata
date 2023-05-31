import 'dart:async';
import 'dart:collection';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:glass/glass.dart';
import 'package:wisata_tenjolaya/models/wisata_model.dart';
import 'detailMapScreen.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    kategori();
    loadData();
    _cekLokasi();
    super.initState();

    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/standard_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  Position? _currentPosition;
  String? _currentAddress;
  bool _isActive = false;
  bool _onMove = false;

  var now = DateTime.now().weekday.toInt() - 1;

  void _cekLokasi() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      getLocation();
    } else {
      loadData();
    }
  }

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    _currentPosition = position;
    _isActive = true;

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(50.toString()),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: 'Lokasi saat ini'),
          onTap: () {
            _infoWindowController.hideInfoWindow!();
          }));
    });
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

  void getCurrent() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    _currentPosition = position;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 13)),
    );
    // _getAddressFromLatLng(_currentPosition!);
    _infoWindowController.hideInfoWindow!();
    _isActive = true;

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(50.toString()),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: 'Lokasi saat ini'),
          onTap: () {
            _infoWindowController.hideInfoWindow!();
          }));
    });
  }

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(-6.6400000, 106.708000), zoom: 13);

  final CustomInfoWindowController _infoWindowController =
      CustomInfoWindowController();

  String mapTheme = '';

  bool _isAirTerjun = false;
  // bool _isAirTerjunActive = false;
  bool _isRekreasi = false;
  // bool _isRekreasiActive = false;
  bool _isSitus = false;
  // bool _isSitusActive = false;
  bool _isAll = true;

  List kategori() {
    List listW;
    List airTerjun = listWisata
        .where((element) => element.kategori == 'Air Terjun')
        .toList();
    List rekreasi =
        listWisata.where((element) => element.kategori == 'Rekreasi').toList();
    List situs =
        listWisata.where((element) => element.kategori == 'Situs').toList();
    setState(() {});
    if (_isAirTerjun && _isRekreasi && _isSitus) {
      listW = listWisata;
      _isAll = true;
    } else if (_isAirTerjun && _isRekreasi) {
      listW = airTerjun + rekreasi;
      _isAll = false;
    } else if (_isRekreasi) {
      listW = rekreasi;
      _isAll = false;
    } else if (_isAirTerjun) {
      listW = airTerjun;
      _isAll = false;
    } else if (_isSitus) {
      listW = situs;
      _isAll = false;
    } else {
      listW = listWisata;
      _isAll = true;
    }
    return listW;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  final Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> points = const [
    LatLng(-6.715958, 106.730926),
    LatLng(-6.712839, 106.725821),
    LatLng(-6.706891, 106.720422),
    LatLng(-6.704236, 106.715780),
    LatLng(-6.698845, 106.710584),
    LatLng(-6.697333, 106.708581),
    LatLng(-6.694545, 106.706684),
    LatLng(-6.692586, 106.704864),
    LatLng(-6.691757, 106.702967),
    LatLng(-6.688216, 106.701677),
    LatLng(-6.686736, 106.699764), //curug ciampea
    LatLng(-6.681963, 106.695988),
    LatLng(-6.679024, 106.694471),
    LatLng(-6.671113, 106.698339),
    LatLng(-6.667270, 106.698946),
    LatLng(-6.665235, 106.697960),
    LatLng(-6.664557, 106.696215),
    LatLng(-6.655365, 106.691967),
    LatLng(-6.645795, 106.688857),
    LatLng(-6.633965, 106.687871),
    LatLng(-6.629219, 106.684740),
    LatLng(-6.621204, 106.684367),
    LatLng(-6.618511, 106.687320),
    LatLng(-6.615679, 106.688260),
    LatLng(-6.611984, 106.686924),
    LatLng(-6.609963, 106.687040),
    LatLng(-6.609155, 106.688202),
    LatLng(-6.607654, 106.687912),
    LatLng(-6.603224, 106.689516),
    LatLng(-6.604090, 106.693191), // turn2
    LatLng(-6.606627, 106.694437),
    LatLng(-6.606999, 106.695620),
    LatLng(-6.606484, 106.697133),
    LatLng(-6.605202, 106.697391),
    LatLng(-6.604006, 106.697133),
    LatLng(-6.604006, 106.699714),
    LatLng(-6.601272, 106.701520),
    LatLng(-6.598367, 106.701348),
    LatLng(-6.594351, 106.704187),
    LatLng(-6.589822, 106.708315),
    LatLng(-6.590249, 106.712788),
    LatLng(-6.594094, 106.712874),
    LatLng(-6.595291, 106.711326),
    LatLng(-6.598025, 106.711670),
    LatLng(-6.598879, 106.710552),
    LatLng(-6.601614, 106.710810),
    LatLng(-6.602041, 106.713648),
    LatLng(-6.603664, 106.715369),
    LatLng(-6.604861, 106.715541),
    LatLng(-6.605971, 106.714423),
    LatLng(-6.608279, 106.713906),
    LatLng(-6.609646, 106.712186),
    LatLng(-6.615370, 106.709606),
    LatLng(-6.618703, 106.713132),
    LatLng(-6.621864, 106.713046), //
    LatLng(-6.623915, 106.714681),
    LatLng(-6.626393, 106.714939),
    LatLng(-6.628101, 106.716401),
    LatLng(-6.630152, 106.714939),
    LatLng(-6.630579, 106.711756),
    LatLng(-6.634595, 106.711498),
    LatLng(-6.636902, 106.714078),
    LatLng(-6.643652, 106.716917),
    LatLng(-6.647155, 106.719756),
    LatLng(-6.649974, 106.719670),
    LatLng(-6.652537, 106.721906),
    LatLng(-6.652537, 106.721906),
    LatLng(-6.662277, 106.724314),
    LatLng(-6.667945, 106.725992),
    LatLng(-6.670190, 106.726032),
    LatLng(-6.676116, 106.727022),
    LatLng(-6.678081, 106.728530),
    LatLng(-6.680607, 106.729001),
    LatLng(-6.684163, 106.728624),
    LatLng(-6.685660, 106.729754),
    LatLng(-6.688374, 106.729377),
    LatLng(-6.691929, 106.730320),
    LatLng(-6.693707, 106.729001),
    LatLng(-6.696514, 106.729566),
    LatLng(-6.701379, 106.728059),
    LatLng(-6.702130, 106.731342),
    LatLng(-6.705601, 106.733205),
    LatLng(-6.715349, 106.733612),
  ];

  final List<Marker> _markers = [];

  loadData() async {
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/standard_theme.json')
        .then((value) {
      mapTheme = value;
    });

    List wisata = kategori();

    final icon =
        await getBitmapDescriptorFromAssetBytes("assets/images/marker.png", 88);
    for (int i = 0; i < wisata.length; i++) {
      dynamic placemarks =
          await placemarkFromCoordinates(wisata[i].lat, wisata[i].long);
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(wisata[i].lat, wisata[i].long),
            // icon: BitmapDescriptor.defaultMarkerWithHue(
            //     BitmapDescriptor.hueOrange),
            icon: icon,
            onTap: () {
              _infoWindowController.addInfoWindow!(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailMapScreen(
                          wisata: wisata[i],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 350,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 105,
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(wisata[i].image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Text(
                                    '${wisata[i].nama}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      overflow: TextOverflow.fade,
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: Icon(
                                        FontAwesomeIcons.locationArrow,
                                        size: 13,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${placemarks.first.subLocality.toString()}, ${placemarks.first.locality.toString()}',
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                const Divider(
                                  thickness: 1,
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    wisata[i].tempClosed
                                        ? const Text(
                                            'Tutup Sementara',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red),
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                          )
                                        : wisata[i].today == true
                                            ? Text(
                                                'Buka',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                              )
                                            : const Text(
                                                'Tutup',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                              ),
                                    wisata[i].tempClosed
                                        ? const Text('')
                                        : Text(
                                            wisata[i].today == true
                                                ? ' ⋅ ${wisata[i].closed}'
                                                : wisata[i].cek == true
                                                    ? ' ⋅ Buka pukul ${wisata[i].jamOp[now].substring(0, 5)}'
                                                    : " ⋅ ${wisata[i].open}",
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13,
                                            ),
                                          ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Icon(
                                //       FontAwesomeIcons.locationArrow,
                                //       size: 15,
                                //       color: Colors.black54,
                                //     ),
                                //     SizedBox(
                                //       width: 5,
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ).asGlass(
                    clipBorderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                LatLng(wisata[i].lat, wisata[i].long),
              );
            }),
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _polygon.add(
      Polygon(
          polygonId: const PolygonId('1'),
          points: points,
          // fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          fillColor: Colors.white.withOpacity(0.1),
          geodesic: true,
          strokeWidth: 1,
          strokeColor: Theme.of(context).primaryColor.withOpacity(0.8)),
    );
    List<PopupMenuEntry> popupMenuList = [
      PopupMenuItem(
        child: Text('Standard',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            )),
        onTap: () {
          _controller.future.then(
            (value) => DefaultAssetBundle.of(context)
                .loadString('assets/maptheme/standard_theme.json')
                .then((string) => value.setMapStyle(string)),
          );
        },
      ),
      PopupMenuItem(
        child: Text('Retro',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            )),
        onTap: () {
          _controller.future.then(
            (value) => DefaultAssetBundle.of(context)
                .loadString('assets/maptheme/retro_theme.json')
                .then((string) => value.setMapStyle(string)),
          );
        },
      ),
      PopupMenuItem(
        child: Text('Aubergine',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            )),
        onTap: () {
          _controller.future.then(
            (value) => DefaultAssetBundle.of(context)
                .loadString('assets/maptheme/aubergine_theme.json')
                .then((string) => value.setMapStyle(string)),
          );
        },
      ),
      PopupMenuItem(
        child: Text('Night',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            )),
        onTap: () {
          _controller.future.then((value) {
            DefaultAssetBundle.of(context)
                .loadString('assets/maptheme/night_theme.json')
                .then((string) => value.setMapStyle(string));
          });
        },
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   // backgroundColor: Colors.red,
      //   elevation: 0,
      //   toolbarHeight: 80,
      //   title: SizedBox(
      //     height: 50,
      //     child: TextField(
      //       onChanged: ((value) => onSearch(value)),
      //       style: const TextStyle(height: 1.2, color: Colors.black54),
      //       // autofocus: true,
      //       cursorColor: Colors.black54,
      //       cursorWidth: 1.5,
      //       decoration: InputDecoration(
      //         contentPadding: const EdgeInsets.all(0),
      //         filled: true,
      //         fillColor: Colors.white,
      //         border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(20),
      //             borderSide: BorderSide.none),
      //         hintText: 'cari wisata',
      //         hintStyle: const TextStyle(color: Colors.black38),
      //         prefixIcon: GestureDetector(
      //           // onTap: () =>Navigator.pop(context) ,
      //           child: const Icon(
      //             Icons.arrow_back_ios_rounded,
      //             color: Colors.grey,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      //   centerTitle: true,
      //   // backgroundColor: Theme.of(context).primaryColor,
      // ),

      appBar: AppBar(
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            // size: 30,
          ),
        ),
        title: const Text(
          'Peta Wisata',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
              icon: const Icon(
                // FontAwesomeIcons.layerGroup,
                FontAwesomeIcons.ellipsisVertical,
                color: Colors.black,
              ),
              elevation: 5,
              position: PopupMenuPosition.under,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              itemBuilder: (context) => popupMenuList)
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            // mapType: MapType.normal,
            myLocationButtonEnabled: false,
            compassEnabled: true,
            // myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
            polygons: _polygon,

            onMapCreated: (GoogleMapController controller) {
              _infoWindowController.googleMapController = controller;
              controller.setMapStyle(mapTheme);

              _controller.complete(controller);
            },
            onTap: (position) {
              _infoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _infoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: _infoWindowController,
            height: 200,
            width: 300,
            offset: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 85),
            child: SizedBox(
              height: 50,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      _isAll == true ? '' : _markers.clear();
                      GoogleMapController controller = await _controller.future;
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(_kGooglePlex),
                      );
                      _infoWindowController.hideInfoWindow!();
                      _isAll = true;
                      _isAirTerjun = false;
                      _isRekreasi = false;
                      _isSitus = false;

                      setState(() {
                        if (_isActive) {
                          _markers.add(Marker(
                              markerId: MarkerId(50.toString()),
                              position: LatLng(_currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              icon: BitmapDescriptor.defaultMarker));
                        }
                        loadData();
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 20, top: 10, right: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                            color: _isAll
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: -2,
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 7,
                              ),
                            ]),
                        child: Text(
                          'All',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: _isAll ? Colors.white : Colors.black),
                        )),
                  ),
                  InkWell(
                    onTap: () async {
                      _markers.clear();
                      GoogleMapController controller = await _controller.future;
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(_kGooglePlex),
                      );
                      _infoWindowController.hideInfoWindow!();
                      _isAll = false;
                      _isRekreasi = false;
                      _isSitus = false;
                      _isAirTerjun = !_isAirTerjun;
                      setState(() {
                        if (_isActive) {
                          _markers.add(Marker(
                              markerId: MarkerId(50.toString()),
                              position: LatLng(_currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              icon: BitmapDescriptor.defaultMarker));
                        }
                        loadData();
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, right: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                            color: _isAirTerjun
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: -2,
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 7,
                              ),
                            ]),
                        child: Text(
                          'Air Terjun',
                          style: TextStyle(
                              // fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  _isAirTerjun ? Colors.white : Colors.black),
                        )),
                  ),
                  InkWell(
                    onTap: () async {
                      // wisata.
                      _markers.clear();
                      GoogleMapController controller = await _controller.future;
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(_kGooglePlex),
                      );
                      _infoWindowController.hideInfoWindow!();
                      _isAll = false;
                      _isAirTerjun = false;
                      _isSitus = false;
                      _isRekreasi = !_isRekreasi;

                      setState(() {
                        if (_isActive) {
                          _markers.add(Marker(
                              markerId: MarkerId(50.toString()),
                              position: LatLng(_currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              icon: BitmapDescriptor.defaultMarker));
                        }
                        loadData();
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, right: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                            color: _isRekreasi
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: -2,
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 7,
                              ),
                            ]),
                        child: Text(
                          'Rekreasi',
                          style: TextStyle(
                              // fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _isRekreasi ? Colors.white : Colors.black),
                        )),
                  ),
                  InkWell(
                    onTap: () async {
                      _markers.clear();
                      GoogleMapController controller = await _controller.future;
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(_kGooglePlex),
                      );
                      _infoWindowController.hideInfoWindow!();
                      _isAll = false;
                      _isAirTerjun = false;
                      _isRekreasi = false;
                      _isSitus = !_isSitus;
                      setState(() {
                        if (_isActive) {
                          _markers.add(Marker(
                              markerId: MarkerId(50.toString()),
                              position: LatLng(_currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              icon: BitmapDescriptor.defaultMarker));
                        }
                        loadData();
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, right: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                            color: _isSitus
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: -2,
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 7,
                              ),
                            ]),
                        child: Text(
                          'Situs Prasejarah',
                          style: TextStyle(
                              // fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _isSitus ? Colors.white : Colors.black),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 155,
            right: 10,
            child: FloatingActionButton(
              mini: true,
              heroTag: '2',
              backgroundColor: Colors.white70,
              elevation: 0,
              tooltip: 'Show current position',
              onPressed: () async {
                if (_isActive) {
                  GoogleMapController controller = await _controller.future;
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(_currentPosition!.latitude,
                            _currentPosition!.longitude),
                        zoom: 13)),
                  );
                } else {
                  Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.medium)
                      .then((Position position) async {
                    setState(
                      () => _currentPosition = position,
                    );
                    GoogleMapController controller = await _controller.future;
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude),
                          zoom: 13)),
                    );
                    _infoWindowController.hideInfoWindow!();
                    _isActive = true;
                    setState(() {
                      _markers.add(Marker(
                          markerId: MarkerId(50.toString()),
                          position: LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude),
                          icon: BitmapDescriptor.defaultMarker,
                          infoWindow:
                              const InfoWindow(title: 'Lokasi saat ini'),
                          onTap: () {
                            _infoWindowController.hideInfoWindow!();
                          }));
                    });
                  }).catchError((e) {
                    debugPrint(e);
                  });
                }
                setState(() {});
              },
              child: Icon(
                FontAwesomeIcons.streetView,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            ),
          ),
          Positioned(
            bottom: 108,
            right: 10,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white70,
              elevation: 0,
              tooltip: 'Kembali ke posisi semula',
              onPressed: () async {
                GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(_kGooglePlex),
                );
                _infoWindowController.hideInfoWindow!();
                setState(() {});
              },
              child: Icon(
                FontAwesomeIcons.locationCrosshairs,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
