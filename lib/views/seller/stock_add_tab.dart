import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../controllers/store/owner/stock_add_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/ltw_loaded_product.dart';

class StockAddTab extends StatelessWidget {
  StockAddTab({Key? key}) : super(key: key);

  final _sac = Get.put(StockAddController());

  void selectStore(String data) {
    _sac.store = data;
  }

  void getQtyText(String data) {
    Logger().i(data);
  }

  void getBuyText(String data) {
    Logger().i(data);
  }

  void getSellText(String data) {
    Logger().i(data);
  }

  void removeItem(int index) {
    _sac.removeProduct(index);
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // final themeData = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.02,
        ),
        GetBuilder<StockAddController>(
          builder: (controller) => DropDownButtonWidget(
              items: controller.storeNames, label: 'Store', isRequired: true, selectData: selectStore, heightFactor: 0.057, widthFactor: 0.9, valveChoose: controller.store),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GetBuilder<StockAddController>(
            builder: (controller) => ListView.builder(
              addAutomaticKeepAlives: false,
              cacheExtent: 100,
              itemCount: controller.loadedProduct.length,
              itemBuilder: (context, index) => LTWLoadedProduct(
                index: index,
                productList: controller.loadedProduct.toList(),
                getQtyText: getQtyText,
                getBuyText: getBuyText,
                getSellText: getSellText,
                selectItem: (index) {},
                editItem: (code) {},
                removeItem: removeItem,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
