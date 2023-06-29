import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/homeScreen.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();
  // await MongoDatabase.connect();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

// Color _colorPrime = HexColor("#007273");
Color _colorPrime = HexColor("#1C6758");
Color _colorSec = HexColor("#F9F9F9");

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
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}
