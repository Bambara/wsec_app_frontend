import 'package:flutter/material.dart';

import '../../widgets/flat_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/forgot_password_screen';

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
            title: const Text('Forgot Password'),
            centerTitle: true,
          )
        ],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldWidget(
                    hintText: 'Email or Phone Number',
                    label: 'Email or Phone Number',
                    isRequired: true,
                    txtCtrl: userCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.emailAddress),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                FlatButtonWidget(
                  title: 'Reset Password',
                  function: () {},
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
