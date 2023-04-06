// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
// import 'package:wisata_tenjolaya/models/categories_model.dart';

// class AirTerjun2Carousel extends StatelessWidget {
//   int now = DateTime.now().weekday.toInt() - 1;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 310,
//           // color: Colors.teal,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: categories.first.airTerjun.length,
//             itemBuilder: (BuildContext context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DetailScreen(
//                         categori: categories.first.airTerjun[index],
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 250,
//                   margin: const EdgeInsets.fromLTRB(10, 10, 10, 17),
//                   // color: Colors.red,
//                   child: Stack(
//                     alignment: Alignment.topCenter,
//                     children: <Widget>[
//                       Positioned(
//                         bottom: 0,
//                         child: Container(
//                           height: 100,
//                           width: 250,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: const [
//                               BoxShadow(
//                                 spreadRadius: -3,
//                                 color: Colors.black26,
//                                 offset: Offset(0, 1),
//                                 blurRadius: 15,
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 20,
//                               vertical: 13,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 categories.first.airTerjun[index].tempClosed ==
//                                         true
//                                     ? Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: const [
//                                           Padding(
//                                             padding:
//                                                 EdgeInsets.only(bottom: 10),
//                                             child: Text(
//                                               'Tutup Sementara',
//                                               style: TextStyle(
//                                                   fontSize: 17,
//                                                   color: Colors.red,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     : Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           categories.first.airTerjun[index]
//                                                       .hariOp[now.toInt()] ==
//                                                   true
//                                               ? Text(
//                                                   'Buka',
//                                                   style: TextStyle(
//                                                       fontSize: 17,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Theme.of(context)
//                                                           .primaryColor),
//                                                 )
//                                               : const Text(
//                                                   'Tutup',
//                                                   style: TextStyle(
//                                                       fontSize: 17,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Colors.red),
//                                                 ),
//                                           const SizedBox(height: 2),
//                                           Text(
//                                             categories.first.airTerjun[index]
//                                                 .jamOp[now.toInt()],
//                                             style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Theme.of(context)
//                                                     .accentColor,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ],
//                                       ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: const [
//                                       Icon(
//                                         Icons.date_range_outlined,
//                                         size: 30,
//                                         color: Colors.grey,
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
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
//                             tag: Text(
//                                 '${categories.first.airTerjun[index].image}'),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: Image(
//                                 height: 220,
//                                 width: 220,
//                                 image: AssetImage(
//                                     categories.first.airTerjun[index].image),
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
//                                   categories.first.airTerjun[index].nama,
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
//                                           categories
//                                               .first.airTerjun[index].alamat,
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         Text(
//                                           categories
//                                               .first.airTerjun[index].alamatKec,
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
