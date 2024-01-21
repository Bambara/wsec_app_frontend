import 'package:get/get.dart';

class MemberAreaController extends GetxController {
  int _selectedIndex = 0;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  int getSelectedIndex() {
    return _selectedIndex;
    //update();
  }
}
