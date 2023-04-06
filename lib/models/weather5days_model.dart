// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class Wisata {
//   var temp;

//   Wisata({
//     required this.temp,
//   });
// }

// Future getWeather() async {
//   http.Response response = await http.get(Uri.parse(
//       "https://api.openweathermap.org/data/2.5/weather?lat=-6.6400000&lon=106.708000&units=metric&lang=id&appid=dbdeefdb6e461817032cc39199b4cc87"));
//   var results = jsonDecode(response.body);
//   temp = results['main']['temp'];
//   desc = results['weather'][0]['description'];
//   currently = results['weather'][0]['main'];
//   humidity = results['main']['humidity'];
//   windSpeed = results['wind']['speed'];
//   press = results['main']['pressure'];
//   tempMin = results['main']['temp_min'];
//   tempMax = results['main']['temp_max'];
//   setState(() {});
// }
