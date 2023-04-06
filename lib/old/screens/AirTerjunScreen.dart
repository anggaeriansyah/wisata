// // import 'dart:html';

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:glass/glass.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:wisata_tenjolaya/Screens/maps.dart';
// import 'package:wisata_tenjolaya/models/categories_model.dart';

// class AirTerjunScreen extends StatefulWidget {
//   // const AirTerjunScreen({Key? key}) : super(key: key);

//   final AirTerjun airTerjun;

//   AirTerjunScreen({required this.airTerjun});

//   @override
//   _AirTerjunScreenState createState() => _AirTerjunScreenState();
// }

// Completer<GoogleMapController> _controller = Completer();

// final List<Marker> _marker = [];
// String mapTheme = '';

// class _AirTerjunScreenState extends State<AirTerjunScreen> {
//   bool selected = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int now = DateTime.now().weekday.toInt() - 1;
//     CameraPosition _kGooglePlex = CameraPosition(
//         target: LatLng(widget.airTerjun.lat, widget.airTerjun.long), zoom: 13);
//     DefaultAssetBundle.of(context)
//         .loadString('assets/maptheme/retro_theme.json')
//         .then((value) {
//       mapTheme = value;
//     });
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.black,
//             // size: 30,
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           // style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           widget.airTerjun.nama, style: const TextStyle(color: Colors.black),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 18),
//             child: Icon(
//               Icons.place_rounded,
//               // FontAwesomeIcons.locationDot,
//               color: Colors.black,
//               size: 30,
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         physics: const ScrollPhysics(),
//         // physics: const BouncingScrollPhysics(),
//         children: <Widget>[
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => PhotoView(
//                           imageProvider: AssetImage(widget.airTerjun.image),
//                           minScale: PhotoViewComputedScale.contained * 1,
//                           maxScale: PhotoViewComputedScale.covered * 1.1,
//                         )),
//               );
//             },
//             child: Stack(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
//                   child: Container(
//                     height: MediaQuery.of(context).size.width / 1.2,
//                     // width: MediaQuery.of(context).size.width / 1.2,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(20),
//                       ),
//                       child: Image(
//                         image: AssetImage(widget.airTerjun.image),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 30,
//                   bottom: 10,
//                   child: GestureDetector(
//                     onTap: () {
//                       _marker.add(Marker(
//                         markerId: const MarkerId('value'),
//                         position:
//                             LatLng(widget.airTerjun.lat, widget.airTerjun.long),
//                       ));
//                       showDialog(
//                         barrierDismissible: false,
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: const Text('Maps'),
//                           content: SizedBox(
//                             height: MediaQuery.of(context).size.height / 1.9,
//                             width: MediaQuery.of(context).size.width,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(5),
//                               child: GoogleMap(
//                                 initialCameraPosition: _kGooglePlex,
//                                 markers: Set<Marker>.of(_marker),
//                                 onMapCreated: (GoogleMapController controller) {
//                                   // _infoWindowController.googleMapController = controller;
//                                   controller.setMapStyle(mapTheme);
//                                   // _controller.complete(controller);
//                                 },
//                               ),
//                             ),
//                           ),
//                           actions: [
//                             Container(
//                               margin: const EdgeInsets.only(right: 15),
//                               child: TextButton(
//                                 style: TextButton.styleFrom(
//                                   backgroundColor:
//                                       Theme.of(context).primaryColor,
//                                   primary: Colors.white,
//                                   // padding: const EdgeInsets.all(16.0),
//                                   textStyle: const TextStyle(fontSize: 20),
//                                 ),
//                                 onPressed: () => Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const Maps()),
//                                 ),
//                                 child: const Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 10),
//                                   child: Text('Lihat Semua Wisata'),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(right: 15),
//                               child: TextButton(
//                                 style: TextButton.styleFrom(
//                                   backgroundColor:
//                                       Theme.of(context).primaryColor,
//                                   primary: Colors.white,
//                                   // padding: const EdgeInsets.all(16.0),
//                                   textStyle: const TextStyle(fontSize: 20),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   _marker.remove(_marker[0]);
//                                 },
//                                 child: const Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 10),
//                                   child: Text('kembali'),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                     child: Stack(
//                       children: <Widget>[
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 15, top: 5, bottom: 5, right: 10),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   widget.airTerjun.alamat,
//                                   style: const TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.white),
//                                 ),
//                                 const SizedBox(width: 7),
//                                 const Icon(
//                                   Icons.place_rounded,
//                                   // FontAwesomeIcons.locationDot,
//                                   color: Colors.white,
//                                   // size: 32,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ).asGlass(clipBorderRadius: BorderRadius.circular(20)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // SizedBox(
//           //   height: 10,
//           // ),

//           const SizedBox(
//             height: 20,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               widget.airTerjun.tempClosed == false
//                   ? Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 20),
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             spreadRadius: -2,
//                             color: Colors.black26,
//                             offset: Offset(0, 2),
//                             blurRadius: 7,
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           widget.airTerjun.today == true
//                               ? Text(
//                                   'Buka',
//                                   style: TextStyle(
//                                     color: Theme.of(context).primaryColor,
//                                     fontSize: 19,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 )
//                               : Text(
//                                   'Tutup',
//                                   style: TextStyle(
//                                     color: Colors.red.shade500,
//                                     fontSize: 19,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                           Row(
//                             children: [
//                               Text(
//                                 widget.airTerjun.today == true
//                                     ? widget.airTerjun.closed
//                                     : widget.airTerjun.cek == true
//                                         ? 'Buka pukul ${widget.airTerjun.jamOp[now].substring(0, 5)}'
//                                         : widget.airTerjun.open,
//                                 style: const TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selected = !selected;
//                                   });
//                                 },
//                                 child: Container(
//                                     padding: const EdgeInsets.all(5),
//                                     margin:
//                                         const EdgeInsets.symmetric(vertical: 8),
//                                     decoration: BoxDecoration(
//                                       color: Theme.of(context).primaryColor,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     child: Icon(
//                                       selected == true
//                                           ? FontAwesomeIcons.xmark
//                                           : FontAwesomeIcons.angleDown,
//                                       // Icons.arrow_drop_down_circle_outlined,
//                                       size: 22,
//                                       color: Colors.white,
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   : Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 20),
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             spreadRadius: -2,
//                             color: Colors.black26,
//                             offset: Offset(0, 2),
//                             blurRadius: 7,
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Tutup Sementara',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 19,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           Container(
//                               padding: const EdgeInsets.all(5),
//                               margin: const EdgeInsets.symmetric(vertical: 8),
//                               decoration: BoxDecoration(
//                                 // color: Colors.red,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: const Icon(
//                                 FontAwesomeIcons.solidCalendarXmark,
//                                 // FontAwesomeIcons.hourglass,
//                                 size: 22,
//                                 color: Colors.white,
//                               )),
//                         ],
//                       ),
//                     ),
//               selected == true
//                   ? Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 40),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 15),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20)),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: const [
//                               Text(
//                                 'Senin',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               Text('Selasa',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text('Rabu',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text('Kamis',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text('Jum\'at',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text('Sabtu',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text('Minggu',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(widget.airTerjun.jamOp[0],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text(widget.airTerjun.jamOp[1],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text(widget.airTerjun.jamOp[2],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text(widget.airTerjun.jamOp[3],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text(widget.airTerjun.jamOp[4],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text(widget.airTerjun.jamOp[5],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                               Text(widget.airTerjun.jamOp[6],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                   )),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   : Container(),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         height: 70,
//                         // width: MediaQuery.of(context).size.width / 2.16,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: const [
//                             BoxShadow(
//                               spreadRadius: -2,
//                               color: Colors.black26,
//                               offset: Offset(0, 2),
//                               blurRadius: 7,
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Tiket',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 15,
//                                     color: Theme.of(context).accentColor),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Rp. ${widget.airTerjun.tiket}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         height: 70,
//                         // width: MediaQuery.of(context).size.width / 2.16,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: const [
//                             BoxShadow(
//                               spreadRadius: -2,
//                               color: Colors.black26,
//                               offset: Offset(0, 2),
//                               blurRadius: 7,
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Camping',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 15,
//                                         color: Theme.of(context).accentColor),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     widget.airTerjun.camping == true
//                                         ? 'Tersedia'
//                                         : 'Tidak Tersedia',
//                                     style: const TextStyle(
//                                         // color: widget.airTerjun.camping ==
//                                         //             'Tersedia' ||
//                                         //         widget.airTerjun.camping ==
//                                         //             'tersedia'
//                                         //     ? Colors.green
//                                         //     : Theme.of(context).primaryColor,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 18,
//                                         overflow: TextOverflow.fade),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
//                     child: Text(
//                       'Deskripsi',
//                       style: TextStyle(
//                         fontSize: 19,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   widget.airTerjun.deskripsi,
//                   style: const TextStyle(
//                     color: Colors.black87,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               )
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               'Galeri',
//               style: TextStyle(
//                 fontSize: 19,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Container(
//               padding: const EdgeInsets.only(left: 20, bottom: 10),
//               height: 150,
//               child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: widget.airTerjun.imageGalerys.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Stack(
//                     alignment: Alignment.topLeft,
//                     children: [
//                       Container(
//                         width: 250,
//                         height: 150,
//                         padding: const EdgeInsets.only(right: 20),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PhotoView(
//                                   imageProvider: AssetImage(
//                                       widget.airTerjun.imageGalerys[index]),
//                                   minScale:
//                                       PhotoViewComputedScale.contained * 1,
//                                   maxScale:
//                                       PhotoViewComputedScale.covered * 1.1,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(20),
//                             ),
//                             child: Image(
//                               image: AssetImage(
//                                   widget.airTerjun.imageGalerys[index]),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
