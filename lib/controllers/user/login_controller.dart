import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../../api/rest/api_client.dart';
import '../../data/recover_database.dart';
import '../../models/user/signin.dart';
import '../../views/buyer/buyer_drawer_screen.dart';
import '../../views/seller/seller_drawer_screen.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  final _logger = Logger(filter: null);

  final _rdbC = Get.put(RecoverDatabase());

  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final _apiClient = ApiClient();

  final box = GetStorage();

  void checkLogin(String user, String pass) {
    final signIn = Signin(user, pass);

    try {
      _rdbC.getLoggingSession().then((value) {
        if (value.token.isEmpty) {
          _apiClient.memberSignIn(signIn).then((value) => _rdbC.storeLoggingSession(value['signInModel']).then((value) {
                if (user == value.email) {
                  Get.offAll(() => SellerDrawerScreen());
                } else if (user == 'cus') {
                  Get.offAll(() => BuyerDrawerScreen());
                }
              }));
        } else {
          if (value.role == 'business') {
            Get.offAll(() => SellerDrawerScreen());
          } else if (value.role == 'user') {
            Get.offAll(() => BuyerDrawerScreen());
          }
        }
      }).onError((error, stackTrace) {
        // _logger.e(error);
        _apiClient.memberSignIn(signIn).then((value) => _rdbC.storeLoggingSession(value['signInModel']).then((value) {
              if (user == value.email) {
                Get.offAll(() => SellerDrawerScreen());
              } else if (user == 'cus') {
                Get.offAll(() => BuyerDrawerScreen());
              }
            }));
      });
    } catch (e) {
      _logger.e(e);
    }
  }

  void getLogin() {
    _rdbC.getLoggingSession().then((value) {
      if (value.token != '') {
        if (value.role == 'business') {
          Get.offAll(() => SellerDrawerScreen());
        } else if (value.role == 'user') {
          Get.offAll(() => BuyerDrawerScreen());
        }
      }
    });
  }

  void getLoginSession() {
    _rdbC.getLoggingSession().then((loggingSession) {
      if (loggingSession.token != '') {
        if (loggingSession.role == 'business') {
          Get.offAll(() => SellerDrawerScreen());
        } else if (loggingSession.role == 'user') {
          Get.offAll(() => BuyerDrawerScreen());
        }
      }
    });
  }

  get passCtrl => _passCtrl;

  get userCtrl => _userCtrl;
}
