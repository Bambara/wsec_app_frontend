import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/invoice_product.dart';
import '../../../models/seller/invoice.dart';

class InvoiceFinishController extends GetxController {
  String _store = '';
  final TextEditingController nameCtrl = TextEditingController();

  List<InvoiceProduct> quoteProducts = [];
  List<Invoice> invoices = [];

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  void addProduct(InvoiceProduct product) {
    quoteProducts.add(product);
    update();
  }

  void removeProduct(int index) {
    quoteProducts.removeAt(index);
    update();
  }

  void addInvoice(Invoice quotation) {
    invoices.add(quotation);
    update();
  }

  void removeQuotation(int index) {
    invoices.removeAt(index);
    update();
  }
}
