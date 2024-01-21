import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wsec_app_frontend/models/common/address.dart';
import 'package:wsec_app_frontend/models/common/contact.dart';
import 'package:wsec_app_frontend/models/common/location.dart';
import 'package:wsec_app_frontend/models/seller/store.dart';
import 'package:wsec_app_frontend/models/user/avatar.dart';
import 'package:wsec_app_frontend/models/user/signup_seller.dart';

import '../../api/rest/api_client.dart';
import '../../data/recover_database.dart';
import '../../models/user/signup_buyer.dart';
import '../../views/user/login_screen.dart';

class StoreAddController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();
  final _rdbC = Get.find<RecoverDatabase>();

  late final SignupBuyer _buyer;

  final nameCtrl = TextEditingController();
  final addressLine01Ctrl = TextEditingController();
  final addressLine02Ctrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final zipCodeCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final contactCtrl = TextEditingController();

  final List<String> _contactInfo = [''];
  final contacts = {'Mobile': '', 'Work': '', 'Fax': '', 'Email': '', 'Website': ''};
  String storeType = '';
  String contactType = '';

  File _profileImage = File('');
  bool _isSelected = false;

  Future<void> pickProfileImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      // _logger.i('select');
      _isSelected = true;
      _profileImage = File(pickedFile.path);
    } else {
      _isSelected = false;
      // getImageFileFromAssets('images/01.jpg');
    }
    update();
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    _profileImage = file;
    // update();
    return file;
  }

  void createStore() {
    try {
      if (_isSelected) {
        _logger.i(_profileImage.path);
        _apiClient.uploadUserImage(_profileImage, nameCtrl.text).then((logoUrl) {
          final address = Address(addressLine01Ctrl.text, addressLine02Ctrl.text, cityCtrl.text, stateCtrl.text, countryCtrl.text, zipCodeCtrl.text);
          final contact = Contact(contacts['Mobile']!, contacts['Work']!, contacts['Fax']!, contacts['Email']!, contacts['Website']!);
          final avatar = Avatar(nameCtrl.text, nameCtrl.text, logoUrl);
          final store = Store('', nameCtrl.text, address, contact, '', Location('', ''), avatar, storeType);
          final signUp = SignupSeller(_buyer.id, _buyer.first_name, _buyer.last_name, _buyer.user_name, _buyer.email, _buyer.mobile, address, _buyer.password, avatar,
              _buyer.role, _buyer.status, store);
          // final store = Store('', nameCtrl.text, address, contact, locationCtrl.text, avatar, storeType, 'Active', DateTime.now().toString());
          _logger.i(store.toJson());
          _rdbC.getLoggingSession().then((loggingSes) {
            _apiClient.addStore(store, loggingSes.token).then((statusCode) {
              if (statusCode == '201' || statusCode == '200') {
                //Get.offAll(LoginScreen());
                _logger.i('Store Created');
              }
            });
          });

          // _logger.i(store.toJson());
        });
      } else {
        final address = Address(addressLine01Ctrl.text, addressLine02Ctrl.text, cityCtrl.text, stateCtrl.text, countryCtrl.text, zipCodeCtrl.text);
        final contact = Contact(contacts['Mobile']!, contacts['Work']!, contacts['Fax']!, contacts['Email']!, contacts['Website']!);
        final avatar = Avatar(nameCtrl.text, nameCtrl.text, '');
        final store = Store('', nameCtrl.text, address, contact, '', Location('', ''), avatar, storeType);
        final signUp = SignupSeller(_buyer.id, _buyer.first_name, _buyer.last_name, _buyer.user_name, _buyer.email, _buyer.mobile, address, _buyer.password, avatar,
            _buyer.role, _buyer.status, store);
        _apiClient.sellerSignup(signUp).then((statusCode) {
          if (statusCode == '201' || statusCode == '200') {
            Get.offAll(LoginScreen());
            _logger.i('User Created');
          }
        });
        // _logger.i(store.toJson());
      }
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<String> uploadLogo() async {
    String logoUrl = '';

    if (_isSelected) {
      _logger.i(_profileImage.path);
      await _apiClient.uploadUserImage(_profileImage, nameCtrl.text).then((value) => logoUrl);
    }
    return logoUrl;
  }

  void addItem(String item) {
    var split = item.split(' : ');
    contacts[split[0]] = split[1];
    _logger.i(split[0]);
    _contactInfo.add(item);
    update();
    //Logger().i(contactInfo.length);
  }

  void removeItem(int index) {
    var split = _contactInfo.elementAt(index).split(' : ');
    _logger.i(split[0]);
    contacts[split[0]] = '';
    _contactInfo.removeAt(index);
    update();
    //Logger().i(contactInfo.length);
  }

  List<String> getInfo() {
    return _contactInfo;
  }

  void setStoreType(String type) {
    storeType = type;
    update();
  }

  void setContactType(String type) {
    contactType = type;
    update();
  }

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

  get logger => _logger;

  SignupBuyer get buyer => _buyer;

  set buyer(SignupBuyer value) {
    _buyer = value;
  }
}
