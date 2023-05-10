// import 'dart:convert';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:http/http.dart' as http;
// import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// const apiUrl = 'https://wisata-server-production.up.railway.app/wisata/api';
// const apiUrlRek =
//     'https://wisata-server-production.up.railway.app/wisata/api/rekreasi';
// const apiUrlAir =
//     'https://wisata-server-production.up.railway.app/wisata/api/air-terjun';
// const apiUrlSitus =
//     'https://wisata-server-production.up.railway.app/wisata/api/situs';
// const cacheKey = 'wisata_data';

// class ApiService {
//   final CacheManager _cacheManager = DefaultCacheManager();
//   final CacheManager _cacheManagerAir = DefaultCacheManager();
//   final CacheManager _cacheManagerRek = DefaultCacheManager();
//   final CacheManager _cacheManagerSitus = DefaultCacheManager();

//   // ApiService() {}

//   Future<Wisata2?> getData() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     try {
//       FileInfo? fileInfo = await _cacheManager.getFileFromCache(apiUrl);
//       if (fileInfo != null && fileInfo.file.existsSync()) {
//         print('Data is cached, loading from cache');
//         final fileBytes = fileInfo.file.readAsBytesSync();
//         final fileContent = utf8.decode(fileBytes);
//         Map<String, dynamic> decodedMap = json.decode(fileContent);
//         // return Wisata2.fromJson(
//         //     fileInfo.file.readAsBytesSync() as Map<String, dynamic>);
//         return Wisata2.fromJson(decodedMap);
//       }

//       var res = await http.get(Uri.parse(apiUrl));
//       if (res.statusCode == 200) {
//         Map<String, dynamic> data =
//             (json.decode(res.body) as Map<String, dynamic>);
//         _cacheManager.putFile(apiUrl, res.bodyBytes);
//         return Wisata2.fromJson(data);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       throw Exception('Failed to load data: $e');
//     }
//   }

//   Future<Wisata2?> getDataRekreasi() async {
//     try {
//       await DefaultCacheManager().removeFile(apiUrl);
//       FileInfo? fileInfo = await _cacheManagerRek.getFileFromCache(apiUrlRek);
//       // if (fileInfo != null && fileInfo.file.existsSync()) {
//       //   print('Data is cached, loading from cache');
//       //   final fileBytes = fileInfo.file.readAsBytesSync();
//       //   final fileContent = utf8.decode(fileBytes);
//       //   Map<String, dynamic> decodedMap = json.decode(fileContent);
//       //   // return Wisata2.fromJson(
//       //   //     fileInfo.file.readAsBytesSync() as Map<String, dynamic>);
//       //   return Wisata2.fromJson(decodedMap);
//       // }

//       var res = await http.get(Uri.parse(apiUrlRek));
//       if (res.statusCode == 200) {
//         Map<String, dynamic> data =
//             (json.decode(res.body) as Map<String, dynamic>);
//         _cacheManagerRek.putFile(apiUrlRek, res.bodyBytes);
//         return Wisata2.fromJson(data);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       throw Exception('Failed to load data: $e');
//     }
//   }

//   Future<Wisata2?> getDataAirTerjun() async {
//     try {
//       FileInfo? fileInfo = await _cacheManagerAir.getFileFromCache(apiUrlAir);
//       // if (fileInfo != null && fileInfo.file.existsSync()) {
//       //   print('Data is cached, loading from cache');
//       //   final fileBytes = fileInfo.file.readAsBytesSync();
//       //   final fileContent = utf8.decode(fileBytes);
//       //   Map<String, dynamic> decodedMap = json.decode(fileContent);
//       //   // return Wisata2.fromJson(
//       //   //     fileInfo.file.readAsBytesSync() as Map<String, dynamic>);
//       //   return Wisata2.fromJson(decodedMap);
//       // }

//       var res = await http.get(Uri.parse(apiUrlAir));
//       if (res.statusCode == 200) {
//         Map<String, dynamic> data =
//             (json.decode(res.body) as Map<String, dynamic>);
//         await _cacheManagerAir.putFile(apiUrlAir, res.bodyBytes);
//         return Wisata2.fromJson(data);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       throw Exception('Failed to load data: $e');
//     }
//   }

//   Future<Wisata2?> getDataSitus() async {
//     try {
//       FileInfo? fileInfo =
//           await _cacheManagerSitus.getFileFromCache(apiUrlSitus);
//       // if (fileInfo != null && fileInfo.file.existsSync()) {
//       //   print('Data is cached, loading from cache');
//       //   final fileBytes = fileInfo.file.readAsBytesSync();
//       //   final fileContent = utf8.decode(fileBytes);
//       //   Map<String, dynamic> decodedMap = json.decode(fileContent);
//       //   // return Wisata2.fromJson(
//       //   //     fileInfo.file.readAsBytesSync() as Map<String, dynamic>);
//       //   return Wisata2.fromJson(decodedMap);
//       // }

//       var res = await http.get(Uri.parse(apiUrlSitus));
//       if (res.statusCode == 200) {
//         Map<String, dynamic> data =
//             (json.decode(res.body) as Map<String, dynamic>);
//         await _cacheManagerSitus.putFile(apiUrlSitus, res.bodyBytes);
//         return Wisata2.fromJson(data);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       throw Exception('Failed to load data: $e');
//     }
//   }
// }

import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/js.dart';
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

  Future<Wisata2?> getDataAscending() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return null;
    } else {
      var res = await http.get(
          Uri.parse(
              "https://wisata-server-production.up.railway.app/wisata/api/asc"),
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

  Future<Wisata2?> getDataDescending() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return null;
    } else {
      var res = await http.get(
          Uri.parse(
              "https://wisata-server-production.up.railway.app/wisata/api/desc"),
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
