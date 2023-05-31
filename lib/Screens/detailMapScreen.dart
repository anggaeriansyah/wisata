// import 'dart:html';

import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';

class DetailMapScreen extends StatefulWidget {
  // const DetailScreen({Key? key}) : super(key: key);

  // final AirTerjun airTerjun;
  // ignore: prefer_typing_uninitialized_variables
  final wisata;

  DetailMapScreen({required this.wisata});

  @override
  _DetailMapScreenState createState() => _DetailMapScreenState();
}

Completer<GoogleMapController> _controller = Completer();

final List<Marker> _marker = [];
String mapTheme = '';

class _DetailMapScreenState extends State<DetailMapScreen> {
  String? _currentAddressDesa;
  String? _currentAddressKec;
  Position? _currentPosition;
  double? _cLat;
  double? _cLong;
  bool _isActive = false;

  bool selected = false;
  final Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  // late LatLng source =
  // LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
  late LatLng destination = LatLng(widget.wisata.lat, widget.wisata.long);

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
  }

  void _cekLokasi() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      // _getCurrentPosition();
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
        _getPopup();
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
        _currentAddressDesa = place.subLocality.toString();
        _currentAddressKec = place.locality.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void drawPolyline(String placeId) {
    _polylines.clear();
    _polylines.add(Polyline(
        polylineId: PolylineId(placeId),
        visible: true,
        points: [
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          destination
        ],
        color: Colors.green,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        width: 5));
  }

  Future<void> _getPopup() async {
    drawPolyline(widget.wisata.lat.toString());

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng((_currentPosition!.latitude + destination.latitude) / 2,
          (_currentPosition!.longitude + destination.longitude) / 2),
      zoom: 12,
    );
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/standard_theme.json')
        .then((value) {
      mapTheme = value;
    });

    _marker.clear();
    _marker.add(Marker(
      markerId: const MarkerId('value'),
      position: LatLng(widget.wisata.lat, widget.wisata.long),
      icon: await getBitmapDescriptorFromAssetBytes(
          "assets/images/marker.png", 95),
    ));
    _marker.add(Marker(
        markerId: const MarkerId('value2'),
        position:
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        infoWindow: const InfoWindow(title: 'Lokasi saat ini')));
    showModalBottomSheet(
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
              height: 400,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          spreadRadius: -2,
                                          color: Colors.black12,
                                          offset: Offset(0, 2),
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Lokasi Saat ini',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                        ),
                                        const Divider(
                                          thickness: 0.5,
                                          height: 8,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          _currentAddressDesa == null
                                              ? 'loading'
                                              : _currentAddressDesa!,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Theme.of(context).primaryColor,
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          spreadRadius: -2,
                                          color: Colors.white12,
                                          offset: Offset(0, 2),
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.wisata.nama,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                        ),
                                        const Divider(
                                          thickness: 0.5,
                                          height: 8,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          widget.wisata.alamat,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
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
                  ),
                  Expanded(
                    flex: 12,
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GoogleMap(
                            initialCameraPosition: _kGooglePlex,
                            polylines: _polylines,
                            markers: Set<Marker>.of(_marker),
                            onMapCreated: (GoogleMapController controller) {
                              // _infoWindowController.googleMapController = controller;
                              controller.setMapStyle(mapTheme);
                              // _controller.complete(controller);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //     flex: 2,
                  //     child: SizedBox(
                  //       // height: 50,
                  //       child: TextButton(
                  //           onPressed: () async {
                  //             GoogleMapController controller =
                  //                 await _controller.future;
                  //             controller.animateCamera(
                  //               CameraUpdate.newCameraPosition(_kGooglePlex),
                  //             );
                  //           },
                  //           child: const Text('Semula')),
                  //     ))
                ],
              ));
        });
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

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(24.0, 15, 24.0, 10),
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: const Text('Perhatian!'),
          content: const Text(
            'Harga tiket sewaktu - waktu dapat berubah!',
            style: TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            const Divider(
              thickness: 1,
              height: 5,
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Kembali'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int now = DateTime.now().weekday.toInt() - 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        centerTitle: true,
        title: Text(
          // style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          widget.wisata.nama, style: const TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (_isActive) {
                _getPopup();
              } else {
                _getCurrentPosition();
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Icon(
                FontAwesomeIcons.route,
                // Icons.place_rounded,
                // FontAwesomeIcons.locationDot,
                color: Colors.black,
                // size: 30,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const ScrollPhysics(),
        // physics: const BouncingScrollPhysics(),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PhotoView(
                          imageProvider: AssetImage(widget.wisata.image),
                          minScale: PhotoViewComputedScale.contained * 1,
                          maxScale: PhotoViewComputedScale.covered * 1.1,
                        )),
              );
            },
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 1.2,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image(
                        image: AssetImage(widget.wisata.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  bottom: 10,
                  child: Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          if (_isActive) {
                            _getPopup();
                          } else {
                            _getCurrentPosition();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 5, bottom: 5, right: 10),
                            child: Row(
                              children: [
                                Text(
                                  widget.wisata.alamat,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(width: 7),
                                const Icon(
                                  Icons.place_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ).asGlass(clipBorderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.wisata.tempClosed == false
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: -2,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.wisata.today == true
                                ? Text(
                                    'Buka',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : Text(
                                    'Tutup',
                                    style: TextStyle(
                                      color: Colors.red.shade500,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                            Row(
                              children: [
                                Text(
                                  widget.wisata.today == true
                                      ? widget.wisata.closed
                                      : widget.wisata.cek == true
                                          ? 'Buka pukul ${widget.wisata.jamOp[now].substring(0, 5)}'
                                          : widget.wisata.open,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = !selected;
                                    });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        selected == true
                                            ? FontAwesomeIcons.xmark
                                            : FontAwesomeIcons.angleDown,
                                        size: 22,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: -2,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tutup Sementara',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.solidCalendarXmark,
                                // FontAwesomeIcons.hourglass,
                                size: 22,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
              selected == true
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Senin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text('Selasa',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('Rabu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('Kamis',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('Jum\'at',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('Sabtu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text('Minggu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  widget.wisata.jamOp[0] == 'Buka 24 jam' ||
                                          widget.wisata.jamOp[0] == 'Tutup'
                                      ? widget.wisata.jamOp[0]
                                      : widget.wisata.jamOp[0] + ' WIB',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  widget.wisata.jamOp[1] == 'Buka 24 jam' ||
                                          widget.wisata.jamOp[1] == 'Tutup'
                                      ? widget.wisata.jamOp[1]
                                      : widget.wisata.jamOp[1] + ' WIB',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  widget.wisata.jamOp[2] == 'Buka 24 jam' ||
                                          widget.wisata.jamOp[2] == 'Tutup'
                                      ? widget.wisata.jamOp[2]
                                      : widget.wisata.jamOp[2] + ' WIB',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  widget.wisata.jamOp[3] == 'Buka 24 jam' ||
                                          widget.wisata.jamOp[3] == 'Tutup'
                                      ? widget.wisata.jamOp[3]
                                      : widget.wisata.jamOp[3] + ' WIB',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  widget.wisata.jamOp[4] == 'Buka 24 jam' ||
                                          widget.wisata.jamOp[4] == 'Tutup'
                                      ? widget.wisata.jamOp[4]
                                      : widget.wisata.jamOp[4] + ' WIB',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  widget.wisata.jamOp[5] == 'Buka 24 jam' ||
                                          widget.wisata.jamOp[5] == 'Tutup'
                                      ? widget.wisata.jamOp[5]
                                      : widget.wisata.jamOp[5] + ' WIB',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  widget.wisata.jamOp[6] == 'Buka 24 jam' ||
                                          widget.wisata.jamOp[6] == 'Tutup'
                                      ? widget.wisata.jamOp[6]
                                      : widget.wisata.jamOp[6] + ' WIB',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 70,
                        // width: MediaQuery.of(context).size.width / 2.16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: -2,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tiket',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Theme.of(context).accentColor),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _dialogBuilder(context);
                                      },
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        color: Theme.of(context).accentColor,
                                        size: 20,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 4),
                              Flexible(
                                flex: 0,
                                child: Text(
                                  widget.wisata.tiket == 'Gratis'
                                      ? widget.wisata.tiket
                                      : 'Rp. ${widget.wisata.tiket}',
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      overflow: TextOverflow.fade),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 70,
                        // width: MediaQuery.of(context).size.width / 2.16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: -2,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.wisata.kategori == 'Rekreasi'
                                          ? 'Penginapan'
                                          : 'Camping',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Theme.of(context).accentColor),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.wisata.camping == true
                                          ? 'Tersedia'
                                          : 'Tidak Tersedia',
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                          // color: widget.wisata.camping ==
                                          //             'Tersedia' ||
                                          //         widget.wisata.camping ==
                                          //             'tersedia'
                                          //     ? Colors.green
                                          //     : Theme.of(context).primaryColor,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          overflow: TextOverflow.fade),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.wisata.deskripsi,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          widget.wisata.imageGalerys.length != 0
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Galeri',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : const SizedBox(),
          widget.wisata.imageGalerys.length != 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    height: 150,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.wisata.imageGalerys.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Container(
                              width: 250,
                              height: 150,
                              padding: const EdgeInsets.only(right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoView(
                                        imageProvider: AssetImage(
                                            widget.wisata.imageGalerys[index]),
                                        minScale:
                                            PhotoViewComputedScale.contained *
                                                1,
                                        maxScale:
                                            PhotoViewComputedScale.covered *
                                                1.1,
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  child: Image(
                                    image: AssetImage(
                                        widget.wisata.imageGalerys[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
