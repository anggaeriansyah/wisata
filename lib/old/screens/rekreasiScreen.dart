// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:wisata_tenjolaya/models/categories_model.dart';

// class RekreasiScreen extends StatefulWidget {
//   // const rekreasiScreen({Key? key}) : super(key: key);

//   final Rekreasi rekreasi;

//   RekreasiScreen({required this.rekreasi});

//   @override
//   _RekreasiScreenState createState() => _RekreasiScreenState();
// }

// class _RekreasiScreenState extends State<RekreasiScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Stack(
//             children: <Widget>[
//               Container(
//                 height: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                   // borderRadius: BorderRadius.circular(20),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(1, 2),
//                       blurRadius: 6,
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   // borderRadius: BorderRadius.circular(20),
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                   child: Image(
//                     image: AssetImage(widget.rekreasi.image),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                   // borderRadius: BorderRadius.circular(20),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.transparent,
//                       Colors.transparent,
//                       Colors.black45
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       iconSize: 30,
//                       color: Colors.white,
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 left: 20,
//                 bottom: 20,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: Text(
//                         widget.rekreasi.nama,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 35,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       children: <Widget>[
//                         const Icon(
//                           FontAwesomeIcons.locationArrow,
//                           size: 35,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(
//                           width: 7,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.rekreasi.alamat,
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 15),
//                             ),
//                             Text(
//                               widget.rekreasi.alamatKec,
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 15),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Positioned(
//                 right: 20,
//                 bottom: 20,
//                 child: Icon(
//                   Icons.location_on_rounded,
//                   color: Colors.white,
//                   size: 35,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           // Container(
//           //   height: 100,
//           //   child: ListView.builder(
//           //     scrollDirection: Axis.horizontal,
//           //     itemCount: widget.rekreasi.imageGalerys.length,
//           //     itemBuilder: (BuildContext context, index) {
//           //       // ImageGalery imageGalery = widget.rekreasi.imageGalerys[index].img;
//           //       return Image(
//           //           image:
//           //               AssetImage(widget.rekreasi.imageGalerys.));
//           //     },
//           //   ),
//           // ),

//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 80,
//                   // width: 300,
//                   decoration: BoxDecoration(
//                     color: widget.rekreasi.hariOp == 'Tutup Sementara'
//                         ? Colors.red
//                         : Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(
//                         spreadRadius: -3,
//                         color: Colors.black26,
//                         offset: Offset(0, 2),
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             widget.rekreasi.tempClosed == true
//                                 ? const Text(
//                                     'Tutup Sementara',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 25,
//                                         color: Colors.white),
//                                   )
//                                 : widget.rekreasi.today == 'Buka'
//                                     ? Text(
//                                         'Buka',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                             color:
//                                                 Theme.of(context).primaryColor),
//                                       )
//                                     : const Text(
//                                         'Tutup',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 25,
//                                             color: Colors.red),
//                                       ),
//                             // Text(
//                             //   widget.rekreasi.everyday == true
//                             //       ? 'Setiap Hari'
//                             //       : widget.rekreasi.today,
//                             //   style:
//                             //       widget.rekreasi.hariOp == 'Tutup Sementara' ||
//                             //               widget.rekreasi.hariOp ==
//                             //                   'tutup sementara'
//                             //           ? TextStyle(
//                             //               fontWeight: FontWeight.bold,
//                             //               fontSize: 25,
//                             //               color: Colors.white)
//                             //           : TextStyle(
//                             //               fontWeight: FontWeight.bold,
//                             //               fontSize: 20,
//                             //             ),
//                             // ),
//                             const SizedBox(height: 4),
//                             widget.rekreasi.tempClosed == false
//                                 ? Text(
//                                     widget.rekreasi.jamOp[0],
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 15,
//                                         color: Theme.of(context).accentColor),
//                                   )
//                                 : const Icon(
//                                     FontAwesomeIcons.rotate,
//                                     size: 20,
//                                     color: Colors.white70,
//                                   )
//                           ],
//                         ),
//                         // widget.rekreasi.hariOpLainnya != ''
//                         //     ? Column(
//                         //         crossAxisAlignment: CrossAxisAlignment.end,
//                         //         mainAxisAlignment: MainAxisAlignment.center,
//                         //         children: [
//                         //           Text(widget.rekreasi.hariOpLainnya,
//                         //               style: TextStyle(
//                         //                   fontWeight: FontWeight.bold,
//                         //                   fontSize: 20)),
//                         //           SizedBox(height: 4),
//                         //           Text(
//                         //             widget.rekreasi.jamOpLainnya,
//                         //             style: TextStyle(
//                         //                 fontWeight: FontWeight.w600,
//                         //                 fontSize: 15,
//                         //                 color: Theme.of(context).accentColor),
//                         //           ),
//                         //         ],
//                         //       )
//                         //     : widget.rekreasi.hariOp == 'Tutup Sementara' ||
//                         //             widget.rekreasi.hariOp == 'tutup sementara'
//                         //         ? Icon(
//                         //             Icons.calendar_month,
//                         //             size: 40,
//                         //             color: Colors.white,
//                         //           )
//                         //         : Icon(
//                         //             Icons.calendar_month,
//                         //             size: 40,
//                         //           )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: Container(
//                       height: 70,
//                       width: 155,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: const [
//                           BoxShadow(
//                             spreadRadius: -3,
//                             color: Colors.black26,
//                             offset: Offset(0, 2),
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Tiket',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                   color: Theme.of(context).accentColor),
//                             ),
//                             const SizedBox(height: 4),
//                             widget.rekreasi.tiket == 'Gratis' ||
//                                     widget.rekreasi.tiket == 'gratis'
//                                 ? const Text('Gratis',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                         color: Colors.green))
//                                 : Text(
//                                     'Rp. ${widget.rekreasi.tiket}',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 20),
//                     child: Container(
//                       height: 70,
//                       width: 185,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: const [
//                           BoxShadow(
//                             spreadRadius: -3,
//                             color: Colors.black26,
//                             offset: Offset(0, 2),
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Penginapan',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                       color: Theme.of(context).accentColor),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   widget.rekreasi.penginapan == true
//                                       ? 'Tersedia'
//                                       : 'Tidak Tersedia',
//                                   style: TextStyle(
//                                     color:
//                                         widget.rekreasi.penginapan == 'Tersedia'
//                                             ? Colors.green
//                                             : Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
//                     child: Text(
//                       'Deskripsi :',
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
//                   widget.rekreasi.deskripsi,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
