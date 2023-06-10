// import 'dart:ffi';

import 'package:intl/intl.dart';

class Wisata {
  String image;
  String nama;
  String alamat;
  String alamatKec;
  List<bool> hariOp;
  List<String> jamOp;
  bool tempClosed;
  bool camping;
  String tiket;
  String deskripsi;
  List<String> imageGalerys;
  double lat;
  double long;
  double distance;
  String kategori;

  // List get allCategories {
  //   List koleksi = [];
  //   for (var i = 0; i < categories.first.airTerjun.length; i++) {
  //     koleksi.add(categories.first.airTerjun[i]);
  //   }
  //   for (var i = 0; i < categories.first.rekreasi.length; i++) {
  //     koleksi.add(categories.first.rekreasi[i]);
  //   }
  //   return koleksi;
  // }

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

    String a = '${listWisata.first.jam}${listWisata.first.menit}';
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
    String a = '${listWisata.first.jam}${listWisata.first.menit}';
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
        : '${listWisata.first.jam}${listWisata.first.menit}';
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

  void setHariOp(bool senin, bool selasa, bool rabu, bool kamis, bool jumat,
      bool sabtu, bool minggu) {
    hariOp = [senin, selasa, rabu, kamis, jumat, sabtu, minggu];
  }

  Wisata({
    required this.image,
    required this.nama,
    required this.alamat,
    required this.alamatKec,
    required this.hariOp,
    required this.jamOp,
    required this.tempClosed,
    required this.camping,
    required this.tiket,
    required this.deskripsi,
    required this.imageGalerys,
    required this.lat,
    required this.long,
    required this.distance,
    required this.kategori,
  });

  static fromJson(x) {}
}

List<Wisata> listWisata = [
  Wisata(
    image: 'assets/images/curug-ciampea.jpg',
    nama: 'Curug Ciampea',
    alamat: 'Tapos I',
    alamatKec: 'Kecamatan Tenjolaya',
    hariOp: [true, true, true, true, true, true, true],
    tempClosed: false,
    jamOp: [
      '07:00 - 17:30',
      '07:00 - 17:30',
      '07:30 - 17:30',
      '07:30 - 17:30',
      '07:30 - 17:30',
      '07:00 - 17:30',
      '07:00 - 17:30',
    ],
    camping: true,
    tiket: '22.000',
    deskripsi:
        'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
    imageGalerys: [
      'assets/images/curug-ciampea-kemah.jpg',
      'assets/images/curug-ciampea-green-lagoon.webp'
    ],
    lat: -6.6867448,
    long: 106.6999085,
    distance: 0.0,
    kategori: 'Air Terjun',
  ),
  Wisata(
    image: 'assets/images/curug-ciputri.jpg',
    nama: 'Curug Ciputri',
    alamat: 'Tapos I',
    alamatKec: 'Kecamatan Tenjolaya',
    hariOp: [true, true, true, true, true, true, true],
    jamOp: [
      'Buka 24 jam',
      'Buka 24 jam',
      'Buka 24 jam',
      'Buka 24 jam',
      'Buka 24 jam',
      'Buka 24 jam',
      'Buka 24 jam',
    ],
    tempClosed: false,
    camping: true,
    tiket: '50.000',
    deskripsi:
        'Curug Ciputri adalah destinasi wisata alam yang berlokasi di kaki Gunung Salak, serta suguhan utama dari lokasi wisata tersebut adalah pesona air terjun dan area camping ground.',
    imageGalerys: ['assets/images/curug-ciputri-area-camping-ground.jpg'],
    lat: -6.6762553,
    long: 106.7069437,
    distance: 0.0,
    kategori: 'Air Terjun',
  ),
  Wisata(
    image: 'assets/images/curug-luhur.jpg',
    nama: 'Curug Luhur',
    alamat: 'Tapos I',
    alamatKec: 'Kecamatan Tenjolaya',
    hariOp: [true, true, true, true, true, true, true],
    jamOp: [
      '08:00 - 18:00',
      '08:00 - 18:00',
      '08:00 - 18:00',
      '08:00 - 18:00',
      '08:00 - 18:00',
      '08:00 - 18:00',
      '08:00 - 18:00',
    ],
    tempClosed: false,
    camping: true,
    tiket: '50.000',
    deskripsi:
        'Curug Luhur ialah wisata air terjun dengan adanya konsep waterboom dibalik indahnya curug yang mengalir, konsep ini sangat jarang sekali digunakan, keberadaan waterboom di Curug Luhur Bogor menjadi daya tarik tersendiri bagi para pengunjung yang ingin bermain air.',
    imageGalerys: [
      'assets/images/curug-luhur2.jpeg',
      'assets/images/waterboom-Curug-Luhur.jpg',
    ],
    lat: -6.6568834,
    long: 106.7036733,
    distance: 0.0,
    kategori: 'Air Terjun',
  ),
  Wisata(
      image: 'assets/images/kampung-istal.jpeg',
      nama: 'Kampung Istal',
      alamat: 'Gunung Malang',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [true, true, true, true, true, true, true],
      tempClosed: false,
      jamOp: [
        '07:00 - 17:30',
        '07:00 - 17:30',
        '07:00 - 17:30',
        '07:00 - 17:30',
        '07:00 - 17:30',
        '07:00 - 17:30',
        '07:00 - 17:30',
      ],
      tiket: '10.000',
      camping: true,
      deskripsi:
          'Wisata Kampung Istal Bogor menyuguhkan pesona alam yang begitu memukau, Pemandangan hijau berupa view Gunung Salak Bogor dipadukan dengan hawa sejuk khas pegunungan akan menjadi sajian utama di tempat wisata ini, Selain itu wisata populer di Bogor ini tentunya memiliki fasilitas dan wahana seru untuk dinikmati wisatawan.',
      lat: -6.664888,
      long: 106.7114566,
      distance: 0.0,
      kategori: 'Rekreasi',
      imageGalerys: [
        'assets/images/kampung-istal.jpeg',
      ]),
  Wisata(
      image: 'assets/images/tenjolaya-park.jpg',
      nama: 'Tenjolaya Park',
      alamat: 'Gunung Malang',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [false, true, true, false, false, true, true],
      tempClosed: false,
      jamOp: [
        '09:00 - 16:00',
        '09:00 - 16:00',
        '09:00 - 16:00',
        '09:00 - 16:00',
        '09:00 - 16:00',
        '09:00 - 16:00',
        '09:00 - 16:00',
      ],
      tiket: '10.000',
      camping: true,
      deskripsi:
          'Bogor Tenjolaya Park memiliki panorama Gunung Salak dan lanskap perdesaan yang indah. Anda bisa mengambil foto di banyak titik di Bogor Tenjolaya Park, seperti di Papan I LOVE U, Rumah Pohon, dan Rumah Hobit.',
      lat: -6.6689736,
      long: 106.7035867,
      distance: 0.0,
      kategori: 'Rekreasi',
      imageGalerys: [
        'assets/images/tenjolaya-park.jpg',
        'assets/images/tenjolaya-park-1.jpg',
      ]),
  Wisata(
      image: 'assets/images/aldepos-salaca.jpg',
      nama: 'Aldepos Salaca',
      alamat: 'Tapos II',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [true, true, true, true, true, true, true],
      tempClosed: false,
      jamOp: [
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
      ],
      tiket: 'Gratis',
      camping: true,
      deskripsi:
          'Wisata Kampung Istal Bogor menyuguhkan pesona alam yang begitu memukau, Pemandangan hijau berupa view Gunung Salak Bogor dipadukan dengan hawa sejuk khas pegunungan akan menjadi sajian utama di tempat wisata ini, Selain itu wisata populer di Bogor ini tentunya memiliki fasilitas dan wahana seru untuk dinikmati wisatawan.',
      lat: -6.6329829,
      long: 106.6948005,
      distance: 0.0,
      kategori: 'Rekreasi',
      imageGalerys: [
        'assets/images/aldepos-boarding-school.jpeg',
      ]),
  Wisata(
      image: 'assets/images/haur-salaca-sinarwangi.jpg',
      nama: 'Haur Salaca Sinarwangi',
      alamat: 'Tapos I',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [true, true, true, true, false, true, true],
      tempClosed: false,
      jamOp: [
        '07:00 - 17:30',
        '07:00 - 17:30',
        '07:00 - 17:30',
        '07:00 - 17:30',
        'Tutup',
        '07:00 - 17:30',
        '07:00 - 17:30',
      ],
      tiket: 'Gratis',
      camping: true,
      deskripsi:
          'Haur Salaca Sinarwangi adalah Camping farm yang berlokasi di Tapos I, Tenjolaya, Kabupaten Bogor, Jawa Barat.',
      lat: -6.6782538,
      long: 106.6951555,
      distance: 0.0,
      kategori: 'Rekreasi',
      imageGalerys: []),
  Wisata(
      image: 'assets/images/arca-domas.jpg',
      nama: 'Arca Domas Cibalay',
      alamat: 'Tapos I',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [true, true, true, true, true, true, true],
      tempClosed: false,
      jamOp: [
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
        '09:00 - 17:00',
      ],
      tiket: '5.000',
      camping: false,
      deskripsi:
          'Tempat ini merupakan situs berbentuk kompleks (kumpulan situs), Di dalam komplek ini terdapat persebaran situs diantaranya Situs Jami Paciing, Balekambang, Pasir Manggis, Arca Domas, Endong Kasang, Cipangentehan dan situs Batu Bergores. Adapun situs-situs tersebut membentuk batu kubur, dolmen (mirip meja berukuran lebih pendek), menhir (batu panjang yang berdiri) dan batu bergurat-gurat yang diyakini sebagai pahatan tulisan kuno.',
      lat: -6.67139,
      long: 106.70989,
      distance: 0.0,
      kategori: 'Situs',
      imageGalerys: []),
  Wisata(
      image: 'assets/images/curug-hiji.jpg',
      nama: 'Curug Hiji',
      alamat: 'Gunung Malang',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [true, true, true, true, true, true, true],
      tempClosed: false,
      jamOp: [
        '08:00 - 18:00',
        '08:00 - 18:00',
        '08:00 - 18:00',
        '08:00 - 18:00',
        '08:00 - 18:00',
        '08:00 - 18:00',
        '08:00 - 18:00',
      ],
      tiket: '15.000',
      camping: true,
      deskripsi:
          'Curug Hiji menawarkan wisata yang masih sangat alami. Selain air terjun di sekitar areanya punya daya tarik hamparan hutan Pinus. Setidaknya terdapat dua air terjun, di mana salah satunya memiliki ukuran yang lebih kecil.',
      lat: -6.6700146,
      long: 106.7141895,
      distance: 0.0,
      kategori: 'Air Terjun',
      imageGalerys: [
        'assets/images/camping-curug-hiji.jpg',
        'assets/images/camping-ground-wisata-alam-curug-hiji.jpg'
      ]),
  Wisata(
      image: 'assets/images/tirta-ciburial.jpg',
      nama: 'Tirta Ciburial',
      alamat: 'Cinangneng',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [true, true, true, true, true, true, true],
      tempClosed: false,
      jamOp: [
        '08:00 - 16:30',
        '08:00 - 16:30',
        '08:00 - 16:30',
        '08:00 - 16:30',
        '08:00 - 16:30',
        '08:00 - 16:30',
        '08:00 - 16:30',
      ],
      tiket: '20.000',
      camping: false,
      deskripsi:
          'Tirta Ciburial merupakan wisata kolam renang yang berada di desa Cinangneng, kecamatan tenjolaya, dengan berbagai fasilitas, seperti ember tumpah, goa naga, goa assyifa, gazebo dan lain-lain.',
      lat: -6.6067702,
      long: 106.6989244,
      distance: 0.0,
      kategori: 'Rekreasi',
      imageGalerys: ['assets/images/tirta-ciburial2.jpg']),
  Wisata(
      image: 'assets/images/kampung-wisata-makati.jpg',
      nama: 'Kampung Wisata Makati',
      alamat: 'Gunung Malang',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [true, true, true, true, true, true, true],
      tempClosed: false,
      jamOp: [
        '06:00 - 18:00',
        '06:00 - 18:00',
        '06:00 - 18:00',
        '06:00 - 18:00',
        '06:00 - 18:00',
        '06:00 - 18:00',
        '06:00 - 18:00',
      ],
      tiket: '10.000',
      camping: true,
      deskripsi:
          'Kampung Wisata Makati adalah wisata yang berada di desa gunung malang, kecamatan tenjolaya. wisata ini belum banyak di jelajahi oleh wisatawan, terdapat area camping ground yang cocok untuk kegiatan family camp, diksar sispala/mapala atau sekedar untuk datang menikmati keindahan alam.',
      lat: -6.6691746,
      long: 106.7245483,
      distance: 0.0,
      kategori: 'Rekreasi',
      imageGalerys: ['assets/images/kampung-wisata-makati2.jpg']),
  Wisata(
      image: 'assets/images/curug-cipeuteuy.jpg',
      nama: 'Curug Cipeuteuy',
      alamat: 'Tapos I',
      alamatKec: 'Kecamatan Tenjolaya',
      hariOp: [true, true, true, true, true, true, true],
      tempClosed: false,
      jamOp: [
        'Buka 24 jam',
        'Buka 24 jam',
        'Buka 24 jam',
        'Buka 24 jam',
        'Buka 24 jam',
        'Buka 24 jam',
        'Buka 24 jam',
      ],
      tiket: '35.000',
      camping: true,
      deskripsi:
          'Sebagai salah satu lokasi berkemah di Bogor, Curug Cipeuteuy memiliki daya tariknya sendiri. tak hanya disuguhi pemandangan air terjun, namun juga hutan pinus yang cukup luas.',
      lat: -6.6712889,
      long: 106.7029524,
      distance: 0.0,
      kategori: 'Air Terjun',
      imageGalerys: ['assets/images/curug-cipeuteuy2.jpg']),
];
