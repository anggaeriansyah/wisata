import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  var temp;
  var desc;
  var currently;
  var humidity;
  var windSpeed;
  var press;
  var tempMin;
  var tempMax;

  var temp5 = [];
  var desc5 = [];
  var windSpeed5 = [];
  var dt = [];
  var cuaca = [];

  List get _hari {
    List<String> hasil = [];
    if (dt.isNotEmpty) {
      for (var i = 0; i < dt.length; i++) {
        String c = DateFormat('EEEE').format(DateTime.parse(dt[i]));
        switch (c) {
          case 'Monday':
            hasil.add('Senin');
            break;
          case 'Tuesday':
            hasil.add('Selasa');
            break;
          case 'Wednesday':
            hasil.add('Rabu');
            break;
          case 'Thursday':
            hasil.add('Kamis');
            break;
          case 'Friday':
            hasil.add('Jum\'at');
            break;
          case 'Saturday':
            hasil.add('Sabtu');
            break;
          case 'Sunday':
            hasil.add('Minggu');
            break;
          default:
            '';
        }
      }
    }
    return hasil;
  }

  List get _cuacaId {
    List<String> hasil = [];
    if (cuaca.isNotEmpty) {
      for (var i = 0; i < cuaca.length; i++) {
        switch (cuaca[i]) {
          case 'Rain':
            hasil.add('Hujan');
            break;
          case 'Clouds':
            hasil.add('Berawan');
            break;
          default:
            '';
        }
      }
    }
    return hasil;
  }

  Widget _cuacaIcons(int value) {
    if (cuaca[value] == 'Rain') {
      return const Icon(FontAwesomeIcons.cloudRain, color: Colors.white);
    } else if (cuaca[value] == 'Clouds') {
      return const Icon(FontAwesomeIcons.cloud, color: Colors.white);
    } else {
      return const CircularProgressIndicator();
    }
  }

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=-6.6400000&lon=106.708000&units=metric&lang=id&appid=dbdeefdb6e461817032cc39199b4cc87"));
    var results = jsonDecode(response.body);
    temp = results['main']['temp'];
    desc = results['weather'][0]['description'];
    currently = results['weather'][0]['main'];
    humidity = results['main']['humidity'];
    press = results['main']['pressure'];
    windSpeed = results['wind']['speed'];
    tempMin = results['main']['temp_min'];
    tempMax = results['main']['temp_max'];

    http.Response response2 = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/forecast?lat=-6.6400000&lon=106.708000&units=metric&lang=id&appid=dbdeefdb6e461817032cc39199b4cc87"));
    var results2 = jsonDecode(response2.body);
    for (var i = 3; i < results2['list'].length; i++) {
      temp5.add(results2['list'][i]['main']['temp']);
      dt.add(results2['list'][i]['dt_txt']);
      windSpeed5.add(results2['list'][i]['wind']['speed']);
      cuaca.add(results2['list'][i]['weather'][0]['main']);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    String nmr = temp.toString().substring(0, 2);
    String nmrMin = tempMin.toString().substring(0, 2);
    String nmrMax = tempMax.toString().substring(0, 2);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Prediksi Cuaca',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: dt.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          leading: cuaca.isEmpty
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white54),
                                  ),
                                )
                              : _cuacaIcons(index),
                          title: Text(
                            cuaca.isEmpty
                                ? 'loading'
                                // : '${DateFormat('EEEE').format(DateTime.parse(dt[index]))} ⋅ ${cuaca[index]}',
                                : '${_hari[index]} ${DateFormat('HH:mm').format(DateTime.parse(dt[index]))} ⋅ ${_cuacaId[index]}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: temp5.isEmpty
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white54),
                                  ),
                                )
                              : Text(
                                  '${temp5[index].toString().substring(0, 2)}\u00B0'
                                  'C',
                                  style: const TextStyle(color: Colors.white),
                                ),
                        ),
                      )
                    ],
                  ));
            }),
      )),
    );
  }
}
