import 'package:flutter/material.dart';

import '../config/control_values.dart';

class FlatButtonWidget extends StatelessWidget {
  const FlatButtonWidget({Key? key, required this.title, required this.function, required this.heightFactor, required this.widthFactor, required this.color})
      : super(key: key);

  final String title;
  final Function function;
  final num heightFactor;
  final num widthFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * widthFactor,
      height: screenHeight * heightFactor,
      child: MaterialButton(
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(ControlValues.boarderRadius),
          ),
        ),
        onPressed: () {
          function.call();
          // widget.loadSignup(context);
        },
        child: Center(
          child: Text(title, style: TextStyle(fontWeight: FontWeight.normal, fontSize: screenWidth * ControlValues.controlFontSize)),
        ),
      ),
    );
  }
}
