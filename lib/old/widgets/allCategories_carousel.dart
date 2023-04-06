// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
// import 'package:wisata_tenjolaya/models/categories_model.dart';

// class SemuaCarousel extends StatelessWidget {
//   int now = DateTime.now().weekday.toInt() - 1;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: false,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: categories.first.allCategories.length,
//         itemBuilder: (BuildContext context, index) {
//           return GestureDetector(
//             onTap: () {
//               categories.first.allCategories[index].kategori == "Air Terjun"
//                   ? Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => DetailScreen(
//                           categori: categories.first.allCategories[index],
//                         ),
//                       ),
//                     )
//                   : categories.first.allCategories[index].kategori == "Rekreasi"
//                       ? Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => DetailScreen(
//                               categori: categories.first.allCategories[index],
//                             ),
//                           ),
//                         )
//                       : print('object');
//             },
//             child: Hero(
//               tag: 'tag-${categories.first.allCategories[index]}',
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                 child: Container(
//                   height: 92,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         offset: Offset(0, 2),
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: <Widget>[
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Image(
//                           height: 92,
//                           width: 92,
//                           image: AssetImage(
//                               categories.first.allCategories[index].image),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       ListTile(
//                           contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 10.0),
//                           leading: Container(
//                             padding: const EdgeInsets.only(right: 80),
//                             child: const Text(''),
//                           ),
//                           title: Text(
//                             categories.first.allCategories[index].nama,
//                             maxLines: 15,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

//                           subtitle: Row(
//                             children: <Widget>[
//                               Icon(FontAwesomeIcons.locationArrow,
//                                   size: 15,
//                                   color: Theme.of(context).primaryColor),
//                               Text(
//                                   " ${categories.first.allCategories[index].alamat}",
//                                   maxLines: 15,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(color: Colors.black))
//                             ],
//                           ),
//                           trailing: const Icon(Icons.keyboard_arrow_right,
//                               color: Colors.black, size: 30.0)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // final makeCard = Card(
// //   elevation: 9.0,
// //   margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
// //   child: Container(
// //     decoration: BoxDecoration(
// //         color: Colors.red, borderRadius: BorderRadius.circular(20)),
// //     // child: makeListTile,
// //   ),
// // );

// // final makeListTile = ListTile(
// //     contentPadding:
// //         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
// //     leading: Container(
// //       padding: const EdgeInsets.only(right: 12.0),
// //       decoration: BoxDecoration(
// //           // border: Border(right: BorderSide(width: 1.0, color: Colors.white)),
// //           borderRadius: BorderRadius.circular(20)),
// //       child: Icon(Icons.autorenew, color: Colors.black),
// //     ),
// //     title: Text(
// //       'tes',
// //       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
// //     ),
// //     // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

// //     subtitle: Row(
// //       children: <Widget>[
// //         Icon(Icons.linear_scale, color: Colors.yellowAccent),
// //         Text(" Intermediate", style: TextStyle(color: Colors.black))
// //       ],
// //     ),
// //     trailing:
// //         Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0));
