import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wsec_app_frontend/controllers/user/store_add_controller.dart';

import '../../api/rest/api_client.dart';
import '../../models/common/address.dart';
import '../../models/user/avatar.dart';
import '../../models/user/signup_buyer.dart';
import '../../views/user/login_screen.dart';

class SignUpController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();

  final _sac = Get.put(StoreAddController());

  final fNameCtrl = TextEditingController();
  final lNameCtrl = TextEditingController();
  final uNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final cPasswordCtrl = TextEditingController();
  final sellerCtrl = TextEditingController();

  String _userType = '';

  File _profileImage = File('');
  bool _isSelected = false;

  String _imageUrl = '';

  void createBuyerAccount() {
    try {
      if (_isSelected == false) {
        final address = Address('', '', '', '', '', '');
        final avatar = Avatar(uNameCtrl.text, uNameCtrl.text, '');
        final signup =
            SignupBuyer('', fNameCtrl.text, lNameCtrl.text, uNameCtrl.text, emailCtrl.text, mobileCtrl.text, address, passwordCtrl.text, avatar, userType, 'Active');
        _logger.i(signup.toJson());
        _apiClient.buyerSignup(signup).then((statusCode) {
          if (statusCode == '201' || statusCode == '200') {
            Get.off(LoginScreen());
            _logger.i('User Created');
          }
        });
      } else {
        _apiClient.uploadUserImage(_profileImage, uNameCtrl.text).then((imageUrl) {
          _imageUrl = imageUrl;
          final address = Address('', '', '', '', '', '');
          final avatar = Avatar(uNameCtrl.text, uNameCtrl.text, '');
          final signup =
              SignupBuyer('', fNameCtrl.text, lNameCtrl.text, uNameCtrl.text, emailCtrl.text, mobileCtrl.text, address, passwordCtrl.text, avatar, userType, 'Active');
          _logger.i(signup.toJson());
          _apiClient.buyerSignup(signup).then((statusCode) {
            if (statusCode == '201' || statusCode == '200') {
              Get.offAll(LoginScreen());
              _logger.i('User Created');
            }
          });
        });
      }
    } catch (e) {
      e.printError();
    }
  }

  void createAccount() {
    createBuyerAccount();
    /*if (userType == 'user') {
      createBuyerAccount();
    } else if (userType == 'business') {
      final address = Address('', '', '', '', '', '');
      final avatar = Avatar(uNameCtrl.text, uNameCtrl.text, _imageUrl);
      final signup = SignupBuyer('', fNameCtrl.text, lNameCtrl.text, uNameCtrl.text, emailCtrl.text, mobileCtrl.text, address, passwordCtrl.text, avatar, userType, 'Active');
      _sac.buyer = signup;
      Get.to(() => AddStoreScreen());
    }*/
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    _profileImage = file;
    // update();
    return file;
  }

  Future<File> pickProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      // _logger.i('select');
      _isSelected = true;
      return File(pickedFile.path);
    } else {
      _isSelected = false;
      // getImageFileFromAssets('images/01.jpg');
    }
    update();
    return File('');
  }

  String get userType => _userType;

  set userType(String value) {
    _userType = value;
    update();
  }

  get logger => _logger;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
    update();
  }

  File get profileImage => _profileImage;

  set profileImage(File value) {
    _profileImage = value;
    update();
  }
}
