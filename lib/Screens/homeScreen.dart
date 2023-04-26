import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:wisata_tenjolaya/Screens/maps.dart';
import 'package:wisata_tenjolaya/Screens/searchScreen.dart';
import 'package:wisata_tenjolaya/Screens/weatherScreen.dart';
import 'package:wisata_tenjolaya/widgets/airTerjun_widget.dart';
import 'package:wisata_tenjolaya/widgets/allCategories_widget.dart';
import 'package:wisata_tenjolaya/widgets/big_app_text.dart';
import 'package:wisata_tenjolaya/widgets/rekomendasi_widget.dart';
import 'package:wisata_tenjolaya/widgets/rekreasi_widget.dart';
import 'package:wisata_tenjolaya/widgets/situs_widget.dart';
import '../widgets/big_app_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isActive = false;

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
      return false;
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      setState(() {
        _isActive = false;
      });
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    Geolocator.getLastKnownPosition;
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      await Geolocator.checkPermission();
      setState(() {
        _isActive = false;
      });
    } else {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
          .then((Position position) {
        setState(
          () => _currentPosition = position,
        );
        _getAddressFromLatLng(_currentPosition!);
        _isActive = true;
      }).catchError((e) {
        debugPrint(e);
      });
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.subLocality}, ${place.locality}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    _getCurrentPosition();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // int _selectedDestination = 0;
    // TabController _tabController = TabController(length: 4, vsync: this);

    return Scaffold(
      appBar: _isActive
          ? AppBar(
              toolbarHeight: kToolbarHeight * 0.7,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.place,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      _currentAddress ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          overflow: TextOverflow.fade),
                    ),
                  ),
                ],
              ),
            )
          : AppBar(
              elevation: 0,
              toolbarHeight: 0,
              backgroundColor: Colors.white,
            ),
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Get.to(const WeatherScreen(), transition: Transition.downToUp);
            },
            child: const Icon(
              Iconsax.wind,
              // FontAwesomeIcons.cloudBolt,
              size: 30,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              Get.to(const SearchScreen(), transition: Transition.downToUp);
            },
            child: const SizedBox(
              height: 50,
              child: Icon(
                Iconsax.search_normal,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () async {
                  Get.to(const Maps(), transition: Transition.downToUp);
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Iconsax.map,
                    size: 30,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
        body: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: BigAppText(
                    text: 'Wisata Tenjolaya',
                    size: 28,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 5),
                  child: Lottie.asset(
                    'assets/lottie/paper-rocket.json',
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: const BigAppText(text: "Rekomendasi", size: 18)),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 260,
                  child: RekomendasiWidget(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicator:
                          CircleTabIndicator(color: Colors.black, radius: 4),
                      // UnderlineTabIndicator(
                      //   borderSide:
                      //   BorderSide(
                      //       width: 3, color: Theme.of(context).primaryColor),
                      //   insets: const EdgeInsets.symmetric(horizontal: 16),
                      // ),
                      tabs: const [
                        Tab(text: 'Semua Kategori'),
                        Tab(text: 'Air Terjun'),
                        Tab(text: 'Rekreasi'),
                        Tab(text: 'Situs Prasejarah')
                      ]),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Center(
                    child: [
                      AllCategoriesWidget(),
                      AirTerjunWidget(),
                      RekreasiWidget(),
                      SitusWidget(),
                    ][_tabController.index],
                  ),
                )
              ],
            ),
          ),
          // body: ListView(
          //   physics: const BouncingScrollPhysics(),
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //             padding: const EdgeInsets.only(left: 20, top: 5),
          //             child: const BigAppText(text: "Rekomendasi", size: 18)),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         const RekomendasiCarousel(),
          //         // TabBarView(controller: _tabControl, children: [
          //         //   Center(child: Text('req_1')),
          //         //   Center(child: Text('req_2')),
          //         //   Center(child: Text('req_3')),
          //         // ]),

          //         const SizedBox(
          //           height: 10,
          //         ),
          //         Container(
          //           width: double.maxFinite,
          //           child: Align(
          //             alignment: Alignment.centerLeft,
          //             child: TabBar(
          //                 controller: _tabController,
          //                 isScrollable: true,
          //                 labelPadding:
          //                     const EdgeInsets.symmetric(horizontal: 20),
          //                 labelColor: Colors.black,
          //                 unselectedLabelColor: Colors.grey,
          //                 indicator:
          //                     CircleTabIndicator(color: Colors.black, radius: 4),
          //                 tabs: [
          //                   const Tab(text: 'Semua Wisata'),
          //                   const Tab(text: 'Air Terjun'),
          //                   const Tab(text: 'Rekreasi'),
          //                   const Tab(text: 'Situs Prasejarah'),
          //                 ]),
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 5,
          //         ),
          //         // Container(
          //         //   // width: double.maxFinite,
          //         //   height: 100,
          //         //   child: TabBarView(controller: _tabController, children: [
          //         //     SemuaCarousel(),
          //         //     AirCarousel(),
          //         //     RekreasiCarousel(),
          //         //     const Center(child: Text('kul')),
          //         //     const Center(child: Text('sit')),
          //         //   ]),
          //         // ),

          //         // RekreasiCarousel(),
          //         // const SizedBox(
          //         //   height: 10,
          //         // ),

          //         SafeArea(
          //           child: Padding(
          //             padding: const EdgeInsets.only(top: 20),
          //             child: ListView(
          //               children: [
          //                 TabBar(
          //                     controller: _tabController,
          //                     labelColor: Theme.of(context).primaryColor,
          //                     unselectedLabelColor: Colors.grey,
          //                     isScrollable: true,
          //                     indicator: UnderlineTabIndicator(
          //                       borderSide: BorderSide(
          //                           width: 3,
          //                           color: Theme.of(context).primaryColor),
          //                       insets:
          //                           const EdgeInsets.symmetric(horizontal: 16),
          //                     ),
          //                     tabs: [
          //                       Tab(text: 'Semua Kategori'),
          //                       Tab(text: 'Air Terjun'),
          //                       Tab(text: 'Rekreasi'),
          //                       Tab(text: 'Situs Prasejarah')
          //                     ]),
          //                 const SizedBox(height: 20),
          //                 Center(
          //                   child: [
          //                     ItemsWidget(),
          //                     Text('data'),
          //                     ItemsWidget(),
          //                     ItemsWidget(),
          //                   ][_tabController.index],
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

Widget _drawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
