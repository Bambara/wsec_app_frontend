import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:wsec_app_frontend/models/product.dart';

class StoreProductViewController extends GetxController {
  final _logger = Logger(filter: null);

  late final List<Product> _product;

  List<Product> get invoice => _product;

  set invoice(List<Product> value) {
    _product = value;
  }
}
