import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../config/control_values.dart';
import '../../controllers/store/owner/stock_add_controller.dart';
import '../../controllers/store/owner/store_area_controller.dart';
import '../../controllers/store/owner/store_home_controller.dart';
import '../../controllers/store/owner/store_manage_controller.dart';
import '../../models/loaded_product.dart';
import '../../widgets/drawer_menu_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/ltw_store_product.dart';
import '../../widgets/text_field_widget.dart';
import 'member_add_tab.dart';
import 'stock_add_tab.dart';
import 'store_home_tab.dart';
import 'store_manage_tab.dart';

class StoreAreaScreen extends StatelessWidget {
  StoreAreaScreen({Key? key, required this.openDrawer}) : super(key: key);
  static const routeName = '/store_area_screen';

  final VoidCallback openDrawer;

  Logger logger = Logger(filter: null);

  final _sAreaC = Get.put(StoreAreaController());
  final _sAddC = Get.put(StockAddController());
  final _shc = Get.put(StoreHomeController());
  final _smc = Get.put(StoreManageController());

  final talList = [
    StoreHomeTab(),
    StockAddTab(),
    StockAddTab(),
    StoreManageTab(),
  ];

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
            title: const Text('Store Area'),
            centerTitle: true,
            toolbarHeight: screenHeight * 0.06,
          )
        ],
        body: Center(
          child: GetBuilder<StoreAreaController>(builder: (sac) => talList.elementAt(sac.selectedIndex)),
        ),
      ),
      floatingActionButton: GetBuilder<StoreAreaController>(
          builder: (controller) => SpeedDial(
                overlayColor: Colors.black,
                overlayOpacity: 0.4,
                animatedIcon: AnimatedIcons.menu_close,
                spacing: 10,
                children: [
                  SpeedDialChild(
                    child: const Icon(FontAwesomeIcons.arrowsRotate),
                    label: 'Refresh',
                    onTap: () {
                      if (controller.selectedIndex == 3) {
                        _smc.syncStores();
                      }
                    },
                  ),
                  controller.selectedIndex == 0
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.list),
                          label: 'Print Current Stock',
                          onTap: () {
                            _shc.getStock();
                          })
                      : SpeedDialChild(),
                  controller.selectedIndex == 0
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.print),
                          label: 'Print Product List',
                          onTap: () {
                            Get.to(() => AddMemberTab());
                          },
                        )
                      : SpeedDialChild(),
                  controller.selectedIndex == 1
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.fileCircleCheck),
                          label: 'Proceed GRN',
                          onTap: () {
                            _sAddC.updateStock(context, screenWidth, screenHeight);
                          },
                        )
                      : SpeedDialChild(),
                  controller.selectedIndex == 1
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.truckRampBox),
                          label: 'Add Item',
                          onTap: () {
                            loadItemAddBottomSheet(context, screenHeight, screenWidth, themeData);
                          },
                        )
                      : SpeedDialChild(),
                  controller.selectedIndex == 2
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.print),
                          label: 'Print GRN',
                          onTap: () {
                            Get.to(() => AddMemberTab());
                          },
                        )
                      : SpeedDialChild(),
                ],
              )),
      bottomNavigationBar: ConvexAppBar(
        height: screenHeight * 0.06,
        backgroundColor: themeData.primaryColor,
        color: themeData.textTheme.bodyText1?.color,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: FontAwesomeIcons.boxesStacked, title: 'Stocks'),
          TabItem(icon: Icons.edit_note_sharp, title: 'GRN'),
          TabItem(icon: FontAwesomeIcons.gears, title: 'Manage'),
        ],
        onTap: (int i) {
          _sAreaC.selectedIndex = i;
          if (kDebugMode) {
            print('click index=${_sAreaC.selectedIndex}');
          }
        },
        curveSize: screenHeight * 0.1,
        style: TabStyle.reactCircle,
      ),
    );
  }

  void loadItemAddBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    double qty = 0;
    double buyPrice = 0;
    double salePrice = 0;

    void getQtyText(String data) {
      try {
        qty = double.parse(data);
      } catch (e) {
        e.printError();
      }
    }

    void getBuyText(String data) {
      try {
        buyPrice = double.parse(data);
      } catch (e) {
        e.printError();
      }
    }

    void getSellText(String data) {
      try {
        salePrice = double.parse(data);
      } catch (e) {
        e.printError();
      }
    }

    void addSelectedProduct(int index) {
      if (qty != 0) {
        _sAddC.addProduct(LoadedProduct(_sAreaC.storeProduct.elementAt(index), qty, buyPrice, salePrice));
      }
      qty = 0;
      buyPrice = 0;
      salePrice = 0;
    }

    void removeProduct(int index) {
      _sAreaC.storeProduct.removeAt(index);
    }

    showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ControlValues.boarderRadius)),
        context: context,
        builder: (context) {
          // _sAreaC.syncProducts();

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: screenHeight * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [Text('Search Products', style: TextStyle(fontSize: 16))],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButtonWidget(
                              imagePath: '',
                              function: () {
                                Navigator.pop(context);
                              },
                              iconData: Icons.close,
                              isIcon: true,
                              iconSize: 32),
                        ],
                      )
                    ],
                  ),*/
                  Container(
                    color: themeData.primaryColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.1,
                              ),
                              const Text('Add Product', style: TextStyle(fontSize: 16))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  _sAreaC.nameCtrl.text = '';
                                  Navigator.pop(context);
                                },
                                iconData: Icons.close,
                                isIcon: true,
                                iconSize: 32),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.007),
                  /*TextFieldWidget(
                      hintText: 'Search',
                      label: 'Search',
                      isRequired: true,
                      txtCtrl: _nameCtrl,
                      secret: true,
                      heightFactor: 0.055,
                      widthFactor: 0.9,
                      inputType: TextInputType.streetAddress),*/
                  TextFieldWidget(
                      hintText: 'Search',
                      label: 'Search',
                      isRequired: false,
                      txtCtrl: _sAreaC.nameCtrl,
                      secret: false,
                      heightFactor: 0.055,
                      widthFactor: 0.9,
                      inputType: TextInputType.phone),
                  SizedBox(height: screenHeight * 0.007),
                  Expanded(
                    child: GetBuilder<StoreAreaController>(
                      builder: (controller) => ListView.builder(
                        addAutomaticKeepAlives: false,
                        cacheExtent: 10,
                        itemCount: controller.storeProduct.length,
                        itemBuilder: (context, index) => LTWStoreProduct(
                          index: index,
                          productList: controller.storeProduct.toList(),
                          getQtyText: getQtyText,
                          getBuyText: getBuyText,
                          getSellText: getSellText,
                          selectItem: addSelectedProduct,
                          editItem: (code) {},
                          removeItem: (code) {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
