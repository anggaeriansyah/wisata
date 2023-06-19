import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wisata_tenjolaya/Screens/DetailScreen.dart';
import 'package:wisata_tenjolaya/models/wisata_model.dart';

class AllCategoriesWidget extends StatelessWidget {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: db.collection('wisata').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.only(top: 50),
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black54)),
            );
          }
          if (snapshots.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          var wisata = snapshots.data!.docs;
          return GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // childAspectRatio: (160 / (MediaQuery.of(context).size.width * 0.5)),
            childAspectRatio: (153 / (MediaQuery.of(context).size.width * 0.5)),
            children: [
              for (int i = 0; i < wisata.length; i++)
                GestureDetector(
                  onTap: () {
                    Get.to(DetailScreen(wisata: wisata[i]),
                        transition: Transition.downToUp);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
                            Get.to(DetailScreen(wisata: wisata[i]),
                                transition: Transition.downToUp);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: wisata[i]
                                        .data()['image']
                                        .toString()
                                        .substring(0, 6) !=
                                    'assets'
                                ?
                                // Image.network(
                                //     wisata[i].data()['image'].toString(),
                                //     loadingBuilder: (BuildContext context,
                                //         Widget child,
                                //         ImageChunkEvent? loadingProgress) {
                                //       if (loadingProgress == null) {
                                //         return child;
                                //       } else {
                                //         return Container(
                                //           color: Colors.grey[300],
                                //           height: MediaQuery.of(context)
                                //                   .size
                                //                   .width *
                                //               0.38,
                                //           width: MediaQuery.of(context)
                                //                   .size
                                //                   .width *
                                //               0.5,
                                //           child: Center(
                                //             child: Icon(
                                //               Icons.image,
                                //               color: Colors.grey[600],
                                //               size: 64.0,
                                //             ),
                                //           ),
                                //         );
                                //       }
                                //     },
                                //     fit: BoxFit.cover,
                                //     height: MediaQuery.of(context).size.width *
                                //         0.38,
                                //     width:
                                //         MediaQuery.of(context).size.width * 0.5,
                                //   )
                                CachedNetworkImage(
                                    imageUrl: wisata[i].data()['image'],
                                    height: 150,
                                    // height: MediaQuery.of(context).size.height *
                                    //     0.18,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    fit: BoxFit.cover,
                                  )
                                : Image(
                                    image:
                                        AssetImage(wisata[i].data()['image']),
                                    fit: BoxFit.cover,
                                    // height: 150,
                                    height: 150,
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
                                    wisata[i].data()['nama'],
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
                                Expanded(
                                  flex: 0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                          flex: 0,
                                          child: Icon(
                                              FontAwesomeIcons.locationArrow,
                                              size: 13,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      const SizedBox(width: 5),
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          wisata[i].data()['desa'],
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                    ],
                                  ),
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
        });
  }
}
