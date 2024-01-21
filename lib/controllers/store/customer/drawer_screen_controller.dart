import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';

import '../../../config/drawer_item.dart';

class DrawerScreenController extends GetxController {
  final _zdc = ZoomDrawerController();
  String _screen = '';
  DrawerItem _item = DrawerItem('Dashboard', Icons.dashboard_rounded);

  void toggleDrawer() {
    if (kDebugMode) {
      print("Toggle drawer");
    }
    _zdc.toggle?.call();
    update();
  }

  void openDrawer() {
    if (kDebugMode) {
      print("Toggle drawer");
    }
    _zdc.open?.call();
    update();
  }

  void closeDrawer() {
    if (kDebugMode) {
      print("Toggle drawer");
    }
    _zdc.close?.call();
    update();
  }

  get screen => _screen;

  set screen(value) {
    _screen = value;
    update();
  }

  get zdc => _zdc;

  DrawerItem get item => _item;

  set item(DrawerItem value) {
    _item = value;
    update();
  }
}
