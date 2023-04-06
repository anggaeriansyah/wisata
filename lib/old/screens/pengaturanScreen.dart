import 'package:flutter/material.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({Key? key}) : super(key: key);

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Image(
                height: 38,
                width: 38,
                image: AssetImage(
                  'assets/images/wite-white.png',
                ),
              ),
            ),
            expandedHeight: 220.0,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 50,
            backgroundColor: Colors.red,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Ini SliverAppBar",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                background: Image(
                  image: AssetImage(
                    'assets/images/wite.png',
                  ),
                  fit: BoxFit.cover,
                )),
          ),
        ],
      ),
    );

    //     AppBar(
    //   backgroundColor: Theme.of(context).primaryColor,
    //   automaticallyImplyLeading: false,
    //   leading: InkWell(
    //     onTap: () {
    //       Navigator.pop(context);
    //     },
    //     child: Icon(
    //       Icons.arrow_back_ios_rounded,
    //       color: Colors.white,
    //       // size: 30,
    //     ),
    //   ),
    //   centerTitle: true,
    //   title: Text('Pengaturan'),
    // )
  }
}
