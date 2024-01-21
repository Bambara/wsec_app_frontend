import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../config/control_values.dart';
import '../models/loaded_product.dart';
import 'icon_button_widget.dart';

class LTWLoadedProduct extends StatelessWidget {
  LTWLoadedProduct({
    Key? key,
    required this.productList,
    required this.index,
    required this.getQtyText,
    required this.getBuyText,
    required this.getSellText,
    required this.selectItem,
    required this.editItem,
    required this.removeItem,
  }) : super(key: key);
  final List<LoadedProduct> productList;
  final int index;
  final Function(int index) selectItem;
  final Function(int index) editItem;
  final Function(int index) removeItem;
  final Function(String value) getQtyText;
  final Function(String value) getBuyText;
  final Function(String value) getSellText;

  TextEditingController qtyCtrl = TextEditingController();
  TextEditingController buyCtrl = TextEditingController();
  TextEditingController sellCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: screenHeight * 0.02),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
          elevation: 2,
          shadowColor: Theme.of(context).textTheme.bodyText1?.color,
          // color: Theme.of(context).primaryColorLight,
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
            decoration: BoxDecoration(
                //gradient: const LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                color: themeData.canvasColor.withAlpha(100),
                borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      productList.elementAt(index).product.images.first.url == ''
                          ? GFImageOverlay(
                              boxFit: BoxFit.fill,
                              borderRadius: BorderRadius.circular(ControlValues.boarderRadius),
                              height: screenWidth * 0.3,
                              width: screenWidth * 0.3,
                              image: const AssetImage('assets/images/dettol.jpg'),
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                            )
                          : GFImageOverlay(
                              boxFit: BoxFit.fill,
                              borderRadius: BorderRadius.circular(ControlValues.boarderRadius),
                              height: screenWidth * 0.3,
                              width: screenWidth * 0.3,
                              image: NetworkImage(productList.elementAt(index).product.images.first.url),
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                            ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.613,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(productList[index].product.name, style: const TextStyle(fontSize: 14)),
                                    IconButtonWidget(
                                        imagePath: '',
                                        function: () {
                                          selectItem(index);
                                          GFToast.showToast(
                                            'Product Added !',
                                            toastPosition: GFToastPosition.BOTTOM,
                                            context,
                                            backgroundColor: themeData.primaryColor,
                                          );
                                        },
                                        iconData: Icons.task_alt,
                                        isIcon: true,
                                        iconSize: screenWidth * 0.06),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenWidth * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.613,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(productList[index].quantity.toString(), style: const TextStyle(fontSize: 14)),
                                    Row(
                                      children: [
                                        IconButtonWidget(
                                          imagePath: '',
                                          function: () {
                                            editItem(index);
                                          },
                                          isIcon: true,
                                          iconData: Icons.edit_note,
                                          iconSize: screenWidth * 0.06,
                                        ),
                                        IconButtonWidget(
                                          imagePath: '',
                                          function: () {
                                            removeItem(index);
                                          },
                                          isIcon: true,
                                          iconData: Icons.delete,
                                          iconSize: screenWidth * 0.06,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenWidth * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Qty : ${productList[index].quantity.toString()}', style: const TextStyle(fontSize: 14)),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              Text('Buy : ${productList[index].buy_price.toString()}', style: const TextStyle(fontSize: 14)),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              Text('Sell : ${productList[index].sale_price.toString()}', style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                          SizedBox(
                            height: screenWidth * 0.01,
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
