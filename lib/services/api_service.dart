import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';

class ApiService {
  Future<Wisata2?> getData() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return null;
    } else {
      var res = await http.get(
          Uri.parse(
              "https://wisata-server-production.up.railway.app/wisata/api"),
          headers: {
            'Cache-Control': 'max-age=3600, public',
          });
      if (res.statusCode == 200) {
        Map<String, dynamic> data =
            (json.decode(res.body) as Map<String, dynamic>);
        return Wisata2.fromJson(data);
      } else {
        return null;
      }
    }
  }

  Future<Wisata2?> getDataRekreasi() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return null;
    } else {
      var res = await http.get(
          Uri.parse(
              "https://wisata-server-production.up.railway.app/wisata/api/rekreasi"),
          headers: {
            'Cache-Control': 'max-age=3600, public',
          });
      if (res.statusCode == 200) {
        Map<String, dynamic> data =
            (json.decode(res.body) as Map<String, dynamic>);
        return Wisata2.fromJson(data);
      } else {
        return null;
      }
    }
  }

  Future<Wisata2?> getDataAirTerjun() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return null;
    } else {
      var res = await http.get(
          Uri.parse(
              "https://wisata-server-production.up.railway.app/wisata/api/air-terjun"),
          headers: {
            'Cache-Control': 'max-age=3600, public',
          });
      if (res.statusCode == 200) {
        Map<String, dynamic> data =
            (json.decode(res.body) as Map<String, dynamic>);
        return Wisata2.fromJson(data);
      } else {
        return null;
      }
    }
  }

  Future<Wisata2?> getDataSitus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return null;
    } else {
      var res = await http.get(
          Uri.parse(
              "https://wisata-server-production.up.railway.app/wisata/api/situs"),
          headers: {
            'Cache-Control': 'max-age=3600, public',
          });
      if (res.statusCode == 200) {
        Map<String, dynamic> data =
            (json.decode(res.body) as Map<String, dynamic>);
        return Wisata2.fromJson(data);
      } else {
        return null;
      }
    }
  }
}
