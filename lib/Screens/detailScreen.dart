// import 'dart:html';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wisata_tenjolaya/Screens/maps.dart';

class DetailScreen extends StatefulWidget {
  // const DetailScreen({Key? key}) : super(key: key);

  // final AirTerjun airTerjun;
  // ignore: prefer_typing_uninitialized_variables
  final wisata;

  DetailScreen({required this.wisata});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

Completer<GoogleMapController> _controller = Completer();

final List<Marker> _marker = [];
String mapTheme = '';

class _DetailScreenState extends State<DetailScreen> {
  bool selected = false;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    polylinePoints = PolylinePoints();
    super.initState();
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
    CameraPosition _kGooglePlex = CameraPosition(
        target: LatLng(widget.wisata.lat, widget.wisata.long), zoom: 13);
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/standard_theme.json')
        .then((value) {
      mapTheme = value;
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
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
          InkWell(
            onTap: () {
              _marker.clear();
              _marker.add(Marker(
                markerId: const MarkerId('value'),
                position: LatLng(widget.wisata.lat, widget.wisata.long),
              ));
              showModalBottomSheet(
                  enableDrag: true,
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
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                // margin: const EdgeInsets.symmetric(
                                //     horizontal: 20, vertical: 15),
                                margin: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.wisata.nama,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
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
                                          Text(
                                            widget.wisata.alamatKec,
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
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 11,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GoogleMap(
                                      initialCameraPosition: _kGooglePlex,
                                      polylines: _polylines,
                                      markers: Set<Marker>.of(_marker),
                                      onMapCreated: (GoogleMapController
                                          controller) async {
                                        // _infoWindowController.googleMapController = controller;
                                        controller.setMapStyle(mapTheme);
                                        // setPolylines();
                                        PolylineResult result = await polylinePoints
                                            .getRouteBetweenCoordinates(
                                                "AIzaSyDl4Fhbf1GCIKOEbkyGkwsy5pZdX9JHZ28",
                                                const PointLatLng(
                                                  -6.67139,
                                                  106.70989,
                                                ),
                                                PointLatLng(widget.wisata.lat,
                                                    widget.wisata.long));
                                        if (result.status == 'OK') {
                                          for (var point in result.points) {
                                            polylineCoordinates.add(LatLng(
                                                point.latitude,
                                                point.longitude));
                                          }

                                          setState(() {
                                            _polylines.add(Polyline(
                                                polylineId:
                                                    PolylineId('polyLine'),
                                                width: 10,
                                                points: polylineCoordinates,
                                                color: Theme.of(context)
                                                    .primaryColor));
                                          });
                                        }
                                        // _controller.complete(controller);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  // height: 50,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: const Text('Lihat Rute')),
                                ))
                          ],
                        ));
                  });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 18),
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
                    // width: MediaQuery.of(context).size.width / 1.2,
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
                      Container(
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
                                // FontAwesomeIcons.locationDot,

                                color: Colors.white,
                                // size: 32,
                              ),
                            ],
                          ),
                        ),
                      ).asGlass(clipBorderRadius: BorderRadius.circular(20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),

          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.wisata.tempClosed == false
                  ? InkWell(
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
                                        // Icons.arrow_drop_down_circle_outlined,
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
                  : InkWell(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Container(
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
                              Text(
                                widget.wisata.tiket == 'Gratis'
                                    ? widget.wisata.tiket
                                    : 'Rp. ${widget.wisata.tiket}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
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
                              Column(
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
                                  widget.wisata.kategori == 'Air Terjun'
                                      ? Text(
                                          widget.wisata.camping == true
                                              ? 'Tersedia'
                                              : 'Tidak Tersedia',
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
                                        )
                                      : Text(
                                          widget.wisata.camping == true
                                              ? 'Tersedia'
                                              : 'Tidak Tersedia',
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
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
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
