import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wisata_tenjolaya/models/wisata_model.dart';
import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';

import '../Screens/DetailScreen.dart';

class AirTerjunWidget extends StatelessWidget {
  // const AirTerjunWidget({Key? key}) : super(key: key);

  List airTerjun =
      listWisata.where((element) => element.kategori == 'Air Terjun').toList();

  // List a = Wisata2(cod: cod, message: message, data: data);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: (150 / 195),
      children: [
        for (int i = 0; i < airTerjun.length; i++)
          GestureDetector(
            onTap: () {
              Get.to(DetailScreen(wisata: airTerjun[i]),
                  transition: Transition.downToUp);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(DetailScreen(wisata: airTerjun[i]),
                          transition: Transition.downToUp);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: AssetImage(airTerjun[i].image),
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 5,
                      right: 5,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${airTerjun[i].nama}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.locationArrow,
                                  size: 13,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(width: 5),
                              Text(
                                airTerjun[i].alamat,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).accentColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';

// import '../Screens/DetailScreen.dart';

// class AirTerjunWidget extends StatefulWidget {
//   // const AirTerjunWidget({Key? key}) : super(key: key);

//   @override
//   State<AirTerjunWidget> createState() => AirTerjunWidgetState();
// }

// class AirTerjunWidgetState extends State<AirTerjunWidget> {
//   // late List<Map<String, dynamic>> listWisataAirTerjun;
//   // List airTerjun = listWisataAirTerjun;

//   // List airTerjun =
//   //     listWisata.where((element) => element.kategori == 'Air Terjun').toList();
//   Future<List<dynamic>?> getData() async {
//     var res = await http.get(Uri.parse(
//         "https://wisata-server-production.up.railway.app/wisata/api"));
//     if (res.statusCode == 200) {
//       var r = json.decode(res.body);
//       var data = r['data'] as List<dynamic>;
//       final filtered = data.where((e) => e["nama"] == 'curug ciampea').toList();
//       return filtered;
//     } else {
//       throw Exception('Failed to fetch data');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   // ignore: prefer_final_fields

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<dynamic>?>(
//       future: getData(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const CircularProgressIndicator();
//         } else {
//           final wisatas = snapshot.data!;
//           return GridView.count(
//             crossAxisCount: 2,
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             childAspectRatio: (150 / 195),
//             children: [
//               for (int i = 0; i < wisatas.length; i++)
//                 GestureDetector(
//                   onTap: () {
//                     Get.to(DetailScreen(wisata: wisatas[i]['_id']),
//                         arguments: {
//                           'nama': wisatas[i]['nama'],
//                           'desa': wisatas[i]['alamat']['desa'],
//                           'kec': wisatas[i]['alamat']['kec'],
//                           'lat': wisatas[i]['alamat']['latitude'],
//                           'long': wisatas[i]['alamat']['longitude'],
//                           'tiket': wisatas[i]['info']['tiket'],
//                           'desc': wisatas[i]['info']['deskripsi'],
//                           'tempClosed': wisatas[i]['tempClosed'],
//                           'distance': wisatas[i]['distance'],
//                           'hSenin': wisatas[i]['hariOp']['senin'],
//                           'hSelasa': wisatas[i]['hariOp']['selasa'],
//                           'hRabu': wisatas[i]['hariOp']['rabu'],
//                           'hKamis': wisatas[i]['hariOp']['kamis'],
//                           'hJumat': wisatas[i]['hariOp']['jumat'],
//                           'hSabtu': wisatas[i]['hariOp']['sabtu'],
//                           'hMinggu': wisatas[i]['hariOp']['minggu'],
//                           'jSenin': wisatas[i]['jamOp']['senin'],
//                           'jSelasa': wisatas[i]['jamOp']['selasa'],
//                           'jRabu': wisatas[i]['jamOp']['rabu'],
//                           'jKamis': wisatas[i]['jamOp']['kamis'],
//                           'jJumat': wisatas[i]['jamOp']['jumat'],
//                           'jSabtu': wisatas[i]['jamOp']['sabtu'],
//                           'jMinggu': wisatas[i]['jamOp']['minggu']
//                         },
//                         transition: Transition.downToUp);
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 10),
//                     margin: const EdgeInsets.only(
//                         top: 10, bottom: 10, left: 10, right: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.white,
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black26,
//                           offset: Offset(0, 2),
//                           blurRadius: 7,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Get.to(DetailScreen(wisata: wisatas[i]['_id']),
//                                 arguments: {
//                                   'nama': wisatas[i]['nama'],
//                                   'desa': wisatas[i]['alamat']['desa'],
//                                   'kec': wisatas[i]['alamat']['kec'],
//                                   'lat': wisatas[i]['alamat']['latitude'],
//                                   'long': wisatas[i]['alamat']['longitude'],
//                                   'tiket': wisatas[i]['info']['tiket'],
//                                   'desc': wisatas[i]['info']['deskripsi'],
//                                   'tempClosed': wisatas[i]['tempClosed'],
//                                   'distance': wisatas[i]['distance'],
//                                   'hSenin': wisatas[i]['hariOp']['senin'],
//                                   'hSelasa': wisatas[i]['hariOp']['selasa'],
//                                   'hRabu': wisatas[i]['hariOp']['rabu'],
//                                   'hKamis': wisatas[i]['hariOp']['kamis'],
//                                   'hJumat': wisatas[i]['hariOp']['jumat'],
//                                   'hSabtu': wisatas[i]['hariOp']['sabtu'],
//                                   'hMinggu': wisatas[i]['hariOp']['minggu'],
//                                   'jSenin': wisatas[i]['jamOp']['senin'],
//                                   'jSelasa': wisatas[i]['jamOp']['selasa'],
//                                   'jRabu': wisatas[i]['jamOp']['rabu'],
//                                   'jKamis': wisatas[i]['jamOp']['kamis'],
//                                   'jJumat': wisatas[i]['jamOp']['jumat'],
//                                   'jSabtu': wisatas[i]['jamOp']['sabtu'],
//                                   'jMinggu': wisatas[i]['jamOp']['minggu']
//                                 },
//                                 transition: Transition.downToUp);
//                           },
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Image(
//                               image:
//                                   AssetImage('assets/images/curug-ciampea.jpg'),
//                               fit: BoxFit.cover,
//                               height: 150,
//                               width: 150,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             top: 5,
//                             left: 5,
//                             right: 5,
//                           ),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   wisatas[i]['nama'],
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   softWrap: true,
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black),
//                                 ),
//                                 const SizedBox(height: 3),
//                                 Row(
//                                   children: <Widget>[
//                                     Icon(FontAwesomeIcons.locationArrow,
//                                         size: 13,
//                                         color: Theme.of(context).primaryColor),
//                                     const SizedBox(width: 5),
//                                     Text(
//                                       // airTerjun[i].alamat,
//                                       wisatas[i]['alamat']['desa'],
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w500,
//                                           color: Theme.of(context).accentColor),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//             ],
//           );
//         }
//       },
//     );
//   }
// }
