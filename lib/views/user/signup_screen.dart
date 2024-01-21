import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

import '../../controllers/user/singup_controller.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key, required this.userType}) : super(key: key);
  static const routeName = '/signup_screen';

  final String userType;

  final _sc = Get.put(SignUpController());

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
            title: const Text('Signup'),
            centerTitle: true,
          )
        ],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    _sc.pickProfileImage().then((value) => _sc.profileImage = value);
                  },
                  child: GetBuilder<SignUpController>(
                    builder: (controller) => _sc.isSelected == false
                        ? GFImageOverlay(
                            image: const AssetImage('assets/images/company_logo.jpg'),
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            borderRadius: BorderRadius.circular(screenWidth * 0.05),
                            boxFit: BoxFit.cover,
                          )
                        : GFImageOverlay(
                            image: FileImage(_sc.profileImage),
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            borderRadius: BorderRadius.circular(screenWidth * 0.05),
                            shape: BoxShape.rectangle,
                            boxFit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFieldWidget(
                    hintText: 'First Name',
                    label: 'First Name',
                    isRequired: true,
                    txtCtrl: _sc.fNameCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.name),
                SizedBox(height: screenHeight * 0.015),
                TextFieldWidget(
                    hintText: 'Last Name',
                    label: 'Last Name',
                    isRequired: true,
                    txtCtrl: _sc.lNameCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.name),
                SizedBox(height: screenHeight * 0.015),
                TextFieldWidget(
                    hintText: 'User Name',
                    label: 'User Name',
                    isRequired: true,
                    txtCtrl: _sc.uNameCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.emailAddress),
                SizedBox(height: screenHeight * 0.015),
                TextFieldWidget(
                    hintText: 'Email Address',
                    label: 'Email Address',
                    isRequired: true,
                    txtCtrl: _sc.emailCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.emailAddress),
                SizedBox(height: screenHeight * 0.015),
                TextFieldWidget(
                    hintText: 'Mobile Number',
                    label: 'Mobile Number',
                    isRequired: true,
                    txtCtrl: _sc.mobileCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.phone),
                SizedBox(height: screenHeight * 0.015),
                TextFieldWidget(
                    hintText: 'Password',
                    label: 'Password',
                    isRequired: true,
                    txtCtrl: _sc.passwordCtrl,
                    secret: true,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.text),
                SizedBox(height: screenHeight * 0.015),
                TextFieldWidget(
                    hintText: 'Confirm Password',
                    label: 'Confirm Password',
                    isRequired: true,
                    txtCtrl: _sc.cPasswordCtrl,
                    secret: true,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.text),
                SizedBox(height: screenHeight * 0.015),
                userType == 'Seller'
                    ? TextFieldWidget(
                        hintText: 'Seller Company',
                        label: 'Seller Company',
                        isRequired: true,
                        txtCtrl: _sc.sellerCtrl,
                        secret: false,
                        heightFactor: 0.055,
                        widthFactor: 0.9,
                        inputType: TextInputType.text)
                    : Container(),
                userType == 'Seller' ? SizedBox(height: screenHeight * 0.04) : Container(),
                FlatButtonWidget(
                  title: userType == 'user' ? 'Signup' : 'Signup',
                  function: () {
                    _sc.userType = userType;
                    _sc.createAccount();
                  },
                  heightFactor: 0.065,
                  widthFactor: 0.9,
                  color: themeData.buttonTheme.colorScheme!.primary,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(text: "Already have an account?", style: TextStyle(color: themeData.textTheme.bodyText1!.color)),
                    TextSpan(
                        text: "   Login",
                        style: TextStyle(color: themeData.buttonTheme.colorScheme!.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //Get.to(AccountSelectionScreen());
                          }),
                  ],
                )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
