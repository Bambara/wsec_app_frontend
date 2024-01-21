import 'package:flutter/material.dart';

import '../models/quotation.dart';
import 'icon_button_widget.dart';

class LTWQuotationPending extends StatelessWidget {
  LTWQuotationPending({
    Key? key,
    required this.quotation,
    required this.index,
    required this.proceedItem,
    required this.editItem,
    required this.removeItem,
    required this.printItem,
    required this.openSheet,
  }) : super(key: key);
  final List<Quotation> quotation;
  final int index;
  final Function(int index) openSheet;
  final Function(int index) proceedItem;
  final Function(int index) editItem;
  final Function(int index) removeItem;
  final Function(int index) printItem;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        openSheet(0);
      },
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.01),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
          elevation: 2,
          shadowColor: Theme.of(context).textTheme.bodyText1?.color,
          // color: Theme.of(context).primaryColorLight,
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.01),
            decoration: BoxDecoration(
                //gradient: const LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                color: themeData.canvasColor.withAlpha(100),
                borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              width: screenWidth * 0.922,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(quotation[index].number, style: const TextStyle(fontSize: 14)),
                                  Text(quotation[index].create_date, style: const TextStyle(fontSize: 14)),
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
                                      iconData: Icons.delete_forever_rounded,
                                      isIcon: true,
                                      iconSize: screenWidth * 0.06),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.922,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Customer : ${quotation[index].requester_id.toString()}', style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        SizedBox(
                          width: screenWidth * 0.922,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Total Value : ${quotation[index].total_amount.toString()}', style: const TextStyle(fontSize: 14)),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              Text('Item Count : ${quotation[index].item_count.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        SizedBox(
                          width: screenWidth * 0.922,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status : ${quotation[index].status}', style: const TextStyle(fontSize: 14)),
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
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  IconButtonWidget(
                                    imagePath: '',
                                    function: () {
                                      printItem(index);
                                    },
                                    isIcon: true,
                                    iconData: Icons.print,
                                    iconSize: screenWidth * 0.06,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  IconButtonWidget(
                                    imagePath: '',
                                    function: () {
                                      proceedItem(index);
                                    },
                                    isIcon: true,
                                    iconData: Icons.task,
                                    iconSize: screenWidth * 0.06,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
