import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:wsec_app_frontend/api/print/store_product_api.dart';

import '../../controllers/store/reports/store_product_view_controller.dart';

class StoreProductView extends StatelessWidget {
  StoreProductView({Key? key}) : super(key: key);
  static const routeName = '/store_product_view';

  final _spvC = Get.put(StoreProductViewController());

  //final Invoice invoice;
  // final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.iconTheme.color,
            floating: true,
            snap: true,
            title: const Text('Invoice Print'),
            centerTitle: true,
          )
        ],
        // body: TabBarView(
        //   children: [talList.elementAt(selectedTab)],
        // ),
        body: buildPdfPreview(),
      ),
    );
  }

  PdfPreview buildPdfPreview() {
    late PdfPreview view;

    try {
      view = PdfPreview(
        // pageFormats: const {'roll 58mm': PdfPageFormat(58 * PdfPageFormat.mm, 80 * PdfPageFormat.mm)},
        pageFormats: const {'A4': PdfPageFormat.a4},
        build: (pageFormat) async {
          return StoreProductAPI.generateInvoice(_spvC.invoice);
        },
      );

      //Logger().i(invoice.toJson());
    } catch (e) {
      Logger().i(e.toString());
    }
    return view;
  }
}
