import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../api/print/grn_view.dart';
import '../../controllers/store/owner/quotation_pending_controller.dart';
import '../../models/add_product.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/ltw_quotation_pending.dart';
import '../../widgets/text_field_widget.dart';

class QuotationPendingTab extends StatelessWidget {
  QuotationPendingTab({Key? key}) : super(key: key);

  // final QuotationPendingController qpc = Get.put(QuotationPendingController());
  // final QuotationFinishController qfc = Get.put(QuotationFinishController());
  // final QuotationAddController qaddc = Get.put(QuotationAddController());

  final _qpc = Get.put(QuotationPendingController());

  // final _qfc = Get.put(QuotationFinishController());
  // final _qaddc = Get.find<QuotationAddController>();
  // final _qAreaC = Get.find<QuotationAreaController>();

  void selectStore(String data) {
    _qpc.store = data;
  }

  void removeItem(int index) {
    // _qpc.removeQuotation(index);
  }

  void openBottomSheet(BuildContext context, double screenHeight) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: screenHeight * 0.8,
        );
      },
    );
  }

  void _openGRNView(BuildContext context) {
    List<AddProduct> pro = [];

    // Navigator.of(context).pushNamed(
    //   GRNView.routeName,
    //   arguments: GRNView(
    //     vGrnItems: [LoadedProduct(Product('id', 'name', 'product_code', 'bar_code', 'category', 'package_type', 'brand', 'status', 'store_id'), 0, 0, 0)],
    //     vehicleNum: '',
    //     loadedDate: '',
    //     refName: 'refName',
    //   ),
    // );

    Get.to(
      GRNView(
        // vGrnItems: [LoadedProduct(Product('id', 'name', 'product_code', 'bar_code', 'category', 'package_type', 'brand', 'status', 'store_id'), 0, 0, 0)],
        vGrnItems: [],
        vehicleNum: '',
        loadedDate: '',
        refName: 'refName',
      ),
    );
    Logger().i('Ok');
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
        GetBuilder<QuotationPendingController>(
          builder: (qpc) => DropDownButtonWidget(
              items: const ["", "Store 01", "Store 02", "Store 03"],
              label: 'Store',
              isRequired: true,
              selectData: selectStore,
              heightFactor: 0.057,
              widthFactor: 0.9,
              valveChoose: qpc.store),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        TextFieldWidget(
            hintText: 'Customer',
            label: 'Customer',
            isRequired: true,
            txtCtrl: _qpc.nameCtrl,
            secret: false,
            heightFactor: 0.055,
            widthFactor: 0.9,
            inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GetBuilder<QuotationPendingController>(
            builder: (controller) => ListView.builder(
              addAutomaticKeepAlives: false,
              cacheExtent: 100,
              itemCount: _qpc.quotations.length,
              itemBuilder: (context, index) => LTWQuotationPending(
                index: index,
                quotation: _qpc.quotations.toList(),
                proceedItem: (index) {
                  controller.proceedQuotation(index);
                },
                editItem: (code) {},
                removeItem: removeItem,
                printItem: (int index) {
                  _openGRNView(context);
                },
                openSheet: (int index) {
                  openBottomSheet(context, screenHeight);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
