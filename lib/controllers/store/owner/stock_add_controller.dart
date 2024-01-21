import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:wsec_app_frontend/models/common/address.dart';
import 'package:wsec_app_frontend/models/common/contact.dart';

import '../../../api/rest/api_client.dart';
import '../../../data/recover_database.dart';
import '../../../models/grn_product.dart';
import '../../../models/loaded_product.dart';
import '../../../models/loaded_products.dart';
import '../../../models/seller/store_response.dart';

class StockAddController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();
  final _rdbC = Get.put(RecoverDatabase());

  String _memberStatus = '';

  List<LoadedProduct> loadedProduct = [];

  String _store = '';
  final _storeMap = HashMap<String, StoreResponse>();
  final List<String> _storeNames = [''];

  @override
  void onInit() {
    syncStores();
    super.onInit();
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

  void updateStock(BuildContext context, double screenWidth, double screenHeight) {
    var dialogContext;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // elevation: 5,
            child: SizedBox(
              // padding: const EdgeInsets.all(10),
              width: screenWidth * 0.1,
              height: screenWidth * 0.3,
              child: Center(
                child: Column(
                  children: [
                    SpinKitFadingCircle(
                      size: screenWidth * 0.25,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: screenWidth * 0.01,
                    ),
                    const Text('Stock Updating.....'),
                  ],
                ),
              ),
            ),
          );
        });

    try {
      final List<GRNProduct> grnProduct = [];

      for (var item in loadedProduct) {
        grnProduct.add(GRNProduct(item.product.id, item.quantity, item.buy_price, item.sale_price));
      }

      final address = Address('', '', '', '', '', '');
      final contact = Contact('', '', '', '', '');

      final loadedProducts = LoadedProducts('Default', 'Default', 'Punewa, Medawachchiya', '50506', 'Medawachchiya', 'Sri Lanka', grnProduct);
      _rdbC.getLoggingSession().then((loggingSes) {
        _logger.i(loggingSes.token);
        _logger.i(_storeMap[_store]!.id);
        _logger.i(loadedProducts.toJson());
        _apiClient.addStock(_storeMap[_store]!.id, loadedProducts, loggingSes.token).then((statusCode) {
          if (statusCode == 200 || statusCode == 201) {
            loadedProduct.clear();
          }
        }).whenComplete(() {
          Navigator.pop(dialogContext);
        });
      });
    } on Exception catch (e) {
      e.printError();
    }
  }

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  String get memberStatus => _memberStatus;

  set memberStatus(String value) {
    _memberStatus = value;
    update();
  }

  void addProduct(LoadedProduct product) {
    loadedProduct.add(product);
    update();
  }

  void removeProduct(int index) {
    loadedProduct.removeAt(index);
    update();
  }

  get logger => _logger;

  List<String> get storeNames => _storeNames;

  get storeMap => _storeMap;
}
