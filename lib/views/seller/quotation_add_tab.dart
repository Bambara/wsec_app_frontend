import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../controllers/store/owner/quotation_add_controller.dart';
import '../../controllers/store/owner/quotation_area_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/ltw_quoted_product.dart';

class QuotationAddTab extends StatelessWidget {
  QuotationAddTab({Key? key}) : super(key: key);

  final _qac = Get.put(QuotationAddController());
  final _qAreaC = Get.put(QuotationAreaController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.01,
        ),
        GetBuilder<QuotationAddController>(
          builder: (controller) => DropDownButtonWidget(
              items: _qAreaC.storeNames, label: 'Store', isRequired: true, selectData: selectStore, heightFactor: 0.057, widthFactor: 0.9, valveChoose: controller.store),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GetBuilder<QuotationAddController>(
            builder: (controller) => ListView.builder(
              addAutomaticKeepAlives: false,
              cacheExtent: 100,
              itemCount: _qac.quoteProducts.length,
              itemBuilder: (context, index) => LTWQuotedProduct(
                index: index,
                productList: _qac.quoteProducts.toList(),
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

  void selectStore(String data) {
    _qac.store = data;
    _qAreaC.store = data;
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
    _qac.removeProduct(index);
  }
}
