import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // const AboutScreen({Key? key}) : super(key: key);
  final Uri _url = Uri.parse('https://flutter.dev');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          // style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          "About",
          style: const TextStyle(color: Colors.white),
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
              image: AssetImage("assets/images/WT.png"),
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
              "Versi : 1.0.0",
              style: TextStyle(fontWeight: FontWeight.w700),
            )),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Selamat datang di aplikasi WITE (Wisata Tenjolaya) Aplikasi ini dirancang untuk memudahkan Anda dalam mencari wisata di tenjolaya. Dengan fitur perkiraan cuaca di tenjolaya dan memiliki antarmuka yang intuitif, kami berusaha memberikan pengalaman terbaik bagi pengguna kami.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Informasi Pengembang",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  "Website : ",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      _launchURL("https://flutter.dev");
                      // launchUrl(_url);
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Klik di sini untuk membuka halaman web',
                        style: TextStyle(
                          overflow: TextOverflow.clip,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
            child: Text(
              "bantuan atau dukungan",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Jika Anda memerlukan bantuan atau memiliki pertanyaan, silakan hubungi tim dukungan kami melalui email anggaeriansyah43@gmail.com.",
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

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, universalLinksOnly: false);
  } else {
    print('Tidak dapat membuka $url');
  }
}

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
