import 'dart:collection';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../api/rest/api_client.dart';
import '../../../data/recover_database.dart';
import '../../../models/product.dart';
import '../../../models/seller/store_response.dart';

class ProductHomeController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();

  final _rdbC = Get.put(RecoverDatabase());

  final nameCtrl = TextEditingController();

  String _store = '';
  final _storeMap = HashMap<String, StoreResponse>();

  // String _storeType = 'Whole Sale';
  final List<String> _storeNames = [''];

  final List<Product> _storeProduct = [];
  final List<String> _storeProductName = [];

  @override
  void onInit() {
    syncStores();
    nameCtrl.addListener(() {
      if (nameCtrl.text == '') {
        syncProductStore();
      } else {
        searchStockProduct(nameCtrl.text);
      }
    });
    super.onInit();
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

  void syncProductStore() {
    try {
      _storeProduct.clear();
      _rdbC.getLoggingSession().then((session) {
        _apiClient.getAllProductsByStore(_storeMap[_store]!.id, session.token).then((allStocks) {
          for (var product in allStocks!.products) {
            _storeProduct.add(product);
            _storeProductName.add(product.name);
          }
          update();
        });
      });
    } catch (e) {
      _logger.e(e);
    }
  }

  void searchStockProduct(String query) {
    try {
      final suggestions = _storeProduct.where((product) {
        final name = product.name.toLowerCase();
        final input = query.toLowerCase();

        return name.startsWith(input);
      }).toList();
      _storeProduct.clear();
      _storeProduct.addAll(suggestions);
      // _logger.i('Search');
      update();
    } catch (e) {
      _logger.e(e);
    }
  }

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  List<String> get storeProductName => _storeProductName;

  List<String> get storeNames => _storeNames;

  List<Product> get storeProduct => _storeProduct;
}
