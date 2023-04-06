// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'package:universal_html/html.dart' show AnchorElement;
// import 'package:wisata_tenjolaya/models/categories_model.dart';

// void main() {
//   runApp(CreateExcelWidget());
// }

// /// Represents the XlsIO widget class.
// class CreateExcelWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: CreateExcelStatefulWidget(title: 'Create Excel document'),
//     );
//   }
// }

// /// Represents the XlsIO stateful widget class.
// class CreateExcelStatefulWidget extends StatefulWidget {
//   // / Initalize the instance of the [CreateExcelStatefulWidget] class.
//   const CreateExcelStatefulWidget({Key? key, required this.title})
//       : super(key: key);

//   /// title.
//   final String title;
//   @override
//   // ignore: library_private_types_in_public_api
//   _CreateExcelState createState() => _CreateExcelState();
// }

// class _CreateExcelState extends State<CreateExcelStatefulWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//             onPressed: createExcel, child: const Text('Create Excel')),
//       ),
//     );
//   }

//   Future<void> createExcel() async {
//     final Workbook workbook = Workbook();
//     final Worksheet sheet = workbook.worksheets[0];
//     sheet.getRangeByName('A1').setText('Hello World!');
//     sheet.getRangeByName('A1').columnWidth = 15;
//     sheet.getRangeByName('B1').columnWidth = 18;
//     sheet.getRangeByIndex(1, 1).setText('Nama Wisata');
//     sheet.getRangeByIndex(1, 2).setText('Lokasi Wisata');
//     sheet.getRangeByName('A1').cellStyle.bold = true;
//     sheet.getRangeByName('B1').cellStyle.bold = true;
//     for (var i = 0; i < categories.first.allCategories.length; i++) {
//       sheet
//           .getRangeByIndex((2 + i), 1)
//           .setText(categories.first.allCategories[i].nama);
//     }
//     for (var i = 0; i < categories.first.allCategories.length; i++) {
//       sheet
//           .getRangeByIndex((2 + i), 2)
//           .setText(categories.first.allCategories[i].alamat);
//     }
//     final List<int> bytes = workbook.saveAsStream();
//     workbook.dispose();

//     final String path = (await getApplicationSupportDirectory()).path;
//     final String fileName = '$path/Output.xlsx';
//     final File file = File(fileName);
//     await file.writeAsBytes(bytes, flush: true);
//     OpenFile.open(fileName);
//   }
// }
