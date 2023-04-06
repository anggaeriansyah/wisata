import 'package:flutter/material.dart';
import 'package:wisata_tenjolaya/widgets/allCategories_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: Colors.black),
                  insets: EdgeInsets.symmetric(horizontal: 16),
                ),
                tabs: const [
                  Tab(text: 'Semua Kategori'),
                  Tab(text: 'Air Terjun'),
                  Tab(text: 'Rekreasi'),
                  Tab(text: 'Situs Prasejarah')
                ]),
            Center(
              child: [
                AllCategoriesWidget(),
                AllCategoriesWidget(),
                AllCategoriesWidget(),
                AllCategoriesWidget(),
              ][_tabController.index],
            )
          ],
        ),
      ),
    );
  }
}
