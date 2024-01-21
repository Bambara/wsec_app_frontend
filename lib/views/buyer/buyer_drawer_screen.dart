// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../config/drawer_item.dart';
// import '../../data/seller_drawer_items.dart';
// import '../../widgets/drawer_widget.dart';
// import '../../widgets/icon_button_widget.dart';
// import '../user/login_screen.dart';
// import 'buyer_dashboard_screen.dart';
// import 'member_area_screen.dart';
// import 'product_area_screen.dart';
// import 'buyer_store_area_screen.dart';

/*class SellerDrawerScreen extends StatefulWidget {
  static const routeName = '/seller_drawer_screen';

  const SellerDrawerScreen({Key? key}) : super(key: key);

  @override
  State<SellerDrawerScreen> createState() => _SellerDrawerScreenState();
}

class _SellerDrawerScreenState extends State<SellerDrawerScreen> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  bool isDragging = false;
  late bool isDrawerOpen;
  DrawerItem item = SellerDrawerItems.dashBoard;

  @override
  void initState() {
    super.initState();
    closeDrawer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openDrawer() {
    setState(() {
      xOffset = 250;
      yOffset = 150;
      scaleFactor = 0.7;
      isDragging = true;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDragging = false;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Stack(children: [
        buildDrawer(screenWidth),
        buildPage(context),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildDrawer(double screenWidth) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUserArea(screenWidth),
          SizedBox(
            width: xOffset,
            child: DrawerWidget(
              onSelectedItem: (item) {
                setState(() => this.item = item);
                closeDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserArea(double screenWidth) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.06,
                  backgroundImage: const AssetImage('assets/images/person_outline.png'),
                  backgroundColor: Colors.grey.shade600,
                  child: Text('Test'[0].toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Buddhika Prasanna', style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20)),
                    Text('Account Type : Admin', style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 15)),
                    Text('Player IGN', style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 15)),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButtonWidget(
                  imagePath: 'assets/images/lock.png',
                  function: () {
                    Get.offAll(LoginScreen());
                  },
                  isIcon: false,
                  iconData: Icons.adb,
                  iconSize: screenWidth * 0.05,
                ),
              ],
            )
          ],
        ));
  }

  Widget buildPage(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDragging = false;
        },
        onTap: closeDrawer,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
              child: Container(
                color: isDrawerOpen ? Theme.of(context).highlightColor : Theme.of(context).canvasColor,
                child: getDrawerPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerPage() {
    if (SellerDrawerItems.dashBoard == item) {
      return DashboardScreen(openDrawer: openDrawer);
    } else if (SellerDrawerItems.memberArea == item) {
      return MemberAreaScreen(openDrawer: openDrawer);
    } else if (SellerDrawerItems.store == item) {
      return StoreAreaScreen(openDrawer: openDrawer);
    } else if (SellerDrawerItems.products == item) {
      return ProductAreaScreen(openDrawer: openDrawer);
    } else {
      return DashboardScreen(openDrawer: openDrawer);
    }
  }
}*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../controllers/store/customer/drawer_screen_controller.dart';
import '../../data/buyer_drawer_items.dart';
import '../../widgets/icon_button_widget.dart';
import '../user/login_screen.dart';
import 'buyer_dashboard_screen.dart';
import 'buyer_store_area_screen.dart';

class BuyerDrawerScreen extends StatelessWidget {
  BuyerDrawerScreen({Key? key}) : super(key: key);

  static const routeName = '/buyer_drawer_screen';

  DrawerScreenController dsc = Get.put(DrawerScreenController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GetBuilder<DrawerScreenController>(
      builder: (_) => ZoomDrawer(
        controller: dsc.zdc,
        menuScreen: MenuScreen(
          controller: dsc,
        ),
        menuScreenTapClose: true,
        mainScreen: loadScreen(),
        borderRadius: 24.0,
        //showShadow: true,
        moveMenuScreen: true,
        angle: 0.0,
        //openCurve: Curves.linear,
        //closeCurve: Curves.bounceIn,
        menuBackgroundColor: themeData.splashColor.withAlpha(200),
        drawerShadowsBackgroundColor: Colors.black,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }

  void toggleDrawer() {
    dsc.toggleDrawer();
    if (kDebugMode) {
      print("Toggle Drawer");
    }
  }

  Widget loadScreen() {
    if (BuyerDrawerItems.store == dsc.item) {
      //toggleDrawer();
      return BuyerStoreAreaScreen(
        openDrawer: toggleDrawer,
      );
    } else {
      //toggleDrawer();
      return BuyerDashboardScreen(
        openDrawer: toggleDrawer,
      );
    }
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key, required this.controller}) : super(key: key);

  final DrawerScreenController controller;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.canvasColor,
      body: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: themeData.primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://www.citypng.com/public/uploads/preview/profile-user-round-red-icon-symbol-download-png-11639594337tco5j3n0ix.png'),
                    radius: 32,
                  ),
                  IconButtonWidget(
                      imagePath: '',
                      function: () {
                        Get.offAll(LoginScreen());
                      },
                      iconData: Icons.logout,
                      isIcon: true,
                      iconSize: 32)
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: BuyerDrawerItems.all.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.screen = BuyerDrawerItems.all.elementAt(index).title;
                          controller.item = BuyerDrawerItems.all.elementAt(index);
                          controller.toggleDrawer();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(BuyerDrawerItems.all.elementAt(index).icon),
                              SizedBox(width: screenWidth * 0.05),
                              Text(
                                BuyerDrawerItems.all.elementAt(index).title,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(thickness: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
