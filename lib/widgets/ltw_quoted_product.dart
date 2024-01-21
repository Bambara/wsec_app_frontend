import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../config/control_values.dart';
import '../models/quotation_product.dart';
import 'icon_button_widget.dart';

class LTWQuotedProduct extends StatelessWidget {
  LTWQuotedProduct({
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
  final List<QuotationProduct> productList;
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
                    GFImageOverlay(
                      borderRadius: BorderRadius.circular(ControlValues.boarderRadius),
                      height: screenWidth * 0.3,
                      width: screenWidth * 0.3,
                      image: const AssetImage('assets/images/dettol.jpg'),
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0), BlendMode.darken),
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
                              width: screenWidth * 0.623,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(productList[index].product.name, style: const TextStyle(fontSize: 14)),
                                  IconButtonWidget(
                                      imagePath: '',
                                      function: () {
                                        // selectItem(index);
                                        removeItem(index);
                                        /*GFToast.showToast(
                                          'Product Added !',
                                          toastPosition: GFToastPosition.BOTTOM,
                                          context,
                                          backgroundColor: themeData.primaryColor,
                                        );*/
                                      },
                                      iconData: Icons.highlight_remove,
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
                                  Text(productList[index].qty.toString(), style: const TextStyle(fontSize: 14)),
                                  /*Row(
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
                                  )*/
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
                            Text('Qty : ${productList[index].qty.toString()}', style: const TextStyle(fontSize: 14)),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            Text('Dis. : ${productList[index].line_dis_value.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 14)),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            Text('Dis % : ${productList[index].line_dis_prece.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 14)),
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
    );
  }
}
