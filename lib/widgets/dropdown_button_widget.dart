import 'package:flutter/material.dart';

import '../config/control_values.dart';

class DropDownButtonWidget extends StatelessWidget {
  const DropDownButtonWidget(
      {Key? key,
      required this.items,
      required this.label,
      required this.isRequired,
      required this.selectData,
      required this.heightFactor,
      required this.widthFactor,
      required this.valveChoose})
      : super(key: key);

  final List items;
  final String label;
  final bool isRequired;
  final Function(String) selectData;
  final num heightFactor;
  final num widthFactor;
  final String valveChoose;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * (widthFactor - 0.05),
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: screenHeight * 0.005, top: screenHeight * 0.01),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(width: screenWidth * 0.002),
              isRequired
                  ? const Text(
                      "*",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    )
                  : const Text(""),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(ControlValues.boarderRadius)),
            border: Border.all(color: Colors.black54, width: 0.5),
          ),
          width: MediaQuery.of(context).size.width * widthFactor,
          height: MediaQuery.of(context).size.height * heightFactor,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: const Text('Select Games'),
              iconSize: 30,
              autofocus: true,
              enableFeedback: true,
              isExpanded: true,
              value: valveChoose,
              items: items.map((valueItem) {
                return DropdownMenuItem(value: valueItem, child: Text(valueItem));
              }).toList(),
              onChanged: (valve) {
                selectData(valve.toString());
              },
            ),
          ),
        ),
      ],
    );
  }
}
