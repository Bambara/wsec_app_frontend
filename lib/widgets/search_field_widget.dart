import 'package:flutter/material.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';

import '../config/control_values.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget(
      {Key? key,
      required this.hintText,
      required this.label,
      required this.isRequired,
      required this.txtCtrl,
      required this.heightFactor,
      required this.widthFactor,
      required this.items,
      required this.selectItem})
      : super(key: key);

  final String hintText;
  final String label;
  final bool isRequired;
  final TextEditingController txtCtrl;
  final num heightFactor;
  final num widthFactor;

  // final TextInputType inputType;
  final List items;
  final Function(String) selectItem;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        label.isEmpty
            ? SizedBox(height: screenHeight * 0.005)
            : Container(
                width: screenWidth * (widthFactor - 0.05),
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
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          )
                        : const Text(""),
                  ],
                ),
              ),
        Container(
          width: MediaQuery.of(context).size.width * widthFactor,
          height: MediaQuery.of(context).size.height * heightFactor,
          padding: EdgeInsets.only(left: screenWidth * 0.02, right: screenWidth * 0.02, bottom: screenHeight * 0.005),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(ControlValues.boarderRadius)),
            border: Border.all(color: Colors.black54, width: 0.5),
          ),
/*          child: TextField(
            keyboardType: inputType,
            textInputAction: TextInputAction.next,
            controller: txtCtrl,
            obscureText: secret,
            autocorrect: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              // labelText: widget.hintText,
            ),
          ),*/
          child: GFSearchBar(
            searchList: items,
            searchQueryBuilder: (query, list) {
              return list.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
            },
            overlaySearchListItemBuilder: (item) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            },
            controller: txtCtrl,
            searchBoxInputDecoration: InputDecoration(
              // border: InputBorder.none,
              hintText: hintText,
              // labelText: widget.hintText,
            ),
            onItemSelected: (item) {
              selectItem(item);
            },
          ),
        ),
      ],
    );
  }
}
