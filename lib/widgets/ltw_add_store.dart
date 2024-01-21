import 'package:flutter/material.dart';

import 'icon_button_widget.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({Key? key, required this.itemList, required this.index, required this.removeItem}) : super(key: key);
  final List<String> itemList;
  final int index;
  final Function(int index) removeItem;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(itemList.elementAt(index)),
          IconButtonWidget(
              imagePath: '',
              iconSize: screenWidth * 0.05,
              function: () {
                removeItem(index);
              },
              iconData: Icons.remove_circle,
              isIcon: true)
        ],
      ),
    );
  }
}
