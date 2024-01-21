import 'package:get/get.dart';

class ProductAreaController extends GetxController {
  int _selectedIndex = 0;
  String _store = '';

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
}
