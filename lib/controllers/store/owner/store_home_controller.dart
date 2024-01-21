import 'dart:collection';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../api/rest/api_client.dart';
import '../../../data/recover_database.dart';
import '../../../models/seller/all_stock_products.dart';
import '../../../models/seller/store_response.dart';
import '../../../models/stock_product.dart';

class StoreHomeController extends GetxController {
  final _apiClient = ApiClient();
  final _logger = Logger(filter: null);
  final _rdbC = Get.put(RecoverDatabase());

  final _nameCtrl = TextEditingController();

  String _store = '';
  final _storeMap = HashMap<String, StoreResponse>();
  final _storeNames = [''];
  final List<StockProduct> _stockProduct = [];

  @override
  void onInit() {
    super.onInit();
    syncStores();
    _nameCtrl.addListener(() {
      if (nameCtrl.text.isEmpty) {
        syncProducts();
        update();
      }
    });
  }

  void syncStores() {
    _storeNames.clear();
    _storeNames.add('');
    _rdbC.getAllStores().then((allStores) {
      for (var store in allStores.stores) {
        _storeNames.add(store.name);
        _storeMap[store.name] = store;
      }
    }).onError((error, stackTrace) {
      _rdbC.getLoggingSession().then((loggingSes) {
        _logger.i(loggingSes.email);
        _logger.i(loggingSes.token);
        _apiClient.getAllStoresByOwner(loggingSes.email, loggingSes.token).then((allStores) {
          _rdbC.storeAllStores(allStores!);
          for (var store in allStores.stores) {
            _storeNames.add(store.name);
            _storeMap[store.name] = store;
          }
        });
      });
    });
    update();
  }

  void syncProducts() {
    _rdbC.getLoggingSession().then((loggingSes) {
      _logger.i(loggingSes.email);
      _logger.i(loggingSes.token);
      _apiClient.getAllStocksByStore(_storeMap[_store]!.id, loggingSes.token).then((allStores) {
        _stockProduct.clear();
        for (var product in allStores!.stock) {
          _stockProduct.add(product);
        }
        update();
      });
    });
  }

  void searchProduct(String query) {
    final suggestions = _stockProduct.where((stock) {
      final name = stock.name.toLowerCase();
      final input = query.toLowerCase();

      return name.startsWith(input);
    }).toList();
    _stockProduct.addAll(suggestions);
  }

  void getStock() {
    // final product = Product('', '', '', '', '', '', '', '', [], []);
    final stockProduct = StockProduct('', '', '', '', '', '', '', '', [], 0, 0);
    final allStockProducts = AllStockProducts([stockProduct, stockProduct, stockProduct]);
    _logger.i(allStockProducts.toJson());
  }

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  get nameCtrl => _nameCtrl;

  List<StockProduct> get stockProduct => _stockProduct;

  get storeNames => _storeNames;

  get storeMap => _storeMap;
}
