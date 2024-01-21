import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../api/rest/api_client.dart';
import '../../controllers/store/owner/quotation_finish_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/ltw_quotation_pending.dart';
import '../../widgets/text_field_widget.dart';

class QuotationFinishTab extends StatelessWidget {
  QuotationFinishTab({Key? key}) : super(key: key);

  final _apiClient = ApiClient();
  final qfc = Get.put(QuotationFinishController());
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
        GetBuilder<QuotationFinishController>(
          builder: (qfc) => DropDownButtonWidget(
              items: const ["", "Store 01", "Store 02", "Store 03"],
              label: 'Store',
              isRequired: true,
              selectData: selectStore,
              heightFactor: 0.057,
              widthFactor: 0.9,
              valveChoose: qfc.store),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        TextFieldWidget(
            hintText: 'Customer',
            label: 'Customer',
            isRequired: true,
            txtCtrl: qfc.nameCtrl,
            secret: false,
            heightFactor: 0.055,
            widthFactor: 0.9,
            inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GetBuilder<QuotationFinishController>(
            builder: (controller) => ListView.builder(
              addAutomaticKeepAlives: false,
              cacheExtent: 100,
              itemCount: qfc.quotations.length,
              itemBuilder: (context, index) => LTWQuotationPending(
                index: index,
                quotation: qfc.quotations.toList(),
                proceedItem: (index) {},
                editItem: (code) {},
                removeItem: removeItem,
                printItem: (int index) {},
                openSheet: (int index) {},
              ),
            ),
          ),
        ),
      ],
    );
  }

  void selectStore(String data) {
    qfc.store = data;
  }

  void removeItem(int index) {
    qfc.removeQuotation(index);
  }
}
