import 'package:get/get.dart';

class MemberHomeController extends GetxController {
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
}
