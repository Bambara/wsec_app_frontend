import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';

import '../../../api/rest/api_client.dart';
import '../../../data/recover_database.dart';
import '../../../models/add_product.dart';
import '../../../models/seller/product_prices.dart';
import '../../../models/seller/store_response.dart';
import '../../../models/user/avatar.dart';

class ProductManageController extends GetxController {
  final _logger = Logger(filter: null);
  final _apiClient = ApiClient();

  final _rdbC = Get.put(RecoverDatabase());

  final nameCtrl = TextEditingController();
  final codeCtrl = TextEditingController();
  final barCodeCtrl = TextEditingController();

  String _category = '';
  String _packageType = '';
  String _brandName = '';
  String _status = 'Active';

/*  void createSP() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    await GetStorage.init();
    //box.write('product', Product('id', 'name', 'product_code', 'bar_code', 'category', 'package_type', 'brand', 'status', 'store_id').toJson());
    final read = box.read('product');
    final product = Product.fromJson(read);
    Logger().i(product.toJson());
    // prefs.setString('product', Product('id', 'name', 'product_code', 'bar_code', 'category', 'package_type', 'brand', 'status', 'store_id').toJson());
  }*/

  File _profileImage = File('');
  bool _isSelected = false;
  String _logoUrl = '';

  String _store = '';
  final _storeMap = HashMap<String, StoreResponse>();
  String _storeType = 'Whole Sale';
  final List<String> _storeNames = [''];

  @override
  void onInit() {
    syncStores();
    super.onInit();
  }

  void syncStores() {
    _rdbC.getAllStores().then((allStores) {
      for (var store in allStores.stores) {
        _storeNames.add(store.name);
        _storeMap[store.name] = store;
      }
    }).onError((error, stackTrace) {
      _apiClient.getAllStoresByOwner('', '').then((allStores) {
        _rdbC.storeAllStores(allStores!);
        for (var store in allStores.stores) {
          _storeNames.add(store.name);
          _storeMap[store.name] = store;
        }
      });
    });
  }

  /*void selectStore() {
    nameCtrl.text = _storeMap[_store]!.name;
    addressLine01Ctrl.text = _storeMap[_store]!.address.line_01;
    addressLine02Ctrl.text = _storeMap[_store]!.address.line_02;
    cityCtrl.text = _storeMap[_store]!.address.city;
    stateCtrl.text = _storeMap[_store]!.address.state;
    countryCtrl.text = _storeMap[_store]!.address.country;
    zipCodeCtrl.text = _storeMap[_store]!.address.zip_code;
    locationCtrl.text = _storeMap[_store]!.location;
    _contactInfo.add('Mobile : ${_storeMap[_store]!.contact.mobile_number}');
    _contactInfo.add('Work : ${_storeMap[_store]!.contact.work_number}');
    _contactInfo.add('Fax : ${_storeMap[_store]!.contact.fax_number}');
    _contactInfo.add('Website : ${_storeMap[_store]!.contact.website}');
    _contactInfo.add('Email : ${_storeMap[_store]!.contact.email_address}');
    _storeType = _storeMap[_store]!.type;
    _logoUrl = _storeMap[_store]!.avatar.url;
    update();
  }*/

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

  void popUpBarCodeScanner(BuildContext context, double screenWidth, double screenHeight) async {
    var dialogContext;
    await showDialog(
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
              height: screenWidth * 0.55,
              child: MobileScanner(
                  fit: BoxFit.cover,
                  allowDuplicates: false,
                  controller: MobileScannerController(facing: CameraFacing.front, torchEnabled: true),
                  onDetect: (barcode, args) {
                    if (barcode.rawValue == null) {
                      _logger.w('Failed to scan Barcode');
                    } else {
                      final String code = barcode.rawValue!;
                      barCodeCtrl.text = code;
                      _logger.i('Barcode found! ${barCodeCtrl.text}');
                      Navigator.of(context).pop();
                    }
                  }),
            ),
          );
        });
  }

  void createProduct(BuildContext context, double screenWidth, double screenHeight) {
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
                    const Text('Product Creating.....'),
                  ],
                ),
              ),
            ),
          );
        });

    try {
      if (_isSelected) {
        // _logger.i(_profileImage.path);
        _apiClient.uploadProductImage(_profileImage, codeCtrl.text).then((logoUrl) {
          final avatar = Avatar('', codeCtrl.text, logoUrl);
          // final product = Product('', nameCtrl.text, codeCtrl.text, barCodeCtrl.text, _category, _packageType, _brandName, _status, _storeMap[_store]!.name);

          final product = AddProduct(
              '', nameCtrl.text, codeCtrl.text, barCodeCtrl.text, _category, _packageType, _brandName, _status, [avatar], [ProductPrice('', 0, 0, 0)], _storeMap[_store]!.id);
          _logger.i(product.toJson());
          _rdbC.getLoggingSession().then((session) {
            _apiClient.addProduct(product, session.token).then((value) {
              if (value == '200' || value == '201') {
                Navigator.of(context).pop();
                GFToast.showToast('Product Added !', toastPosition: GFToastPosition.CENTER, context, backgroundColor: Theme.of(context).primaryColor);
              }
              clearValues();
            });
            // clearText();
          });
        });
      } else {
        final avatar = Avatar('', codeCtrl.text, '');
        // final product = Product('', nameCtrl.text, codeCtrl.text, barCodeCtrl.text, _category, _packageType, _brandName, _status, _storeMap[_store]!.name);
        final product = AddProduct(
            '', nameCtrl.text, codeCtrl.text, barCodeCtrl.text, _category, _packageType, _brandName, _status, [avatar], [ProductPrice('', 0, 0, 0)], _storeMap[_store]!.id);
        _logger.i(product.toJson());
        _rdbC.getLoggingSession().then((session) {
          _apiClient.addProduct(product, session.token).then((value) {
            if (value == '200' || value == '201') {
              Navigator.of(context).pop();
              GFToast.showToast('Product Added !', toastPosition: GFToastPosition.CENTER, context, backgroundColor: Theme.of(context).primaryColor);
            }
            // clearText();
          });
          clearValues();
        });
      }
    } on Exception catch (e) {
      e.printError();
    }
  }

  void clearValues() {
    nameCtrl.text = '';
    codeCtrl.text = '';
    barCodeCtrl.text = '';
  }

  String get category => _category;

  set category(String value) {
    _category = value;
    update();
  }

  String get status => _status;

  set status(String value) {
    _status = value;
    update();
  }

  String get brandName => _brandName;

  set brandName(String value) {
    _brandName = value;
    update();
  }

  String get packageType => _packageType;

  set packageType(String value) {
    _packageType = value;
    update();
  }

  get logger => _logger;

  String get storeType => _storeType;

  set storeType(String value) {
    _storeType = value;
  }

  File get profileImage => _profileImage;

  set profileImage(File value) {
    _profileImage = value;
    update();
  }

  String get store => _store;

  set store(String value) {
    _store = value;
    update();
  }

  String get logoUrl => _logoUrl;

  set logoUrl(String value) {
    _logoUrl = value;
    update();
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
    update();
  }

  List<String> get storeNames => _storeNames;
}
