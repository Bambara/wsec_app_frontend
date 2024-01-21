import 'package:get/get.dart';

class StoreAreaController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
  }
}
