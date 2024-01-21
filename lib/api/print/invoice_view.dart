import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../models/seller/invoice.dart';
import 'invoce_api.dart';

class InvoiceView extends StatelessWidget {
  const InvoiceView({Key? key, required this.invoice}) : super(key: key);
  static const routeName = '/invoice_view';

  //final Invoice invoice;
  final Invoice invoice;

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
          return InvoiceAPI.generateInvoice(invoice);
        },
      );

      //Logger().i(invoice.toJson());
    } catch (e) {
      Logger().i(e.toString());
    }
    return view;
  }
}
