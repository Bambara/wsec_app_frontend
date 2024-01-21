import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/drawer_item.dart';

class BuyerDrawerItems {
  static final DrawerItem dashBoard = DrawerItem('Dashboard', Icons.dashboard_rounded);
  static final DrawerItem store = DrawerItem('Store', Icons.shopping_bag_outlined);
  static final DrawerItem reports = DrawerItem('Reports', FontAwesomeIcons.chartArea);
  static final DrawerItem quotations = DrawerItem('Quotations', FontAwesomeIcons.fileInvoice);
  static final DrawerItem settings = DrawerItem('Settings', Icons.settings);

  static final List<DrawerItem> all = [dashBoard, store, reports, quotations, settings];
}
