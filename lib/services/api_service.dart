import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';
// import 'user_model.dart';

// class ApiService {
//   static const _baseUrl =
//       "https://wisata-server-production.up.railway.app/wisata/api";

//   static Future<List<Wisata2>> getWisata() async {
//     final response = await http.get(Uri.parse(_baseUrl));
//     final json = jsonDecode(response.body);
//     final listWisata = json['data'] as List;
//     return listWisata.map((e) => Wisata2.fromJson(e)).toList();
//   }
// }
