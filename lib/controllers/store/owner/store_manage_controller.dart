import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../../../api/rest/api_client.dart';
import '../../../data/recover_database.dart';
import '../../../models/common/address.dart';
import '../../../models/common/contact.dart';
import '../../../models/common/location.dart';
import '../../../models/seller/store.dart';
import '../../../models/seller/store_response.dart';
import '../../../models/user/avatar.dart';

class StoreManageController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();

  final _rdbC = Get.put(RecoverDatabase());

  final nameCtrl = TextEditingController();
  final addressLine01Ctrl = TextEditingController();
  final addressLine02Ctrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final countryCtrl = TextEditingController();
  final zipCodeCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final contactCtrl = TextEditingController();

  String _store = '';
  String _storeId = '';
  final _storeMap = HashMap<String, StoreResponse>();

  final List<String> _contactInfo = [''];
  final contacts = {'Mobile': '', 'Work': '', 'Fax': '', 'Email': '', 'Website': ''};

  String _storeType = 'Whole Sale';
  final _storeNames = [''];

  String _contactType = 'Mobile';

  File _profileImage = File('');
  bool _isSelected = false;
  String _logoUrl = '';

  @override
  void onInit() {
    super.onInit();
    syncStores();
  }

  void syncStores() {
    _storeNames.clear();
    _storeNames.add('');
    _rdbC.getAllStores().then((allStores) {
      for (var store in allStores.stores) {
        _storeNames.add(store.name);
        _storeMap[store.name] = store;
      }
      _logger.i(_storeNames.toList());
    }).onError((error, stackTrace) {
      _rdbC.getLoggingSession().then((loggingSes) {
        _logger.i(loggingSes.email);
        _logger.i(loggingSes.token);
        _apiClient.getAllStoresByOwner(loggingSes.email, loggingSes.token).then((allStores) {
          _rdbC.storeAllStores(allStores!);
          for (var store in allStores.stores) {
            _storeNames.add(store.name);
            _storeMap[store.name] = store;
          }
        });
      });
    });
    update();
  }

  void selectStore() {
    _storeId = '';
    nameCtrl.text = _storeMap[_store]!.name;
    addressLine01Ctrl.text = _storeMap[_store]!.address.line_01;
    addressLine02Ctrl.text = _storeMap[_store]!.address.line_02;
    cityCtrl.text = _storeMap[_store]!.address.city;
    stateCtrl.text = _storeMap[_store]!.address.state;
    countryCtrl.text = _storeMap[_store]!.address.country;
    // zipCodeCtrl.text = _storeMap[_store]!.address.zip_code;
    zipCodeCtrl.text = _storeMap[_store]!.address.country;
    locationCtrl.text = _storeMap[_store]!.location.latitude;
    _contactInfo.clear();
    _contactInfo.add('Mobile : ${_storeMap[_store]!.contact.mobile_number}');
    _contactInfo.add('Work : ${_storeMap[_store]!.contact.work_number}');
    _contactInfo.add('Fax : ${_storeMap[_store]!.contact.fax_number}');
    _contactInfo.add('Website : ${_storeMap[_store]!.contact.website}');
    _contactInfo.add('Email : ${_storeMap[_store]!.contact.email_address}');
    _storeType = _storeMap[_store]!.type;
    _logoUrl = _storeMap[_store]!.avatar.url;
    update();
  }

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
      _logoUrl = '';
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

  void createStore(BuildContext context, double screenWidth, double screenHeight) {
    var dialogContext;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // elevation: 5,
            child: SizedBox(
              // padding: const EdgeInsets.all(10),
              width: screenWidth * 0.1,
              height: screenWidth * 0.3,
              child: Center(
                child: Column(
                  children: [
                    SpinKitFadingCircle(
                      size: screenWidth * 0.25,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: screenWidth * 0.01,
                    ),
                    const Text('Store Creating.....'),
                  ],
                ),
              ),
            ),
          );
        });

    try {
      if (_isSelected) {
        // _logger.i(_profileImage.path);

        _apiClient.uploadStoreImage(_profileImage, nameCtrl.text).then((logoUrl) {
          final address = Address(addressLine01Ctrl.text, addressLine02Ctrl.text, cityCtrl.text, stateCtrl.text, countryCtrl.text, zipCodeCtrl.text);
          final contact = Contact(contacts['Mobile']!, contacts['Work']!, contacts['Fax']!, contacts['Email']!, contacts['Website']!);
          final avatar = Avatar(nameCtrl.text, nameCtrl.text, logoUrl);
          // final store = Store('', nameCtrl.text, address, contact, locationCtrl.text, avatar, storeType, 'Active', DateTime.now().toString());
          final store = Store('', nameCtrl.text, address, contact, '', Location('', ''), avatar, storeType);
          _rdbC.getLoggingSession().then((loggingSes) {
            _logger.i(store.toJson());
            _apiClient.addStore(store, loggingSes.token).then((code) {
              if (code['statusCode'].toString() == '200' || code['statusCode'].toString() == '201') {
                _storeId = code['responseStore'] as String;
                _apiClient.addStoreToUser(_storeId, loggingSes.token).then((value) {
                  _logger.i('Store Id : $_storeId');
                  _logger.i('Created');
                  clearText();
                  _apiClient.getAllStoresByOwner(loggingSes.email, loggingSes.token).then((allStores) {
                    _rdbC.storeAllStores(allStores!);
                    for (var store in allStores.stores) {
                      _storeNames.add(store.name);
                      _storeMap[store.name] = store;
                    }
                  });
                });
              }
            }).whenComplete(() {
              Navigator.pop(dialogContext);
              syncStores();
            });
          });
          //clearText();
          // _logger.i(store.toJson());
        });
      } else {
        final address = Address(addressLine01Ctrl.text, addressLine02Ctrl.text, cityCtrl.text, stateCtrl.text, countryCtrl.text, zipCodeCtrl.text);
        final contact = Contact(contacts['Mobile']!, contacts['Work']!, contacts['Fax']!, contacts['Email']!, contacts['Website']!);
        final avatar = Avatar(nameCtrl.text, nameCtrl.text, '');
        // final store = Store('', nameCtrl.text, address, contact, locationCtrl.text, avatar, storeType, 'Active', DateTime.now().toString());
        final store = Store('', nameCtrl.text, address, contact, '', Location('', ''), avatar, storeType);
        _rdbC.getLoggingSession().then((loggingSes) {
          _logger.i(loggingSes.token);
          _logger.i(store.toJson());
          _apiClient.addStore(store, loggingSes.token).then((code) {
            if (code['statusCode'].toString() == '200' || code['statusCode'].toString() == '201') {
              _storeId = code['responseStore'] as String;
              _apiClient.addStoreToUser(_storeId, loggingSes.token).then((value) {
                _logger.i('Store Id : $_storeId');
                _logger.i('Created');
                clearText();
                _apiClient.getAllStoresByOwner(loggingSes.email, loggingSes.token).then((allStores) {
                  _rdbC.storeAllStores(allStores!);
                  for (var store in allStores.stores) {
                    _storeNames.add(store.name);
                    _storeMap[store.name] = store;
                  }
                });
              });
            }
          }).whenComplete(() {
            Navigator.pop(dialogContext);
            syncStores();
          });
        });
        //clearText();
      }
    } on Exception catch (e) {
      e.printError();
    }
  }

  void clearText() {
    nameCtrl.text = '';
    addressLine01Ctrl.text = '';
    addressLine02Ctrl.text = '';
    cityCtrl.text = '';
    stateCtrl.text = '';
    countryCtrl.text = '';
    zipCodeCtrl.text = '';
    locationCtrl.text = '';
    contactCtrl.text = '';
    _contactInfo.clear();
    _contactInfo.add('');
    _storeType = _storeMap[_store]!.type;
    _logoUrl = '';
    update();
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

  String get contactType => _contactType;

  set contactType(String value) {
    _contactType = value;
    update();
  }

  String get storeType => _storeType;

  set storeType(String value) {
    _storeType = value;
    update();
  }

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  List<String> get storeNames => _storeNames;

  HashMap<String, dynamic> get sotreMap => _storeMap;

  String get logoUrl => _logoUrl;

  set logoUrl(String value) {
    _logoUrl = value;
    update();
  }
}
