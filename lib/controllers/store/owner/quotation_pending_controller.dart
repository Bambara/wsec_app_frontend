import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../api/rest/api_client.dart';
import '../../../models/quotation.dart';
import '../../../models/quotation_product.dart';

class QuotationPendingController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();

  // final _qAddC = Get.find<QuotationAddController>();
  // final _qAreaC = Get.put(QuotationAreaController());

  String _store = '';
  final nameCtrl = TextEditingController();

  List<QuotationProduct> _quoteProducts = [];
  List<Quotation> _quotations = [];

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  void addProduct(QuotationProduct product) {
    _quoteProducts.add(product);
    update();
  }

  void removeProduct(int index) {
    _quoteProducts.removeAt(index);
    update();
  }

  void proceedQuotation(int index) {
    try {
      final q = _quotations.elementAt(index);
    } catch (e) {
      // _qAreaC.logger.e(e);
    }
  }

  List<Quotation> get quotations => _quotations;

  List<QuotationProduct> get quoteProducts => _quoteProducts;
}
