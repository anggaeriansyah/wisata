// class Destinasi {
//   String image;
//   String namaDepan;
//   String nama;
//   String alamat;
//   String alamatKec;
//   String hariOp;
//   String hariOpLainnya;
//   String jamOp;
//   String jamOpLainnya;
//   String camping;
//   String tiket;
//   String deskripsi;
//   List<String> imageGalerys;
//   double lat;
//   double long;

//   Destinasi({
//     required this.image,
//     required this.namaDepan,
//     required this.nama,
//     required this.alamat,
//     required this.alamatKec,
//     required this.hariOp,
//     required this.hariOpLainnya,
//     required this.jamOp,
//     required this.jamOpLainnya,
//     required this.camping,
//     required this.tiket,
//     required this.deskripsi,
//     required this.imageGalerys,
//     required this.lat,
//     required this.long,
//   });
// }

// // List<LatLng> latLngs = <LatLng>[
// //   LatLng(-6.6867448, 106.6999085),
// //   LatLng(-6.686702, 106.6998656),
// // ];

// List<Destinasi> destinasis = [
//   Destinasi(
//     image: 'assets/images/curug-ciampea.jpg',
//     namaDepan: '',
//     nama: 'Curug Ciampea',
//     alamat: 'Desa Tapos I',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Setiap Hari',
//     jamOp: '07:00 - 17:30',
//     hariOpLainnya: '',
//     jamOpLainnya: '',
//     camping: 'Tersedia',
//     tiket: '22.000',
//     deskripsi:
//         'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: [
//       'assets/images/curug-ciampea-kemah.jpg',
//       'assets/images/curug-ciampea-green-lagoon.webp',
//     ],
//     lat: -6.686902,
//     long: 106.6998856,
//   ),
//   Destinasi(
//     image: 'assets/images/tenjolaya-park.jpg',
//     namaDepan: '',
//     nama: 'Curug Ciputri',
//     alamat: 'Desa Tapos I',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Setiap Hari',
//     jamOp: '08:00 - 17:00',
//     hariOpLainnya: '',
//     jamOpLainnya: '',
//     camping: 'Tersedia',
//     tiket: '50.000',
//     deskripsi:
//         'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: ['assets/images/curug-ciampea-kemah.jpg'],
//     lat: -6.6838379,
//     long: 106.7059600,
//   ),
//   Destinasi(
//     image: 'assets/images/curug-ciampea.jpg',
//     namaDepan: '',
//     nama: 'Curug Luhur',
//     alamat: 'Desa Tapos I',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Setiap Hari',
//     jamOp: '08:00 - 18:00',
//     hariOpLainnya: '',
//     jamOpLainnya: '',
//     camping: 'Tersedia',
//     tiket: '40.000',
//     deskripsi:
//         'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: [
//       'assets/images/curug-ciampea-kemah.jpg'
//       // AssetImage('assets/images/curug-ciampea-kemah.jpg'),
//     ],
//     lat: -6.660011,
//     long: 106.7058569,
//   ),
//   Destinasi(
//     image: 'assets/images/curug-ciampea.jpg',
//     namaDepan: 'Curug',
//     nama: 'Padalarang',
//     alamat: 'Desa Tapos I',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Setiap Hari',
//     jamOp: 'Buka 24 jam',
//     hariOpLainnya: '',
//     jamOpLainnya: '',
//     camping: 'Tersedia',
//     tiket: '20.000',
//     deskripsi:
//         'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: [
//       'assets/images/curug-ciampea-kemah.jpg'
//       // AssetImage('assets/images/curug-ciampea-kemah.jpg'),
//     ],
//     lat: -6.6838379,
//     long: 106.7059600,
//   ),
//   Destinasi(
//     image: 'assets/images/curug-ciampea.jpg',
//     namaDepan: '',
//     nama: 'Curug Cipeuteuy',
//     alamat: 'Desa Tapos I',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Setiap Hari',
//     jamOp: 'buka 24 jam',
//     hariOpLainnya: '',
//     jamOpLainnya: '',
//     camping: 'Tersedia',
//     tiket: '35.000',
//     deskripsi:
//         'Curug Cipeuteuy berada di kaki Gunung Salak, lokasinya berdekatan dengan Curug Hiji. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: [
//       'assets/images/curug-ciampea-kemah.jpg'
//       // AssetImage('assets/images/curug-ciampea-kemah.jpg'),
//     ],
//     lat: -6.6838379,
//     long: 106.7059600,
//   ),
//   Destinasi(
//     image: 'assets/images/curug-ciampea.jpg',
//     namaDepan: '',
//     nama: 'Curug Kiara',
//     alamat: 'Desa Tapos I',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Setiap Hari',
//     jamOp: 'Buka 24 jam',
//     hariOpLainnya: '',
//     jamOpLainnya: '',
//     camping: 'Tidak Tersedia',
//     tiket: '10.000',
//     deskripsi:
//         'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: [
//       'assets/images/curug-ciampea-kemah.jpg'
//       // AssetImage('assets/images/curug-ciampea-kemah.jpg'),
//     ],
//     lat: -6.6838379,
//     long: 106.7059600,
//   ),
//   Destinasi(
//     image: 'assets/images/curug-ciampea.jpg',
//     namaDepan: 'Global Edu Camp',
//     nama: 'Curug Sawer',
//     alamat: 'Desa Gunung Malang',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Setiap Hari',
//     jamOp: 'Buka 24 jam',
//     hariOpLainnya: '',
//     jamOpLainnya: '',
//     camping: 'Tersedia',
//     tiket: '10.000',
//     deskripsi:
//         'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: [
//       'assets/images/curug-ciampea-kemah.jpg'
//       // AssetImage('assets/images/curug-ciampea-kemah.jpg'),
//     ],
//     lat: -6.6838379,
//     long: 106.7059600,
//   ),
//   Destinasi(
//     image: 'assets/images/curug-ciampea.jpg',
//     namaDepan: '',
//     nama: 'Curug Hiji',
//     alamat: 'Desa Gunung Malang',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Setiap Hari',
//     jamOp: 'Buka 24 jam',
//     hariOpLainnya: '',
//     jamOpLainnya: '',
//     camping: 'Tersedia',
//     tiket: '30.000',
//     deskripsi:
//         'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: [
//       'assets/images/curug-ciampea-kemah.jpg'
//       // AssetImage('assets/images/curug-ciampea-kemah.jpg'),
//     ],
//     lat: -6.6898379,
//     long: 106.7119600,
//   ),
//   Destinasi(
//     image: 'assets/images/curug-ciampea.jpg',
//     namaDepan: 'Haur Salaca',
//     nama: 'Sinarwangi',
//     alamat: 'Desa Tapos I',
//     alamatKec: 'Kecamatan Tenjolaya',
//     hariOp: 'Sabtu-Kamis',
//     jamOp: 'Buka 24 jam',
//     hariOpLainnya: 'Jum\'at',
//     jamOpLainnya: 'Tutup',
//     camping: 'Tidak Tersedia',
//     tiket: '30.000',
//     deskripsi:
//         'Curug Ciampea Bogor adalah salah satu pesona alam yang berada di kaki Gunung Salak. pada kawasan tersebut memiliki kandungan air yang jernih, serta pesona alam air terjun yang banyak, sehingga layak untuk dikunjungi.',
//     imageGalerys: [
//       'assets/images/curug-ciampea-kemah.jpg'
//       // AssetImage('assets/images/curug-ciampea-kemah.jpg'),
//     ],
//     lat: -6.6950379,
//     long: 106.7209600,
//   ),
// ];
