import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/store/owner/store_home_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/gtw_stock_product.dart';
import '../../widgets/text_field_widget.dart';

class StoreHomeTab extends StatelessWidget {
  StoreHomeTab({Key? key}) : super(key: key);

  final _shc = Get.put(StoreHomeController());

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
        GetBuilder<StoreHomeController>(
          builder: (controller) => DropDownButtonWidget(
              items: controller.storeNames, label: 'Store', isRequired: true, selectData: selectStore, heightFactor: 0.057, widthFactor: 0.9, valveChoose: controller.store),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextFieldWidget(
            hintText: 'Name', label: 'Name', isRequired: true, txtCtrl: _shc.nameCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GetBuilder<StoreHomeController>(
            builder: (controller) => GridView.builder(
              addAutomaticKeepAlives: false,
              cacheExtent: 100,
              itemCount: controller.stockProduct.length,
              itemBuilder: (context, index) {
                return GTWStockProduct(
                  navigate: () {},
                  stockProduct: controller.stockProduct,
                  index: index,
                  removeItem: (index) {},
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 6.0, mainAxisSpacing: 25, childAspectRatio: 2 / 2.2),
            ),
          ),
        ),
      ],
    );
  }

  void selectStore(String data) {
    _shc.store = data;
    _shc.syncProducts();
    // Logger().i(value);
  }
}
