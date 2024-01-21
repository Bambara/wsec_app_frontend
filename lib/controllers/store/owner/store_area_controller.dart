import 'dart:collection';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:wsec_app_frontend/controllers/store/owner/stock_add_controller.dart';

import '../../../api/rest/api_client.dart';
import '../../../data/recover_database.dart';
import '../../../models/product.dart';
import '../../../models/seller/store_response.dart';

class StoreAreaController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();
  final _rdbC = Get.put(RecoverDatabase());
  final _sac = Get.put(StockAddController());

  final nameCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  final buyCtrl = TextEditingController();
  final sellCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    syncStores();
    syncProducts();
    nameCtrl.addListener(() {
      if (nameCtrl.text.isEmpty) {
        syncProducts();
        update();
      } else {
        searchProduct(nameCtrl.text);
        update();
      }
    });
  }

  int _selectedIndex = 0;

  List<Product> _storeProduct = [];
  List<String> _storeProductName = [];

  String _store = '';
  final _storeMap = HashMap<String, StoreResponse>();
  List<String> _storeNames = [''];

  void syncProducts() {
    _storeProduct.clear();
    _storeProductName.clear();
    _rdbC.getLoggingSession().then((loggingSes) {
      _apiClient.getAllProductsByStore(_storeMap[_sac.store]!.id, loggingSes.token).then((allStores) {
        for (var product in allStores!.products) {
          _storeProduct.add(product);
          _storeProductName.add(product.name);
        }
        update();
      });
    });
  }

  void searchProduct(String query) {
    final suggestions = _storeProduct.where((product) {
      final name = product.name.toLowerCase();
      final input = query.toLowerCase();

      return name.startsWith(input);
    }).toList();
    _storeProduct.clear();
    _storeProduct.addAll(suggestions);
  }

  void syncStores() {
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
  }

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
  }

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  List<Product> get storeProduct => _storeProduct;

  List<String> get storeProductName => _storeProductName;

  List<String> get storeNames => _storeNames;
}
