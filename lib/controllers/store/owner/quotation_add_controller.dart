import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:wsec_app_frontend/controllers/store/owner/quotation_pending_controller.dart';

import '../../../models/quotation.dart';
import '../../../models/quotation_product.dart';

class QuotationAddController extends GetxController {
  final _logger = Logger(filter: null);
  // final _apiClient = ApiClient();
  final _qpc = Get.put(QuotationPendingController());

  String _store = '';

  final nameCtrl = TextEditingController();

  final List<QuotationProduct> quoteProducts = [];

  final bdaCtrl = TextEditingController();
  final bdpCtrl = TextEditingController();
  final payedCtrl = TextEditingController();
  final payNumberCtrl = TextEditingController();

  double _totalAmount = 0;
  double _itemQty = 0;
  double _totalLineDisValue = 0;
  double _totalLineDisPercentage = 0;
  double _grossAmount = 0;
  double _billDisValue = 0;
  double _billDisPercentage = 0;
  double _netAmount = 0;
  double _payedAmount = 0;
  double _dueAmount = 0;
  String _payType = 'Cash';

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

  void calQuotationValues() {
    try {
      bdaCtrl.text = '0';
      bdpCtrl.text = '0';
      payedCtrl.text = '0';
      payNumberCtrl.text = '0';

      _totalAmount = 0;
      _itemQty = 0;
      _totalLineDisValue = 0;
      _totalLineDisPercentage = 0;
      _grossAmount = 0;
      _billDisValue = 0;
      _billDisPercentage = 0;
      _netAmount = 0;
      _payedAmount = 0;
      _dueAmount = 0;
      _payType = 'Cash';

      for (var qProduct in quoteProducts) {
        _totalAmount += (qProduct.sell_price * qProduct.qty);
        _itemQty += qProduct.qty;
        _totalLineDisValue += qProduct.line_dis_value;
        _totalLineDisPercentage += qProduct.line_dis_prece;
        _grossAmount = (_totalAmount - _totalLineDisValue);
        _netAmount = _grossAmount;
        _dueAmount = _netAmount;
      }

      // _qpc.addQuotation(Quotation('', '', '', '', '', '', 0, 'requester_id', 'responses_id', 0, 0, 0, 0, 0, 0, 0, 0, 'Pending', 'store_id', _qAddC.quoteProducts));
      // //_qaddc.quoteProducts.clear();
      // //_qaddc.update();
      //
      // _logger.i(_qpc.quotations.last.toJson());
    } catch (e) {
      _logger.e(e);
    }
  }

  void proceedQuotation() {
    try {
      final quotation = Quotation('', '', '', '', '', '', _itemQty, 'requester_id', 'responses_id', _totalAmount, _totalLineDisValue, _totalLineDisPercentage, 0, _grossAmount,
          _billDisValue, _billDisPercentage, _netAmount, 'Pending', 'store_id', quoteProducts);

      _qpc.update();
      _logger.i(quotation);
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  void onClose() {
    _totalAmount = 0;
    _itemQty = 0;
    _totalLineDisValue = 0;
    _totalLineDisPercentage = 0;
    _grossAmount = 0;
    _billDisValue = 0;
    _billDisPercentage = 0;
    _netAmount = 0;
    _payedAmount = 0;
    _dueAmount = 0;
    _payType = 'Cash';

    quoteProducts.clear();

    bdaCtrl.text = '0';
    bdpCtrl.text = '0';
    payedCtrl.text = '0';
    payNumberCtrl.text = '0';
  }

  String get payType => _payType;

  set payType(String value) {
    _payType = value;
  }

  double get dueAmount => _dueAmount;

  set dueAmount(double value) {
    _dueAmount = value;
  }

  double get payedAmount => _payedAmount;

  set payedAmount(double value) {
    _payedAmount = value;
  }

  double get netAmount => _netAmount;

  set netAmount(double value) {
    _netAmount = value;
    update();
  }

  double get billDisPercentage => _billDisPercentage;

  set billDisPercentage(double value) {
    _billDisPercentage = value;
  }

  double get billDisValue => _billDisValue;

  set billDisValue(double value) {
    _billDisValue = value;
  }

  double get grossAmount => _grossAmount;

  set grossAmount(double value) {
    _grossAmount = value;
  }

  double get totalLineDisPercentage => _totalLineDisPercentage;

  set totalLineDisPercentage(double value) {
    _totalLineDisPercentage = value;
  }

  double get totalLineDisValue => _totalLineDisValue;

  set totalLineDisValue(double value) {
    _totalLineDisValue = value;
  }

  double get itemQty => _itemQty;

  set itemQty(double value) {
    _itemQty = value;
  }

  double get totalAmount => _totalAmount;

  set totalAmount(double value) {
    _totalAmount = value;
  }
}
