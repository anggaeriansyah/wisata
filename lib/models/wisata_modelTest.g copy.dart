// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wisata_modelTest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wisata2 _$Wisata2FromJson(Map<String, dynamic> json) => Wisata2(
      cod: json['cod'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Wisata2ToJson(Wisata2 instance) => <String, dynamic>{
      'cod': instance.cod,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
    alamat: Alamat.fromJson(json['alamat'] as Map<String, dynamic>),
    info: Info.fromJson(json['info'] as Map<String, dynamic>),
    hariOp: HariOp.fromJson(json['hariOp'] as Map<String, dynamic>),
    jamOp: JamOp.fromJson(json['jamOp'] as Map<String, dynamic>),
    imageGaleries: [
      json["imageGaleries"][0] ?? 'images\\1682872898666-aldepos-salaca.jpg',
      json["imageGaleries"][1] ?? 'images\\1682872898666-aldepos-salaca.jpg',
      json["imageGaleries"][2] ?? 'images\\1682872898666-aldepos-salaca.jpg',
      json["imageGaleries"][3] ?? 'images\\1682872898666-aldepos-salaca.jpg'
    ],
    // imageGaleries:
    //     ImageGaleries.fromJson(json['imageGaleries'] as Map<String, dynamic>),
    id: json['_id'] as String,
    nama: json['nama'] as String,
    image:
        'https://wisata-server-production.up.railway.app/images/${(json['image'] as String).substring(7)}',
    tempClosed: json['tempClosed'] as bool,
    kategori: json['kategori'] as String,
    distance: json['distance'] as int);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'alamat': instance.alamat,
      'info': instance.info,
      'hariOp': instance.hariOp,
      'jamOp': instance.jamOp,
      'imageGaleries': instance.imageGaleries,
      'id': instance.id,
      'nama': instance.nama,
      'image': instance.image,
      'tempClosed': instance.tempClosed,
      'kategori': instance.kategori,
      'distance': instance.distance,
    };

Alamat _$AlamatFromJson(Map<String, dynamic> json) => Alamat(
      desa: json['desa'] ?? '',
      kec: json['kec'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$AlamatToJson(Alamat instance) => <String, dynamic>{
      'desa': instance.desa,
      'kec': instance.kec,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

HariOp _$HariOpFromJson(Map<String, dynamic> json) => HariOp(
      senin: json['senin'] as bool,
      selasa: json['selasa'] as bool,
      rabu: json['rabu'] as bool,
      kamis: json['kamis'] as bool,
      jumat: json['jumat'] as bool,
      sabtu: json['sabtu'] as bool,
      minggu: json['minggu'] as bool,
    );

Map<String, dynamic> _$HariOpToJson(HariOp instance) => <String, dynamic>{
      'senin': instance.senin,
      'selasa': instance.selasa,
      'rabu': instance.rabu,
      'kamis': instance.kamis,
      'jumat': instance.jumat,
      'sabtu': instance.sabtu,
      'minggu': instance.minggu,
    };

// ImageGaleries _$ImageGaleriesFromJson(Map<String, dynamic> json) =>
//     ImageGaleries(
//       image1: json['image1'] as String,
//       image2: json['image2'] as String,
//       image3: json['image3'] as String,
//       image4: json['image4'] as String,
//     );

// Map<String, dynamic> _$ImageGaleriesToJson(ImageGaleries instance) =>
//     <String, dynamic>{
//       'image1': instance.image1,
//     };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      tiket: json['tiket'] as String,
      deskripsi: json['deskripsi'] as String,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'tiket': instance.tiket,
      'deskripsi': instance.deskripsi,
    };

JamOp _$JamOpFromJson(Map<String, dynamic> json) => JamOp(
      senin: json['senin'] as String,
      selasa: json['selasa'] as String,
      rabu: json['rabu'] as String,
      kamis: json['kamis'] as String,
      jumat: json['jumat'] as String,
      sabtu: json['sabtu'] as String,
      minggu: json['minggu'] as String,
    );

Map<String, dynamic> _$JamOpToJson(JamOp instance) => <String, dynamic>{
      'senin': instance.senin,
      'selasa': instance.selasa,
      'rabu': instance.rabu,
      'kamis': instance.kamis,
      'jumat': instance.jumat,
      'sabtu': instance.sabtu,
      'minggu': instance.minggu,
    };
