// // import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
// import 'package:wisata_tenjolaya/old/Screens/airTerjunScreen.dart';
// import 'package:wisata_tenjolaya/models/categories_model.dart';

// class RekomendasiCarousel extends StatefulWidget {
//   const RekomendasiCarousel({Key? key}) : super(key: key);

//   @override
//   State<RekomendasiCarousel> createState() => _RekomendasiCarouselState();
// }

// class _RekomendasiCarouselState extends State<RekomendasiCarousel> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   bool _isActive = false;
//   bool get isActive => _isActive;
//   List wisata = categories.first.allCategories;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(
//           height: 5,
//         ),
//         SizedBox(
//           height: 250,
//           // color: Colors.teal,
//           child: ListView.builder(
//             shrinkWrap: true,
//             semanticChildCount: 1,
//             physics: const BouncingScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             itemCount: wisata.length,
//             itemBuilder: (BuildContext context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   wisata[index].kategori == "Air Terjun"
//                       ? Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => AirTerjunScreen(
//                               airTerjun: wisata[index],
//                             ),
//                           ),
//                         )
//                       : wisata[index].kategori == "Rekreasi"
//                           ? Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => DetailScreen(
//                                   categori: wisata[index],
//                                 ),
//                               ),
//                             )
//                           // ignore: avoid_print
//                           : print('object');
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   // color: Colors.red,
//                   child: Stack(
//                     alignment: Alignment.topCenter,
//                     children: <Widget>[
//                       // Positioned(
//                       //   bottom: 0,
//                       //   child: Container(
//                       //     height: 100,
//                       //     width: 250,
//                       //     decoration: BoxDecoration(
//                       //       color: Colors.white,
//                       //       borderRadius: BorderRadius.circular(20),
//                       //       boxShadow: [
//                       //         BoxShadow(
//                       //           spreadRadius: -3,
//                       //           color: Colors.black26,
//                       //           offset: Offset(0, 1),
//                       //           blurRadius: 15,
//                       //         ),
//                       //       ],
//                       //     ),
//                       //     child: Padding(
//                       //       padding: EdgeInsets.symmetric(
//                       //         horizontal: 20,
//                       //         vertical: 13,
//                       //       ),
//                       //       child: Row(
//                       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //         children: [
//                       //           wisata[index].tempClosed ==
//                       //                   true
//                       //               ? Column(
//                       //                   mainAxisAlignment:
//                       //                       MainAxisAlignment.end,
//                       //                   crossAxisAlignment:
//                       //                       CrossAxisAlignment.center,
//                       //                   children: [
//                       //                     Padding(
//                       //                       padding:
//                       //                           EdgeInsets.only(bottom: 10),
//                       //                       child: Text(
//                       //                         wisata[index]
//                       //                             .hariOp,
//                       //                         style: TextStyle(
//                       //                             fontSize: 17,
//                       //                             color: Colors.red,
//                       //                             fontWeight: FontWeight.w600),
//                       //                       ),
//                       //                     ),
//                       //                   ],
//                       //                 )
//                       //               : Column(
//                       //                   mainAxisAlignment:
//                       //                       MainAxisAlignment.end,
//                       //                   crossAxisAlignment:
//                       //                       CrossAxisAlignment.start,
//                       //                   children: <Widget>[
//                       //                     Text(
//                       //                       wisata[index]
//                       //                               .everyday
//                       //                           ? 'Setiap Hari'
//                       //                           : DateTime.now()
//                       //                               .weekday
//                       //                               .toString(),
//                       //                       style: TextStyle(
//                       //                           fontSize: 17,
//                       //                           fontWeight: FontWeight.w600),
//                       //                     ),
//                       //                     SizedBox(height: 2),
//                       //                     Text(
//                       //                       wisata[index]
//                       //                           .jamOperasional,
//                       //                       // 'tesssssss',
//                       //                       style: TextStyle(
//                       //                           fontSize: 14,
//                       //                           color: Theme.of(context)
//                       //                               .accentColor,
//                       //                           fontWeight: FontWeight.w500),
//                       //                     ),
//                       //                   ],
//                       //                 ),
//                       //           // wisata[index]
//                       //           //             .hariOpLainnya ==
//                       //           //         ''
//                       //           //     ? wisata[index]
//                       //           //                 .hariOp !=
//                       //           //             'Tutup Sementara'
//                       //           //         ? Padding(
//                       //           //             padding: EdgeInsets.only(bottom: 5),
//                       //           //             child: Column(
//                       //           //               mainAxisAlignment:
//                       //           //                   MainAxisAlignment.end,
//                       //           //               crossAxisAlignment:
//                       //           //                   CrossAxisAlignment.end,
//                       //           //               children: [
//                       //           //                 GestureDetector(
//                       //           //                   onTap: () {
//                       //           //                     setState(() {
//                       //           //                       _isActive = !_isActive;
//                       //           //                       print(index);
//                       //           //                     });
//                       //           //                     // _isActive = true;
//                       //           //                   },
//                       //           //                   child: isActive == false
//                       //           //                       ? Icon(
//                       //           //                           Iconsax.heart,
//                       //           //                           size: 30,
//                       //           //                           color: Colors.grey,
//                       //           //                         )
//                       //           //                       : Icon(
//                       //           //                           Iconsax.heart5,
//                       //           //                           size: 30,
//                       //           //                           color: Colors.pink,
//                       //           //                         ),
//                       //           //                 ),
//                       //           //               ],
//                       //           //             ),
//                       //           //           )
//                       //           //         : Padding(
//                       //           //             padding:
//                       //           //                 EdgeInsets.only(bottom: 10),
//                       //           //             child: Column(
//                       //           //               mainAxisAlignment:
//                       //           //                   MainAxisAlignment.end,
//                       //           //               crossAxisAlignment:
//                       //           //                   CrossAxisAlignment.end,
//                       //           //               children: [
//                       //           //                 Icon(
//                       //           //                   FontAwesomeIcons.rotate,
//                       //           //                   size: 19,
//                       //           //                   color: Colors.red,
//                       //           //                 ),
//                       //           //               ],
//                       //           //             ),
//                       //           //           )
//                       //           //     : Column(
//                       //           //         mainAxisAlignment:
//                       //           //             MainAxisAlignment.end,
//                       //           //         crossAxisAlignment:
//                       //           //             CrossAxisAlignment.end,
//                       //           //         children: <Widget>[
//                       //           //           Text(
//                       //           //             categories
//                       //           //                 .first
//                       //           //                 .mostLikely[index]
//                       //           //                 .hariOpLainnya,
//                       //           //             style: TextStyle(
//                       //           //                 fontSize: 17,
//                       //           //                 fontWeight: FontWeight.w600),
//                       //           //           ),
//                       //           //           SizedBox(height: 2),
//                       //           //           Text(
//                       //           //             categories
//                       //           //                 .first
//                       //           //                 .mostLikely[index]
//                       //           //                 .jamOpLainnya,
//                       //           //             style: TextStyle(
//                       //           //                 fontSize: 14,
//                       //           //                 color: Theme.of(context)
//                       //           //                     .accentColor,
//                       //           //                 fontWeight: FontWeight.w500),
//                       //           //           ),
//                       //           //         ],
//                       //           //       ),
//                       //         ],
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                       Container(
//                         // // width: MediaQuery.of(context).size.width * 0.9,
//                         decoration: BoxDecoration(
//                           // color: Colors.blue,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black26,
//                               offset: Offset(0, 2),
//                               blurRadius: 10,
//                             ),
//                           ],
//                         ),
//                         child: Stack(children: <Widget>[
//                           Hero(
//                             tag: Text('${wisata[index].image}'),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: Image(
//                                 height: 220,
//                                 width: MediaQuery.of(context).size.width * 0.9,
//                                 image: AssetImage(wisata[index].image),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             child: Container(
//                               height: 160,
//                               width: 220,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [Colors.transparent, Colors.black38],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 10,
//                             bottom: 10,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   wisata[index].nama,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 3),
//                                 Row(
//                                   children: <Widget>[
//                                     const Icon(
//                                       FontAwesomeIcons.locationArrow,
//                                       size: 25,
//                                       color: Colors.white,
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           wisata[index].alamat,
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         Text(
//                                           wisata[index].alamatKec,
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ]),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
