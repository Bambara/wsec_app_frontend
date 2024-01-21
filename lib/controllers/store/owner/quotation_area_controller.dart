import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../api/rest/api_client.dart';
import '../../../data/recover_database.dart';
import '../../../models/seller/store_response.dart';
import '../../../models/stock_product.dart';
import 'quotation_add_controller.dart';

class QuotationAreaController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();
  final _rdbC = Get.find<RecoverDatabase>();
  final _qAddC = Get.put(QuotationAddController());

  // final _qpc = Get.put(QuotationPendingController());

  final _nameCtrl = TextEditingController();

  int _selectedIndex = 0;
  String _category = '';

  String _store = '';
  final _storeMap = HashMap<String, StoreResponse>();
  final List<String> _storeNames = [''];

  final List<StockProduct> _stockProduct = [];
  final List<String> _storeProductName = [];

  @override
  void onInit() {
    super.onInit();

    _nameCtrl.addListener(() {
      if (_nameCtrl.text.isEmpty) {
        // syncProductStock();
      }
      if (_nameCtrl.text.isNotEmpty) {
        // searchStockProduct(_nameCtrl.text);
      }
    });
    //syncStores();
  }

  void syncStores() {
    _rdbC.getAllStores().then((allStores) {
      for (var store in allStores.stores) {
        _storeNames.add(store.name);
        _storeMap[store.name] = store;
      }
    }).onError((error, stackTrace) {
      _apiClient.getAllStoresByOwner('', '').then((allStores) {
        _rdbC.storeAllStores(allStores!);
        for (var store in allStores.stores) {
          _storeNames.add(store.name);
          _storeMap[store.name] = store;
        }
      });
    });
  }

  void syncProductStock() {
    _apiClient.getAllStocksByStore(_qAddC.store, '').then((allStocks) {
      for (var stock in allStocks!.stock) {
        _stockProduct.add(stock);
        _storeProductName.add(stock.name);
      }
      update();
    });
  }

  void searchStockProduct(String query) {
    final suggestions = _stockProduct.where((stock) {
      final name = stock.name.toLowerCase();
      final input = query.toLowerCase();

      return name.startsWith(input);
    }).toList();
    _stockProduct.clear();
    _stockProduct.addAll(suggestions);
    _logger.i('Search');
    update();
  }

  /*void popUpProceedSheet() {
    try {
      for (var qProduct in _qAddC.quoteProducts) {}

      _qpc.addQuotation(Quotation('', '', '', '', '', '', 0, 'requester_id', 'responses_id', 0, 0, 0, 0, 0, 0, 0, 0, 'Pending', 'store_id', _qAddC.quoteProducts));
      //_qaddc.quoteProducts.clear();
      //_qaddc.update();

      _logger.i(_qpc.quotations.last.toJson());
    } catch (e) {
      _logger.e(e);
    }
  }*/

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
  }

  String get category => _category;

  set category(String value) {
    _category = value;
    update();
  }

  String get store => _store;

  set store(String value) {
    _store = value;
  }

  List<String> get storeNames => _storeNames;

  get storeMap => _storeMap;

  get logger => _logger;

  get qAddC => _qAddC;

  List<String> get storeProductName => _storeProductName;

  List<StockProduct> get stockProduct => _stockProduct;

  get nameCtrl => _nameCtrl;
}
