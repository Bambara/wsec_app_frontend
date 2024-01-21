import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/drawer_menu_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key, required this.openDrawer}) : super(key: key);
  static const routeName = '/seller_dashboard';

  final VoidCallback openDrawer;

  final talList = [
    Tab_01(),
    Tab_02(),
    Tab_03(),
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.iconTheme.color,
            floating: true,
            leading: DrawerMenuWidget(
              onClicked: openDrawer,
            ),
            snap: true,
            title: const Text('DashBoard'),
            centerTitle: true,
          )
        ],
        // body: TabBarView(
        //   children: [talList.elementAt(selectedTab)],
        // ),
        body: Center(child: talList.elementAt(selectedTab)),
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 50,
        backgroundColor: themeData.primaryColor,
        color: themeData.textTheme.bodyText1?.color,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
        ],
        onTap: (int i) {
          selectedTab = i;
          print('click index=$selectedTab');
        },
        curveSize: 100,
        style: TabStyle.reactCircle,
      ),
    );
  }
}

/*class _DashboardState extends State<Dashboard> {
  final talList = [
    Tab_01(),
    Tab_02(),
    Tab_03(),
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.iconTheme.color,
            floating: true,
            leading: DrawerMenuWidget(
              onClicked: widget.openDrawer,
            ),
            // bottom: const TabBar(tabs: [
            //   Tab(icon: Icon(Icons.flight)),
            //   Tab(icon: Icon(Icons.directions_transit)),
            //   Tab(icon: Icon(Icons.directions_car)),
            // ]),
            snap: true,
            title: const Text('DashBoard'),
            centerTitle: true,
          )
        ],
        // body: TabBarView(
        //   children: [talList.elementAt(selectedTab)],
        // ),
        body: Center(child: talList.elementAt(selectedTab)),
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 50,
        backgroundColor: themeData.primaryColor,
        color: themeData.textTheme.bodyText1?.color,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
        ],
        onTap: (int i) {
          setState(() {
            selectedTab = i;
            print('click index=$selectedTab');
          });
        },
        curveSize: 100,
        style: TabStyle.reactCircle,
      ),
    );
  }
}*/

class Tab_01 extends StatelessWidget {
  const Tab_01({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Tab 01');
  }
}

class Tab_02 extends StatelessWidget {
  const Tab_02({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('02');
  }
}

class Tab_03 extends StatelessWidget {
  const Tab_03({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('03');
  }
}
