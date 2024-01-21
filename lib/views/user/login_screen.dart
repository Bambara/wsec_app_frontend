import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/control_values.dart';
import '../../controllers/user/login_controller.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/text_field_widget.dart';
import 'acc_section_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/signing_screen';

  final _lc = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    _lc.getLogin();

    return Scaffold(
      backgroundColor: themeData.canvasColor,
      /*body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            floating: true,
            snap: true,
            title: Text('Login'),
            centerTitle: true,
          )
        ],
      ),*/
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.08,
                backgroundImage: const AssetImage('assets/images/company_logo.jpg'),
                backgroundColor: Colors.grey.shade600,
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              TextFieldWidget(
                  hintText: 'Email or Phone Number',
                  label: 'Email or Phone Number',
                  isRequired: true,
                  txtCtrl: _lc.userCtrl,
                  secret: false,
                  heightFactor: 0.055,
                  widthFactor: 0.9,
                  inputType: TextInputType.emailAddress),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              TextFieldWidget(
                  hintText: 'Password',
                  label: 'Password',
                  isRequired: true,
                  txtCtrl: _lc.passCtrl,
                  secret: true,
                  heightFactor: 0.055,
                  widthFactor: 0.9,
                  inputType: TextInputType.text),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              FlatButtonWidget(
                title: 'Sign in',
                function: () {
                  _lc.checkLogin(_lc.userCtrl.text, _lc.passCtrl.text);
                },
                heightFactor: 0.065,
                widthFactor: 0.9,
                color: themeData.buttonTheme.colorScheme!.primary,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Forgot the password ?',
                      style: TextStyle(color: themeData.buttonTheme.colorScheme!.primary, fontSize: screenWidth * ControlValues.textFontSize),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => ForgotPasswordScreen());
                        }),
                ],
              )),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(text: "Don't have an account?", style: TextStyle(color: themeData.textTheme.bodyText1!.color)),
                  TextSpan(
                      text: "   Sing up",
                      style: TextStyle(color: themeData.buttonTheme.colorScheme!.primary, fontSize: screenWidth * ControlValues.textFontSize),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => AccountSelectionScreen());
                        }),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
