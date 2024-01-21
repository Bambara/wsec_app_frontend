import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../api/rest/api_client.dart';
import '../../controllers/store/owner/invoice_add_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/ltw_invoiced_product.dart';
import '../../widgets/text_field_widget.dart';

class InvoiceAddTab extends StatelessWidget {
  InvoiceAddTab({Key? key}) : super(key: key);

  final _apiClient = ApiClient();
  final InvoiceAddController iac = Get.put(InvoiceAddController());
  final Logger _logger = Logger(filter: null);

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
        GetBuilder<InvoiceAddController>(
          builder: (mhc) => DropDownButtonWidget(
              items: const ["", "Store 01", "Store 02", "Store 03"],
              label: 'Store',
              isRequired: true,
              selectData: selectStore,
              heightFactor: 0.057,
              widthFactor: 0.9,
              valveChoose: iac.store),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        TextFieldWidget(
            hintText: 'Customer',
            label: 'Customer',
            isRequired: true,
            txtCtrl: iac.nameCtrl,
            secret: false,
            heightFactor: 0.055,
            widthFactor: 0.9,
            inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GetBuilder<InvoiceAddController>(
            builder: (controller) => ListView.builder(
              addAutomaticKeepAlives: false,
              cacheExtent: 100,
              itemCount: iac.invoiceProducts.length,
              itemBuilder: (context, index) => LTWInvoicedProduct(
                index: index,
                productList: iac.invoiceProducts.toList(),
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
    iac.store = data;
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
    iac.removeProduct(index);
  }
}
