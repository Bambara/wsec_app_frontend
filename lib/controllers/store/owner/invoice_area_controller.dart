import 'package:get/get.dart';

class InvoiceAreaController extends GetxController {
  int _selectedIndex = 0;
  String _category = '';

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
}
