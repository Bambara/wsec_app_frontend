import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';

import 'api/print/grn_view.dart';
import 'api/print/invoice_view.dart';
import 'api/print/store_product_view.dart';
import 'controllers/store/owner/invoice_finish_controller.dart';
import 'data/recover_database.dart';
import 'views/buyer/buyer_dashboard_screen.dart';
import 'views/buyer/buyer_drawer_screen.dart';
import 'views/buyer/buyer_store_area_screen.dart';
import 'views/seller/dashboard_screen.dart';
import 'views/seller/invoice_area_screen.dart';
import 'views/seller/member_area_screen.dart';
import 'views/seller/product_area_screen.dart';
import 'views/seller/quotation_area_screen.dart';
import 'views/seller/seller_drawer_screen.dart';
import 'views/seller/store_add_screen.dart';
import 'views/seller/store_area_screen.dart';
import 'views/user/acc_section_screen.dart';
import 'views/user/forgot_password_screen.dart';
import 'views/user/login_screen.dart';
import 'views/user/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme_data/light.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  await Get.put(RecoverDatabase()).initDatabase();

  runApp(MyApp(theme: theme));
  /*runApp(DevicePreview(
    enabled: true,
    builder: (context) => MyApp(theme: theme),
  ));*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.theme});

  final ThemeData theme;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Williams Walmart',
      theme: theme,
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: () => LoginScreen()),
        GetPage(name: AccountSelectionScreen.routeName, page: () => AccountSelectionScreen()),
        GetPage(name: ForgotPasswordScreen.routeName, page: () => ForgotPasswordScreen()),
        GetPage(name: SignupScreen.routeName, page: () => SignupScreen(userType: '')),
        GetPage(name: AddStoreScreen.routeName, page: () => AddStoreScreen()),
        GetPage(name: SellerDrawerScreen.routeName, page: () => SellerDrawerScreen()),
        GetPage(name: DashboardScreen.routeName, page: () => DashboardScreen(openDrawer: () {})),
        GetPage(name: MemberAreaScreen.routeName, page: () => MemberAreaScreen(openDrawer: () {})),
        GetPage(name: ProductAreaScreen.routeName, page: () => ProductAreaScreen(openDrawer: () {})),
        GetPage(name: StoreAreaScreen.routeName, page: () => StoreAreaScreen(openDrawer: () {})),
        GetPage(name: QuotationAreaScreen.routeName, page: () => QuotationAreaScreen(openDrawer: () {})),
        GetPage(name: BuyerDrawerScreen.routeName, page: () => SellerDrawerScreen()),
        GetPage(name: BuyerDashboardScreen.routeName, page: () => BuyerDashboardScreen(openDrawer: () {})),
        GetPage(name: BuyerStoreAreaScreen.routeName, page: () => BuyerStoreAreaScreen(openDrawer: () {})),
        GetPage(name: InvoiceAreaScreen.routeName, page: () => InvoiceAreaScreen(openDrawer: () {})),
        GetPage(name: InvoiceView.routeName, page: () => InvoiceView(invoice: InvoiceFinishController().invoices.first)),
        GetPage(name: GRNView.routeName, page: () => const GRNView(vGrnItems: [], vehicleNum: '', loadedDate: '', refName: '')),
        GetPage(name: StoreProductView.routeName, page: () => StoreProductView()),
      ],
    );
  }
}
