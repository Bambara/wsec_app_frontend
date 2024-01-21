import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:wsec_app_frontend/models/product.dart';

import '../../api/print/store_product_view.dart';
import '../../controllers/store/owner/product_area_controller.dart';
import '../../controllers/store/owner/product_home_controller.dart';
import '../../controllers/store/reports/store_product_view_controller.dart';
import '../../widgets/drawer_menu_widget.dart';
import 'product_home_tab.dart';
import 'product_manage_tab.dart';

class ProductAreaScreen extends StatelessWidget {
  ProductAreaScreen({Key? key, required this.openDrawer}) : super(key: key);
  static const routeName = '/product_area_screen';

  final VoidCallback openDrawer;

  final talList = [
    ProductHomeTab(),
    ProductManageTab(),
  ];

  final appBarList = ['Product Home', 'Manage Product'];

  final _pac = Get.put(ProductAreaController());
  final _phc = Get.put(ProductHomeController());
  final _spvC = Get.put(StoreProductViewController());

  void _showProductListScreen(BuildContext context, double screenWidth, double screenHeight, ThemeData themeData) {
    final items = [
      Product('01', 'Name 01', '', '', '', '', '', '', [], []),
      Product('02', 'Name 02', '', '', '', '', '', '', [], []),
      Product('03', 'Name 03', '', '', '', '', '', '', [], []),
    ];
    _spvC.invoice = _phc.storeProduct;
    Get.to(() => StoreProductView());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
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
            title: GetBuilder<ProductAreaController>(builder: (pac) => Text(appBarList.elementAt(pac.selectedIndex))),
            centerTitle: true,
            toolbarHeight: screenHeight * 0.06,
          )
        ],
        body: Center(
          child: GetBuilder<ProductAreaController>(builder: (pac) => talList.elementAt(pac.selectedIndex)),
        ),
      ),
      floatingActionButton: SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        animatedIcon: AnimatedIcons.menu_close,
        spacing: 10,
        children: [
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.arrowsRotate),
            label: 'Refresh',
            onTap: () {
              if (_pac.selectedIndex == 0) {
                _phc.syncProductStore();
              }
            },
          ),
          SpeedDialChild(child: const Icon(FontAwesomeIcons.listCheck), label: 'Print Current Stock', onTap: () {}),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.list),
            label: 'Print Product List',
            onTap: () {
              //Get.to(() => AddMemberTab());
              _showProductListScreen(context, screenWidth, screenHeight, themeData);
            },
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        height: screenHeight * 0.06,
        backgroundColor: themeData.primaryColor,
        color: themeData.textTheme.bodyText1?.color,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: FontAwesomeIcons.boxOpen, title: 'Manage'),
        ],
        onTap: (int i) {
          _pac.selectedIndex = i;
          if (kDebugMode) {
            print('click index=${_pac.selectedIndex}');
          }
        },
        curveSize: screenHeight * 0.1,
        style: TabStyle.reactCircle,
      ),
    );
  }
}
