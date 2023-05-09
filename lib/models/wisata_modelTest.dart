import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wisata_tenjolaya/Screens/detailScreen.dart';

part 'wisata_modelTest.g.dart';

@JsonSerializable()
class Wisata2 {
  int cod;
  String message;
  List<Datum> data;

  Wisata2({
    required this.cod,
    required this.message,
    required this.data,
  });
  List get rekreasi =>
      data.where((element) => element.kategori == 'Rekreasi').toList();

  factory Wisata2.fromJson(Map<String, dynamic> json) =>
      _$Wisata2FromJson(json);
  Map<String, dynamic> toJson() => _$Wisata2ToJson(this);
}

@JsonSerializable()
class Datum {
  Alamat alamat;
  Info info;
  List<bool> hariOp;
  List<String> jamOp;
  List<String?> imageGaleries;
  String id;
  String nama;
  String image;
  bool tempClosed;
  String kategori;
  int distance;

  Datum({
    required this.alamat,
    required this.info,
    required this.hariOp,
    required this.jamOp,
    required this.imageGaleries,
    required this.id,
    required this.nama,
    required this.image,
    required this.tempClosed,
    required this.kategori,
    required this.distance,
  });

  getImageGaleries() {
    var list = [];
    imageGaleries.removeWhere((value) => value == null);
    // return imageGaleries;
    for (var i = 0; i < imageGaleries.length; i++) {
      list.add(
          'https://wisata-server-production.up.railway.app/images/${imageGaleries[i]!.substring(7)}');
    }
    return list;
  }

  int get jam {
    String j = DateFormat("HH").format(DateTime.now());
    int jData = int.parse(j);
    return jData;
  }

  String get menit {
    String m = DateFormat("mm").format(DateTime.now());
    return m;
  }

  bool get today {
    bool oc;
    int now = DateTime.now().weekday.toInt() - 1;
    String a = '$jam$menit';
    int an = int.parse(a);
    String b = jamOp[now] == 'Buka 24 jam' || jamOp[now] == 'Tutup'
        ? '0'
        : '${jamOp[now].substring(0, 2)}${jamOp[now].substring(3, 5)}';
    int bn = int.parse(b);
    String c = jamOp[now] == 'Buka 24 jam' || jamOp[now] == 'Tutup'
        ? '0'
        : '${jamOp[now].substring(8, 10)}${jamOp[now].substring(11, 13)}';
    int cn = int.parse(c);

    if (jamOp[now] == 'Buka 24 jam') {
      oc = true;
    } else if (hariOp[now] == true && an >= bn && an <= cn) {
      oc = true;
    } else {
      oc = false;
    }
    return oc;
  }

  bool get cek {
    bool ck;
    int now = DateTime.now().weekday.toInt() - 1;
    String a = '$jam$menit';
    int an = int.parse(a);
    String b = jamOp[now] == 'Buka 24 jam' || jamOp[now] == 'Tutup'
        ? '0'
        : '${jamOp[now].substring(0, 2)}${jamOp[now].substring(3, 5)}';
    int bn = int.parse(b);
    String c = jamOp[now] == 'Buka 24 jam' || jamOp[now] == 'Tutup'
        ? '0'
        : '${jamOp[now].substring(8, 10)}${jamOp[now].substring(11, 13)}';
    int cn = int.parse(c);

    if (hariOp[now] == true && (an <= cn)) {
      ck = true;
    } else {
      ck = false;
    }
    return ck;
  }

  String get closed {
    String clsd;
    int now = DateTime.now().weekday.toInt() - 1;
    String a = jamOp[now] == 'Buka 24 jam' || jamOp[now] == 'Tutup'
        ? '0'
        : '$jam$menit';
    int an = int.parse(a);
    String b = jamOp[now] == 'Buka 24 jam' || jamOp[now] == 'Tutup'
        ? '0'
        : '${jamOp[now].substring(0, 2)}${jamOp[now].substring(3, 5)}';
    int bn = int.parse(b);
    String c = jamOp[now] == 'Buka 24 jam' || jamOp[now] == 'Tutup'
        ? '0'
        : '${jamOp[now].substring(8, 10)}${jamOp[now].substring(11, 13)}';
    int cn = int.parse(c);

    if (jamOp[now] == 'Buka 24 jam') {
      clsd = "Buka 24 jam";
    } else if ((hariOp[now] == true && an >= bn) && (an < cn)) {
      clsd = 'Tutup pukul ${jamOp[now].substring(8, 13)}';
    } else {
      clsd = '';
    }
    return clsd;
  }

  String get open {
    String opn;
    String hr;
    int now = DateTime.now().weekday.toInt() - 1;
    int nxt = DateTime.now().weekday.toInt();
    if (nxt == 7) {
      nxt = 0;
    }
    switch (nxt) {
      case 0:
        hr = 'Senin';
        break;
      case 1:
        hr = 'Selasa';
        break;
      case 2:
        hr = 'Rabu';
        break;
      case 3:
        hr = 'Kamis';
        break;
      case 4:
        hr = 'Jum\'at';
        break;
      case 5:
        hr = 'Sabtu';
        break;
      case 6:
        hr = 'Minggu';
        break;
      default:
        hr = '';
    }

    if (hariOp[nxt] == true) {
      opn = 'Buka $hr pukul ${jamOp[nxt].substring(0, 5)}';
    } else {
      opn = 'Buka segera';
    }
    return opn;
  }

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Alamat {
  String desa;
  String kec;
  double latitude;
  double longitude;

  Alamat({
    required this.desa,
    required this.kec,
    required this.latitude,
    required this.longitude,
  });

  factory Alamat.fromJson(Map<String, dynamic> json) => _$AlamatFromJson(json);
  Map<String, dynamic> toJson() => _$AlamatToJson(this);
}

@JsonSerializable()
class Info {
  String tiket;
  String deskripsi;

  Info({
    required this.tiket,
    required this.deskripsi,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
