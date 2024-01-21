import 'package:get/get.dart';

class MemberManageController extends GetxController {
  String _store = '';
  String _memberType = '';
  String _memberStatus = '';

  String get memberType => _memberType;

  set memberType(String value) {
    _memberType = value;
    update();
  }

  String get memberStatus => _memberStatus;

  set memberStatus(String value) {
    _memberStatus = value;
    update();
  }

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }
}
