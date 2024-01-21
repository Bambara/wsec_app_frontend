import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:logger/logger.dart';
import 'package:wsec_app_frontend/models/user/signup_seller.dart';

// import 'package:project_black_panther/models/event.dart';

import '../../config/control_values.dart';
import '../../models/add_product.dart';
import '../../models/album.dart';
import '../../models/loaded_products.dart';
import '../../models/seller/all_stock_products.dart';
import '../../models/seller/all_stored_products.dart';
import '../../models/seller/all_stores.dart';
import '../../models/seller/store.dart';
import '../../models/user/logging_session.dart';
import '../../models/user/signin.dart';
import '../../models/user/signup_buyer.dart';
import 'api_interface.dart';

class ApiClient {
  final _baseUrl = ControlValues.baseUrl;
  final _baseUrl2 = ControlValues.baseUrl2;
  final _logger = Logger(filter: null);

  final userFolder = CloudinaryPublic('dlggrhqf9', 'user_images', cache: false);
  final storeFolder = CloudinaryPublic('dlggrhqf9', 'store_images', cache: false);
  final productFolder = CloudinaryPublic('dlggrhqf9', 'product_images', cache: false);

  Future<Album?> createAlbum(Map<String, dynamic> body, String title) async {
    try {
      final response = await http
          .post(
            Uri.parse(_baseUrl + ApiInterface.createAlbums),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            /*body: jsonEncode(<String, String>{
        'title': title,
      }),*/
            body: json,
          )
          .timeout(const Duration(seconds: 5));

      // var json = Album(userId: 0, id: 0, title: '').toJson();

      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        Logger().i('Created !');
        return Album.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create album.');
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    return null;
  }

  Future<Album?> fetchAlbum() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl2 + ApiInterface.fetchAlbums)).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var album = Album.fromJson(jsonDecode(response.body));
        _logger.i(album.toJson());
        return album;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    return null;
  }

  Future<String> uploadUserImage(File image, String name) async {
    try {
      CloudinaryResponse response = await userFolder.uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image, identifier: name, publicId: name),
      );

      return response.secureUrl;
    } on CloudinaryException catch (e) {
      _logger.e(e);
    }
    return '';
  }

  Future<String> uploadStoreImage(File image, String name) async {
    try {
      CloudinaryResponse response = await storeFolder.uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image, identifier: name, publicId: name),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      _logger.e(e);
    }
    return '';
  }

  Future<String> uploadProductImage(File image, String name) async {
    try {
      CloudinaryResponse response = await productFolder.uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image, identifier: name, publicId: name),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      _logger.e(e);
    }
    return '';
  }

  Future<String?> buyerSignup(SignupBuyer signUp) async {
    final client = RetryClient(http.Client());

    try {
      final response = await client.post(
        Uri.parse(_baseUrl + ApiInterface.signUpBuyer),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(signUp.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        _logger.e(response.statusCode);
        return response.statusCode.toString();
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
      return 'Timeout';
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return e.toString();
    } finally {
      client.close();
    }
    return null;
  }

  Future<String?> sellerSignup(SignupSeller signUp) async {
    final client = RetryClient(http.Client());

    try {
      final response = await client.post(
        Uri.parse(_baseUrl + ApiInterface.signUpSeller),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(signUp.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        _logger.e(response.statusCode);
        return response.statusCode.toString();
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
      return 'Timeout';
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return e.toString();
    } finally {
      client.close();
    }
    return null;
  }

  Future<HashMap<String, dynamic>> memberSignIn(Signin signIn) async {
    final client = RetryClient(http.Client());

    HashMap<String, dynamic> responseMap = HashMap<String, dynamic>();

    try {
      // _logger.i(signIn.toJson());

      final response = await client
          .post(
            Uri.parse(_baseUrl + ApiInterface.signIn),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode(signIn.toJson()),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        var loggingSession = LoggingSession.fromJson(jsonDecode(response.body));
        responseMap['signInModel'] = loggingSession;
        responseMap['statusCode'] = response.statusCode;
        _logger.i(loggingSession.toJson());
        return responseMap;
      } else {
        _logger.e(response.statusCode);
        responseMap['statusCode'] = response.statusCode;
      }
    } on TimeoutException catch (e) {
      _logger.e(e);
    } catch (e) {
      _logger.e(e);
    } finally {
      client.close();
    }
    return responseMap;
  }

  Future<HashMap<String, dynamic>> addStore(Store store, String token) async {
    final client = RetryClient(http.Client());

    HashMap<String, dynamic> responseMap = HashMap<String, dynamic>();

    try {
      final response = await client.post(
        Uri.parse(_baseUrl + ApiInterface.addStore),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(store.toJson()),
      );
      // .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201 || response.statusCode == 200) {
        // _logger.i('Created Store Id : ' + jsonDecode(response.body)['store_id']);
        responseMap['responseStore'] = jsonDecode(response.body)['store_id'];
        responseMap['statusCode'] = response.statusCode;
        return responseMap;
      } else {
        _logger.e(response.statusCode);
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
      _logger.e(e);
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      _logger.e(e);
    } finally {
      client.close();
    }
    return responseMap;
  }

  Future<String> addStoreToUser(String storeId, String token) async {
    final client = RetryClient(http.Client());

    try {
      final response = await client
          .post(
            Uri.parse(_baseUrl + ApiInterface.addStoreToUser),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({'store_id': storeId}),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        _logger.e(response.statusCode);
        //return response.statusCode.toString();
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
      _logger.e(e);
      // return 'Timeout';
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      _logger.e(e);
      //return e.toString();
    } finally {
      client.close();
    }
    return '';
  }

  Future<String> addProduct(AddProduct product, String token) async {
    final client = RetryClient(http.Client());

    try {
      final response = await client
          .post(
            Uri.parse(_baseUrl + ApiInterface.addProductToStore),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(product.toJson()),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        _logger.e(response.statusCode);
        //return response.statusCode.toString();
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
      _logger.e(e);
      // return 'Timeout';
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      _logger.e(e);
      //return e.toString();
    } finally {
      client.close();
    }
    return '';
  }

  Future<AllStores?> getAllStoresByOwner(String user, String token) async {
    final client = RetryClient(http.Client());

    try {
      final response = await client.get(
        Uri.parse(_baseUrl + ApiInterface.getAllStores),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode(<String, String>{'owner': user}),
      );

      if (response.statusCode == 200) {
        _logger.i(jsonDecode(response.body));

        var allStores = AllStores.fromJson(jsonDecode(response.body));
        //_logger.i(allStores.toJson());
        return allStores;
      } else {
        _logger.e(response.statusCode);
        // return response.statusCode.toString();
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
      // return 'Timeout';
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      // return e.toString();
    } finally {
      client.close();
    }
    return null;
  }

  Future<AllStoredProducts?> getAllProductsByStore(String productId, String token) async {
    final client = RetryClient(http.Client());

    try {
      final response = await client.get(
        Uri.parse('$_baseUrl${ApiInterface.getAllProducts}/${productId}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        //body: jsonEncode(user),
      );

      if (response.statusCode == 200) {
        _logger.i(jsonDecode(response.body));
        return AllStoredProducts.fromJson(jsonDecode(response.body));
      } else {
        _logger.e(response.statusCode);
        // return response.statusCode.toString();
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
      // return 'Timeout';
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      // return e.toString();
    } finally {
      client.close();
    }
    return null;
  }

  Future<AllStockProducts?> getAllStocksByStore(String store, String token) async {
    final client = RetryClient(http.Client());

    try {
      final response = await client.get(
        Uri.parse('$_baseUrl${ApiInterface.getAllStock}/$store'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // body: jsonEncode(store),
      );

      if (response.statusCode == 200) {
        _logger.i(jsonDecode(response.body));
        return AllStockProducts.fromJson(jsonDecode(response.body));
      } else {
        _logger.e(response.statusCode);
        // return response.statusCode.toString();
      }
    } on TimeoutException catch (e) {
      _logger.e(e);
    } on Error catch (e) {
      _logger.e(e);
    } finally {
      client.close();
    }
    return null;
  }

  Future<Object?> addStock(String storeId, LoadedProducts loadedProducts, String token) async {
    final client = RetryClient(http.Client());

    try {
      final response = await client.post(
        Uri.parse('$_baseUrl${ApiInterface.addStock}/$storeId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(loadedProducts.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.statusCode;
      } else {
        _logger.e(response.statusCode);
        return response.statusCode;
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout');
      }
      return 'Timeout';
    } on Error catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return e.toString();
    } finally {
      client.close();
    }
    return null;
  }
}
