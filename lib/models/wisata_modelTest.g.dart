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
      hariOp: (json['hariOp'] as List<dynamic>).map((e) => e as bool).toList(),
      jamOp: (json['jamOp'] as List<dynamic>).map((e) => e as String).toList(),
      imageGaleries: [
        json["imageGaleries"][0] ?? null,
        json["imageGaleries"][1] ?? null,
        json["imageGaleries"][2] ?? null,
        json["imageGaleries"][3] ?? null,
      ],
      id: json['_id'] as String,
      nama: json['nama'] as String,
      image:
          'https://wisata-server-production.up.railway.app/images/${(json['image'] as String).substring(7)}',
      tempClosed: json['tempClosed'] as bool,
      kategori: json['kategori'] as String,
      distance: double.parse('0.${json['distance']}'),
    );

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
      desa: 'Desa ${json['desa'] as String}',
      kec: json['kec'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$AlamatToJson(Alamat instance) => <String, dynamic>{
      'desa': instance.desa,
      'kec': instance.kec,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      tiket: json['tiket'] as String,
      deskripsi: json['deskripsi'] as String,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'tiket': instance.tiket,
      'deskripsi': instance.deskripsi,
    };
