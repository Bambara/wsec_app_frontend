import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/quotation.dart';
import '../../../models/quotation_product.dart';

class QuotationFinishController extends GetxController {
  String _store = '';
  final TextEditingController nameCtrl = TextEditingController();

  List<QuotationProduct> quoteProducts = [];
  List<Quotation> quotations = [];

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  void addProduct(QuotationProduct product) {
    quoteProducts.add(product);
    update();
  }

  void removeProduct(int index) {
    quoteProducts.removeAt(index);
    update();
  }

  void addQuotation(Quotation quotation) {
    quotations.add(quotation);
    update();
  }

  void removeQuotation(int index) {
    quotations.removeAt(index);
    update();
  }
}
