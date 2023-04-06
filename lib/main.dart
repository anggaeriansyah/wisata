import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/homeScreen.dart';
import 'package:get/get.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.black, // navigation bar color
  //   statusBarColor: Colors.white, // status bar color
  // ));

  WidgetsFlutterBinding.ensureInitialized();
  // await MongoDatabase.connect();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

Color _colorPrime = HexColor("#1C6758");
Color _colorSec = HexColor("#FFFFFF");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wisata Tenjolaya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // textTheme: GoogleFonts.rubikTextTheme(),
          primaryColor: _colorPrime,
          accentColor: Colors.grey.shade600,
          textSelectionColor: Colors.grey.shade300,
          canvasColor: _colorSec,
          scaffoldBackgroundColor: _colorSec),
      home: HomeScreen(),
    );
  }
}

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF" + hex.toUpperCase().replaceAll("#", "");
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}
