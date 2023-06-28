import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          "About",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            // size: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Image(
              image: const AssetImage("assets/images/WT.png"),
              // fit: BoxFit.cover,
              // height: 150,
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
                child: Text(
              "Versi : 2.0.1",
              style: TextStyle(fontWeight: FontWeight.w700),
            )),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, bottom: 10, right: 20),
            child: Text(
              "Selamat datang di aplikasi Wisata Tenjolaya, Aplikasi ini dirancang untuk memudahkan Anda dalam mencari wisata di tenjolaya. Dengan fitur perkiraan cuaca di tenjolaya dan memiliki antarmuka yang intuitif, kami berusaha memberikan pengalaman terbaik bagi pengguna kami.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          //   child: Row(
          //     children: [
          //       const Text(
          //         "Website : ",
          //         style: TextStyle(
          //           color: Colors.black87,
          //           fontSize: 15,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //       // Flexible(
          //       //   child: InkWell(
          //       //     onTap: () => _launchURL("https://wisatatenjolaya.site/"),
          //       //     child: RichText(
          //       //       text: const TextSpan(
          //       //         text: 'www.wisatatenjolaya.site',
          //       //         style: TextStyle(
          //       //           overflow: TextOverflow.clip,
          //       //           color: Colors.blue,
          //       //           decoration: TextDecoration.underline,
          //       //         ),
          //       //       ),
          //       //     ),
          //       //   ),
          //       // )
          //     ],
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10, top: 20, right: 20),
            child: Text(
              "Informasi Pengembang",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Pengembang : Angga Eriansyah",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              children: [
                const Text(
                  "Email : ",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Flexible(
                  child: RichText(
                    text: const TextSpan(
                      text: 'anggaeriansyah43@gmail.com',
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: Colors.black,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 5, left: 20, right: 20),
          //   child: Row(
          //     children: [
          //       const Text(
          //         "LinkedIn : ",
          //         style: TextStyle(
          //           color: Colors.black87,
          //           fontSize: 15,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //       // Flexible(
          //       //   child: InkWell(
          //       //     onTap: () {
          //       //       _launchURL('https://www.linkedin.com/in/angga-eriansyah');
          //       //     },
          //       //     child: RichText(
          //       //       text: const TextSpan(
          //       //         text: 'www.linkedin.com/in/angga-eriansyah',
          //       //         style: TextStyle(
          //       //           overflow: TextOverflow.clip,
          //       //           color: Colors.blue,
          //       //           decoration: TextDecoration.underline,
          //       //         ),
          //       //       ),
          //       //     ),
          //       //   ),
          //       // )
          //     ],
          //   ),
          // ),

          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Text(
              "bantuan atau dukungan",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Jika Anda memerlukan bantuan atau memiliki pertanyaan, silakan hubungi tim dukungan kami ke email wisatatenjolaya@gmail.com",
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //   child: Row(
          //     children: [
          //       const Text(
          //         "Email : ",
          //         style: TextStyle(
          //           color: Colors.black87,
          //           fontSize: 15,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () async {
          //           // _launchGmail();
          //           await launch('mailto:wisatatenjolaya@gmail.com');
          //         },
          //         child: RichText(
          //           text: const TextSpan(
          //             text: 'wisatatenjolaya@gmail.com',
          //             style: TextStyle(
          //               overflow: TextOverflow.clip,
          //               color: Colors.blue,
          //               decoration: TextDecoration.underline,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // const Padding(
          //   padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          //   child: Text(
          //     "Penilaian Aplikasi",
          //     style: TextStyle(fontWeight: FontWeight.w700),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          //   child: Row(
          //     children: [
          //       const Text(
          //         "Link penilaian : ",
          //         style: TextStyle(
          //           color: Colors.black87,
          //           fontSize: 15,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //       Flexible(
          //         child: InkWell(
          //           onTap: () {
          //             _launchURL(
          //                 "https://docs.google.com/forms/d/e/1FAIpQLScxDIqPVFd1-9KeGASKMUQTmbBoGDLVvwyqyYjThdSHMp2D3w/viewform?usp=sf_link");
          //             // launchUrl(_url);
          //           },
          //           child: RichText(
          //             text: const TextSpan(
          //               text: 'Klik di sini',
          //               style: TextStyle(
          //                 overflow: TextOverflow.clip,
          //                 color: Colors.blue,
          //                 decoration: TextDecoration.underline,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          //   child: Row(
          //     children: [
          //       const Text(
          //         "Email : ",
          //         style: TextStyle(
          //           color: Colors.black87,
          //           fontSize: 15,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          // Flexible(
          //   child: InkWell(
          //     onTap: () {
          //       // _launchEmail(
          //       //     Uri.parse('mailto:anggaeriansyah43@example.com'));
          //       _launchEmailApp();
          //     },
          //     child: RichText(
          //       text: const TextSpan(
          //         text: 'Klik di sini untuk membuka halaman web',
          //         style: TextStyle(
          //           overflow: TextOverflow.clip,
          //           color: Colors.blue,
          //           decoration: TextDecoration.underline,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          //     ],
          //   ),
          // ),
        ],
      )),
    );
  }
}

// void _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url, forceSafariVC: false, universalLinksOnly: false);
//   } else {
//     print('Tidak dapat membuka $url');
//   }
// }

// void _launchEmail(Uri emailUri) async {
//   if (await canLaunch(emailUri.toString())) {
//     await launch(emailUri.toString());
//   } else {
//     throw 'Could not launch email';
//   }
// }

// void _launchEmailApp() async {
//   const emailUrl = 'mailto:';
//   if (await canLaunch(emailUrl)) {
//     await launch(emailUrl);
//   } else {
//     throw 'Could not launch email app';
//   }
// }
