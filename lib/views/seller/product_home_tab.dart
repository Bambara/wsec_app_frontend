import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/store/owner/product_area_controller.dart';
import '../../controllers/store/owner/product_home_controller.dart';
import '../../models/store_member.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/gtw_product_home.dart';
import '../../widgets/text_field_widget.dart';

class ProductHomeTab extends StatelessWidget {
  ProductHomeTab({Key? key}) : super(key: key);

  final _phc = Get.put(ProductHomeController());
  final _pac = Get.put(ProductAreaController());

  String selectedStore = 'All';
  List<StoreMember> storeMember = [
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
  ];

  final faker = Faker();

  void selectStore(String data) {
    _phc.store = data;
    _phc.syncProductStore();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.02,
        ),
        GetBuilder<ProductHomeController>(
          builder: (phc) => DropDownButtonWidget(
              items: _phc.storeNames, label: 'Store', isRequired: true, selectData: selectStore, heightFactor: 0.057, widthFactor: 0.9, valveChoose: _phc.store),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextFieldWidget(
            hintText: 'Name', label: 'Name', isRequired: true, txtCtrl: _phc.nameCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GetBuilder<ProductHomeController>(
            builder: (controller) => GridView.builder(
              addAutomaticKeepAlives: false,
              cacheExtent: 100,
              itemCount: controller.storeProduct.length,
              itemBuilder: (context, index) {
                return GtwProductHome(
                  imageUrl: _phc.storeProduct.elementAt(index).images.first.url,
                  navigate: () {},
                  storeMember: controller.storeProduct,
                  index: index,
                  function: () {
                    _pac.selectedIndex = 1;
                  },
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5.0, mainAxisSpacing: 10.0, childAspectRatio: 0.88),
            ),
          ),
        ),
      ],
    );
  }
}
