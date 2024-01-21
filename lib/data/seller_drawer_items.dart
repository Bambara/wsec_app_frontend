import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/drawer_item.dart';

class SellerDrawerItems {
  static final DrawerItem dashBoard = DrawerItem('Dashboard', Icons.dashboard_rounded);
  static final DrawerItem memberArea = DrawerItem('Member Area', FontAwesomeIcons.users);
  static final DrawerItem store = DrawerItem('Store', FontAwesomeIcons.store);
  static final DrawerItem products = DrawerItem('Products', FontAwesomeIcons.boxesStacked);
  static final DrawerItem reports = DrawerItem('Reports', FontAwesomeIcons.chartColumn);
  static final DrawerItem quotations = DrawerItem('Quotations', FontAwesomeIcons.fileInvoice);
  static final DrawerItem settings = DrawerItem('Settings', FontAwesomeIcons.gears);
  static final DrawerItem invoice = DrawerItem('Invoice', FontAwesomeIcons.fileInvoiceDollar);

  static final List<DrawerItem> all = [dashBoard, invoice, quotations, store, products, memberArea, reports, settings];
}
