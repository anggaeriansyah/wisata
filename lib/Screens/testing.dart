// import 'package:flutter/material.dart';
// import 'package:wisata_tenjolaya/models/wisata_modelTest.dart';
// import '../services/api_service.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   _TestScreenState createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   late Future<List<Wisata2>> _futureWisata;

//   @override
//   void initState() {
//     super.initState();
//     // _futureWisata = ApiService.getWisata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Users'),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Wisata2>>(
//           future: _futureWisata,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('${snapshot.error}');
//             } else {
//               final wisatas = snapshot.data;
//               return ListView.builder(
//                 itemCount: wisatas?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final wisata = wisatas![index];
//                   return ListTile(
//                     title: Text(wisata.nama),
//                     // subtitle: Text('Age: ${wisata.cod.toString()}'),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
