import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
import 'package:wisata_tenjolaya/models/wisata_model.dart';
import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AllCategoriesWidget extends StatefulWidget {
  // const AllCategoriesWidget({Key? key}) : super(key: key);
  @override
  State<AllCategoriesWidget> createState() => AllCategoriesWidgetState();
}

class AllCategoriesWidgetState extends State<AllCategoriesWidget> {
  // List wisata = listWisata;

  bool circular = true;

  Future<Wisata2?> getData() async {
    var res = await http.get(Uri.parse(
        "https://wisata-server-production.up.railway.app/wisata/api"));
    if (res.statusCode == 200) {
      // circular = true;
      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>);
      return Wisata2.fromJson(data);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Wisata2?>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return GridView.count(
          crossAxisCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: (150 / (MediaQuery.of(context).size.width * 0.5)),
          children: [
            for (int i = 0; i < snapshot.data!.data.length; i++)
              GestureDetector(
                onTap: () {
                  // Get.to(DetailScreen(wisata: snapshot.data!.data[i].id),
                  //     arguments: {
                  //       'nama': snapshot.data!.data[i].nama,
                  //       'desa': snapshot.data!.data[i].alamat.desa,
                  //       'kec': snapshot.data!.data[i].alamat.kec,
                  //       'lat': snapshot.data!.data[i].alamat.latitude,
                  //       'long': snapshot.data!.data[i].alamat.longitude,
                  //       'tiket': snapshot.data!['data'][i]['info']['tiket'],
                  //       'desc': snapshot.data!['data'][i]['info']['deskripsi'],
                  //       'tempClosed': snapshot.data!['data'][i]['tempClosed'],
                  //       'distance': snapshot.data!['data'][i]['distance'],
                  //       'hSenin': snapshot.data!['data'][i]['hariOp']['senin'],
                  //       'hSelasa': snapshot.data!['data'][i]['hariOp']
                  //           ['selasa'],
                  //       'hRabu': snapshot.data!['data'][i]['hariOp']['rabu'],
                  //       'hKamis': snapshot.data!['data'][i]['hariOp']['kamis'],
                  //       'hJumat': snapshot.data!['data'][i]['hariOp']['jumat'],
                  //       'hSabtu': snapshot.data!['data'][i]['hariOp']['sabtu'],
                  //       'hMinggu': snapshot.data!['data'][i]['hariOp']
                  //           ['minggu'],
                  //       'jSenin': snapshot.data!['data'][i]['jamOp']['senin'],
                  //       'jSelasa': snapshot.data!['data'][i]['jamOp']['selasa'],
                  //       'jRabu': snapshot.data!['data'][i]['jamOp']['rabu'],
                  //       'jKamis': snapshot.data!['data'][i]['jamOp']['kamis'],
                  //       'jJumat': snapshot.data!['data'][i]['jamOp']['jumat'],
                  //       'jSabtu': snapshot.data!['data'][i]['jamOp']['sabtu'],
                  //       'jMinggu': snapshot.data!['data'][i]['jamOp']['minggu']
                  //     },
                  //     transition: Transition.downToUp);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          // Get.to(
                          //     DetailScreen(
                          //         wisata: snapshot.data!['data'][i]['_id']),
                          //     arguments: {
                          //       'nama': snapshot.data!['data'][i]['nama']
                          //           .toString(),
                          //       'desa': snapshot.data!['data'][i]['alamat']
                          //           ['desa'],
                          //       'kec': snapshot.data!['data'][i]['alamat']
                          //           ['kec'],
                          //       'lat': snapshot.data!['data'][i]['alamat']
                          //           ['latitude'],
                          //       'long': snapshot.data!['data'][i]['alamat']
                          //           ['longitude'],
                          //       'tiket': snapshot.data!['data'][i]['info']
                          //           ['tiket'],
                          //       'desc': snapshot.data!['data'][i]['info']
                          //           ['deskripsi'],
                          //       'tempClosed': snapshot.data!['data'][i]
                          //           ['tempClosed'],
                          //       'distance': snapshot.data!['data'][i]
                          //           ['distance'],
                          //       'hSenin': snapshot.data!['data'][i]['hariOp']
                          //           ['senin'],
                          //       'hSelasa': snapshot.data!['data'][i]['hariOp']
                          //           ['selasa'],
                          //       'hRabu': snapshot.data!['data'][i]['hariOp']
                          //           ['rabu'],
                          //       'hKamis': snapshot.data!['data'][i]['hariOp']
                          //           ['kamis'],
                          //       'hJumat': snapshot.data!['data'][i]['hariOp']
                          //           ['jumat'],
                          //       'hSabtu': snapshot.data!['data'][i]['hariOp']
                          //           ['sabtu'],
                          //       'hMinggu': snapshot.data!['data'][i]['hariOp']
                          //           ['minggu'],
                          //       'jSenin': snapshot.data!['data'][i]['jamOp']
                          //           ['senin'],
                          //       'jSelasa': snapshot.data!['data'][i]['jamOp']
                          //           ['selasa'],
                          //       'jRabu': snapshot.data!['data'][i]['jamOp']
                          //           ['rabu'],
                          //       'jKamis': snapshot.data!['data'][i]['jamOp']
                          //           ['kamis'],
                          //       'jJumat': snapshot.data!['data'][i]['jamOp']
                          //           ['jumat'],
                          //       'jSabtu': snapshot.data!['data'][i]['jamOp']
                          //           ['sabtu'],
                          //       'jMinggu': snapshot.data!['data'][i]['jamOp']
                          //           ['minggu']
                          //     },
                          //     transition: Transition.downToUp);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: snapshot.data!.data[i].image != null
                              ? Image.network(
                                  snapshot.data!.data[i].image,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }

                                    return Container(
                                      color: Colors.grey[300],
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.38,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          color: Colors.grey[600],
                                          size: 64.0,
                                        ),
                                      ),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.width * 0.38,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                )
                              // Image.network(
                              //     '${snapshot.data!.data[i].image}', //     fit: BoxFit.cover,
                              //     // height: 150,
                              //     height:
                              //         MediaQuery.of(context).size.width * 0.38,
                              //     width:
                              //         MediaQuery.of(context).size.width * 0.5,
                              //   )
                              : Image(
                                  image: const AssetImage(
                                      'assets/images/curug-ciampea.jpg'),
                                  fit: BoxFit.cover,
                                  // height: 150,
                                  height:
                                      MediaQuery.of(context).size.width * 0.38,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
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
                            // mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 0,
                                child: Text(
                                  snapshot.data!.data[i].nama,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.locationArrow,
                                      size: 13,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 5),
                                  Text(
                                    snapshot.data!.data[i].alamat.desa,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
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
              ),
          ],
        );
      },
    );
  }
}
