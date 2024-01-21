import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../api/print/invoice_view.dart';
import '../../api/rest/api_client.dart';
import '../../controllers/store/owner/invoice_finish_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/ltw_invoice_finish.dart';
import '../../widgets/text_field_widget.dart';

class InvoiceFinishTab extends StatelessWidget {
  InvoiceFinishTab({Key? key}) : super(key: key);

  final _apiClient = ApiClient();
  final InvoiceFinishController ifc = Get.put(InvoiceFinishController());
  final Logger _logger = Logger(filter: null);

  void _openInvoiceView(BuildContext context, int index) {
    Get.to(InvoiceView(
      invoice: ifc.invoices.elementAt(index),
    ));
    // Logger().i('Ok');
  }

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
        GetBuilder<InvoiceFinishController>(
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
            txtCtrl: ifc.nameCtrl,
            secret: false,
            heightFactor: 0.055,
            widthFactor: 0.9,
            inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GetBuilder<InvoiceFinishController>(
            builder: (controller) => ListView.builder(
              addAutomaticKeepAlives: false,
              cacheExtent: 10,
              itemCount: ifc.invoices.length,
              itemBuilder: (context, index) => LTWInvoiceFinish(
                index: index,
                quotation: ifc.invoices.toList(),
                proceedItem: (index) {},
                editItem: (code) {},
                removeItem: removeItem,
                printItem: (int index) {
                  _openInvoiceView(context, index);
                },
                openSheet: (int index) {},
              ),
            ),
          ),
        ),
      ],
    );
  }

  void selectStore(String data) {
    ifc.store = data;
  }

  void removeItem(int index) {
    ifc.removeQuotation(index);
  }
}
