import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/store/customer/store_area_controller.dart';
import '../../widgets/drawer_menu_widget.dart';
import 'add_store_tab.dart';

class BuyerStoreAreaScreen extends StatelessWidget {
  BuyerStoreAreaScreen({Key? key, required this.openDrawer}) : super(key: key);
  static const routeName = '/buyer_store_area_screen';

  final VoidCallback openDrawer;
  final StoreAreaController sac = Get.put(StoreAreaController());

  final talList = [
    AddStoreTab(),
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
        // body: Column(
        //   children: [
        //     SizedBox(
        //       height: screenHeight * 0.02,
        //     ),
        //     TextFieldWidget(
        //         hintText: 'Name', label: 'Name', isRequired: true, txtCtrl: _nameCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
        //     SizedBox(
        //       height: screenHeight * 0.02,
        //     ),
        //     GetBuilder<MemberAreaController>(
        //       builder: (mac) => DropDownButtonWidget(
        //           items: const ["All", "Customer", "Employees", "Suppliers"],
        //           label: 'Type',
        //           isRequired: true,
        //           selectData: selectMemberType,
        //           heightFactor: 0.057,
        //           widthFactor: 0.9,
        //           valveChoose: selectedMemberType),
        //     ),
        //     SizedBox(
        //       height: screenHeight * 0.02,
        //     ),
        //     Expanded(
        //       child: GridView.builder(
        //         addAutomaticKeepAlives: false,
        //         cacheExtent: 100,
        //         itemCount: storeMember.length,
        //         itemBuilder: (context, index) {
        //           return GtwStoreMember(
        //             navigate: () {},
        //             storeMember: storeMember,
        //             index: index,
        //             function: () {},
        //           );
        //         },
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 6.0, mainAxisSpacing: 6.0),
        //       ),
        //     ),
        //   ],
        // ),
        body: Center(
          child: GetBuilder<StoreAreaController>(builder: (sac) => talList.elementAt(sac.selectedIndex)),
        ),
      ),
      /*floatingActionButton: SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        animatedIcon: AnimatedIcons.menu_close,
        spacing: 10,
        children: [
          SpeedDialChild(child: const Icon(FontAwesomeIcons.arrowsRotate), label: 'Refresh'),
          SpeedDialChild(child: const Icon(FontAwesomeIcons.list), label: 'Member List', onTap: () {}),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.users),
            label: 'Add Member',
            onTap: () {
              Get.to(() => AddMemberTab());
            },
          ),
        ],
      ),*/
      bottomNavigationBar: ConvexAppBar(
        height: screenHeight * 0.05,
        backgroundColor: themeData.primaryColor,
        color: themeData.textTheme.bodyText1?.color,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.supervised_user_circle_outlined, title: 'Manage'),
          TabItem(icon: Icons.list, title: 'List'),
        ],
        onTap: (int i) {
          sac.selectedIndex = i;
          if (kDebugMode) {
            print('click index=${sac.selectedIndex}');
          }
        },
        curveSize: screenHeight * 0.1,
        style: TabStyle.reactCircle,
      ),
    );
  }
}
