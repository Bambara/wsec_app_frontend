import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/control_values.dart';
import '../../widgets/flat_button_widget.dart';
import 'signup_screen.dart';

class AccountSelectionScreen extends StatelessWidget {
  AccountSelectionScreen({Key? key}) : super(key: key);
  static const routeName = '/acc_select_screen';

  final userCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.canvasColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.textTheme.bodyText1!.color,
            floating: true,
            snap: true,
            title: Text('Account Selection', style: TextStyle(fontSize: screenWidth * ControlValues.textFontSize)),
            centerTitle: true,
          )
        ],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Become a Buyer',
                        style: TextStyle(color: themeData.textTheme.bodyText1!.color, fontSize: themeData.textTheme.headline6!.fontSize),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (kDebugMode) {
                              print('Login Text Clicked');
                            }
                          }),
                  ],
                )),
                SizedBox(
                  height: screenHeight * 0.010,
                ),
                FlatButtonWidget(
                  title: 'Create Account',
                  function: () {
                    Get.to(() => SignupScreen(userType: 'user'));
                  },
                  heightFactor: 0.065,
                  widthFactor: 0.9,
                  color: themeData.buttonTheme.colorScheme!.primary,
                ),
                SizedBox(
                  height: screenHeight * 0.040,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Become a Seller',
                        style: TextStyle(color: themeData.textTheme.bodyText1!.color, fontSize: 20),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Login Text Clicked');
                          }),
                  ],
                )),
                SizedBox(
                  height: screenHeight * 0.010,
                ),
                FlatButtonWidget(
                  title: 'Create Account',
                  function: () {
                    Get.to(SignupScreen(userType: 'business'));
                  },
                  heightFactor: 0.065,
                  widthFactor: 0.9,
                  color: themeData.buttonTheme.colorScheme!.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
