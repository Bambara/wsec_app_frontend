import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../models/loaded_product.dart';
import 'grn_api.dart';

class GRNView extends StatelessWidget {
  const GRNView({Key? key, required this.vGrnItems, required this.vehicleNum, required this.loadedDate, required this.refName}) : super(key: key);
  static const routeName = '/grn_view';
  final List<LoadedProduct> vGrnItems;
  final String vehicleNum;
  final String loadedDate;
  final String refName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPdfPreview(),
    );
  }

  PdfPreview buildPdfPreview() {
    late PdfPreview view;

    try {
      view = PdfPreview(
        // pageFormats: const {'roll 58mm': PdfPageFormat(58 * PdfPageFormat.mm, 80 * PdfPageFormat.mm)},
        pageFormats: const {'A4': PdfPageFormat.a4},
        build: (pageFormat) async {
          return LoadItemsAPI.generateGRN(vGrnItems, vehicleNum, loadedDate, refName);
        },
      );

      Logger().i(vGrnItems.last.product.name);
    } catch (e) {
      Logger().i(e.toString());
    }
    return view;
  }
}
