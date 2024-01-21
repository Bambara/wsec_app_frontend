import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../models/seller/all_stores.dart';
import '../models/user/logging_session.dart';

class RecoverDatabase extends GetxController {
  final _recoverDB = GetStorage();
  final _logger = Logger(filter: null);

  initDatabase() async {
    await GetStorage.init();
  }

  Future<LoggingSession> storeLoggingSession(LoggingSession loggingSession) async {
    _recoverDB.write('logging_session', loggingSession.toJson());

    Map<String, dynamic> sessionData = await _recoverDB.read('logging_session');

    return LoggingSession.fromJson(sessionData);
  }

  Future<LoggingSession> getLoggingSession() async {
    Map<String, dynamic> sessionData = await _recoverDB.read('logging_session');
    if (sessionData.isEmpty) {
      _logger.i('You are Not Login! Please Login Again..');
    }
    return LoggingSession.fromJson(sessionData);
  }

  Future<AllStores> storeAllStores(AllStores allStores) async {
    _recoverDB.write('all_stores', allStores.toJson());

    Map<String, dynamic> sessionData = await _recoverDB.read('all_stores');

    return AllStores.fromJson(sessionData);
  }

  Future<AllStores> getAllStores() async {
    Map<String, dynamic> sessionData = await _recoverDB.read('all_stores');
    if (sessionData.isEmpty) {
      _logger.i('You are Not Login! Please Login Again..');
    }
    return AllStores.fromJson(sessionData);
  }

  Future<void> destroyLoggingSession() async {
    await _recoverDB.write('logging_session', LoggingSession('', '', '', '', '', '')).then((value) => destroyStores());
  }

  Future<void> destroyStores() async {
    await _recoverDB.remove('all_stores');
  }
}
