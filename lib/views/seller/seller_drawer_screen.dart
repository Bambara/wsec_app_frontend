import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../controllers/store/owner/drawer_screen_controller.dart';
import '../../data/recover_database.dart';
import '../../data/seller_drawer_items.dart';
import '../../widgets/icon_button_widget.dart';
import '../user/login_screen.dart';
import 'dashboard_screen.dart';
import 'invoice_area_screen.dart';
import 'member_area_screen.dart';
import 'product_area_screen.dart';
import 'quotation_area_screen.dart';
import 'store_area_screen.dart';

class SellerDrawerScreen extends StatelessWidget {
  SellerDrawerScreen({Key? key}) : super(key: key);

  static const routeName = '/seller_drawer_screen';

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
    if (SellerDrawerItems.dashBoard == dsc.item) {
      //toggleDrawer();
      return DashboardScreen(
        openDrawer: toggleDrawer,
      );
    } else if (SellerDrawerItems.invoice == dsc.item) {
      //toggleDrawer();
      return InvoiceAreaScreen(
        openDrawer: toggleDrawer,
      );
    } else if (SellerDrawerItems.quotations == dsc.item) {
      //toggleDrawer();
      return QuotationAreaScreen(
        openDrawer: toggleDrawer,
      );
    } else if (SellerDrawerItems.store == dsc.item) {
      //toggleDrawer();
      return StoreAreaScreen(
        openDrawer: toggleDrawer,
      );
    } else if (SellerDrawerItems.products == dsc.item) {
      //toggleDrawer();
      return ProductAreaScreen(
        openDrawer: toggleDrawer,
      );
    } else if (SellerDrawerItems.memberArea == dsc.item) {
      //toggleDrawer();
      return MemberAreaScreen(
        openDrawer: toggleDrawer,
      );
    } else {
      //toggleDrawer();
      return DashboardScreen(
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
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://www.citypng.com/public/uploads/preview/profile-user-round-red-icon-symbol-download-png-11639594337tco5j3n0ix.png'),
                    radius: 32,
                  ),
                  IconButtonWidget(
                      imagePath: '',
                      function: () {
                        Get.put(RecoverDatabase()).destroyLoggingSession().then((value) => Get.offAll(LoginScreen()));
                      },
                      iconData: Icons.logout,
                      isIcon: true,
                      iconSize: 32)
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: SellerDrawerItems.all.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.screen = SellerDrawerItems.all.elementAt(index).title;
                          controller.item = SellerDrawerItems.all.elementAt(index);
                          controller.toggleDrawer();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(SellerDrawerItems.all.elementAt(index).icon),
                              SizedBox(width: screenWidth * 0.05),
                              Text(
                                SellerDrawerItems.all.elementAt(index).title,
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
