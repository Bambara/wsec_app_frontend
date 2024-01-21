import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/recover_database.dart';
import '../../../models/invoice_product.dart';

class InvoiceAddController extends GetxController {
  final _logger = Logger(filter: null);

  final _rdbC = Get.put(RecoverDatabase());

  String _store = '';
  final TextEditingController nameCtrl = TextEditingController();

  List<InvoiceProduct> invoiceProducts = [];

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
  String _payType = '';
  String _BorD = '';

  @override
  void onInit() {
    super.onInit();
    payedCtrl.addListener(() {});
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

    invoiceProducts = [];
    _payType = 'Cash';
    _store = '';

    bdaCtrl.text = '';
    bdpCtrl.text = '';
    payedCtrl.text = '';
    payNumberCtrl.text = '';
    nameCtrl.text = '';
    update();
  }

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  void addProduct(InvoiceProduct product) {
    invoiceProducts.add(product);

    _totalAmount += (product.qty * product.sell_price);
    _itemQty += product.qty;
    _totalLineDisValue += product.ld_amount;
    _totalLineDisPercentage = (_totalLineDisValue / _totalAmount) * 100;
    _grossAmount = (_totalAmount - _totalLineDisValue);
    _netAmount = _grossAmount;
    _dueAmount = _netAmount;

    update();
  }

  void removeProduct(int index) {
    _totalAmount -= (invoiceProducts.elementAt(index).qty * invoiceProducts.elementAt(index).sell_price);
    _itemQty -= invoiceProducts.elementAt(index).qty;
    _totalLineDisValue -= invoiceProducts.elementAt(index).ld_amount;
    _totalLineDisPercentage = (_totalLineDisValue / _totalAmount) * 100;
    _grossAmount = (_totalAmount - _totalLineDisValue);
    _netAmount = _grossAmount;
    _dueAmount = _netAmount;

    invoiceProducts.removeAt(index);

    update();
  }

  void changeBD() {
    try {} catch (e) {
      _logger.e(e);
    }
  }

  void resetValues() {
    try {
      totalAmount = 0;
      itemQty = 0;
      lineDisValue = 0;
      lineDisPercentage = 0;
      grossAmount = 0;
      billDisValue = 0;
      billDisPercentage = 0;
      netAmount = 0;
      payedAmount = 0;
      dueAmount = 0;
    } catch (e) {
      _logger.e(e);
    }
  }

  String get payType => _payType;

  set payType(String value) {
    _payType = value;
    update();
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

  double get lineDisPercentage => _totalLineDisPercentage;

  set lineDisPercentage(double value) {
    _totalLineDisPercentage = value;
  }

  double get lineDisValue => _totalLineDisValue;

  set lineDisValue(double value) {
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

  String get BorD => _BorD;

  set BorD(String value) {
    _BorD = value;
  }
}
