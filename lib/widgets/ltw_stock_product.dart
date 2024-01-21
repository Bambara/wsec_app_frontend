import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wsec_app_frontend/widgets/tile_text_filed_widget.dart';

import '../config/control_values.dart';
import '../models/stock_product.dart';
import 'icon_button_widget.dart';

class LTWStockProduct extends StatelessWidget {
  LTWStockProduct({
    Key? key,
    required this.productList,
    required this.index,
    required this.getQtyText,
    required this.getDisValueText,
    required this.getDisPreceText,
    required this.selectItem,
    required this.editItem,
    required this.removeItem,
  }) : super(key: key);
  final List<StockProduct> productList;
  final int index;
  final Function(int index) selectItem;
  final Function(int index) editItem;
  final Function(int index) removeItem;
  final Function(String value) getQtyText;
  final Function(String value) getDisValueText;
  final Function(String value) getDisPreceText;

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(ControlValues.boarderRadius)),
              depth: 2,
              lightSource: LightSource.top,
              intensity: 1,
              shadowDarkColor: Colors.black54,
              color: Colors.white12),
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
                        // image: const AssetImage('assets/images/company_logo.jpg'),
                        image: NetworkImage(productList[index].images.first.url),
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
                                width: screenWidth * 0.605,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(productList[index].name, style: const TextStyle(fontSize: 14)),
                                    IconButtonWidget(
                                        imagePath: '',
                                        function: () {
                                          selectItem(index);
                                          GFToast.showToast(
                                            'Product Added !',
                                            toastPosition: GFToastPosition.TOP,
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
                            height: screenHeight * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.605,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('C. Qty ${productList[index].quantity}', style: const TextStyle(fontSize: 14)),
                                    Text('Buy : ${productList[index].sale_price.toString()}', style: const TextStyle(fontSize: 14)),
                                    Text('Sell : ${productList[index].sale_price.toString()}', style: const TextStyle(fontSize: 14)),
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
                            height: screenHeight * 0.03,
                          ),
                          Row(
                            children: [
                              //Text('Buy : ${productList[index].buy_price.toString()}', style: const TextStyle(fontSize: 14)),
                              TileTextFieldWidget(
                                  hintText: 'Qty', widthFactor: 0.17, heightFactor: 0.03, textController: qtyCtrl, inputType: TextInputType.number, getText: getQtyText),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              //Text('Sell : ${productList[index].sell_price.toString()}', style: const TextStyle(fontSize: 14)),
                              TileTextFieldWidget(
                                  hintText: 'Dis Value',
                                  widthFactor: 0.17,
                                  heightFactor: 0.03,
                                  textController: buyCtrl,
                                  inputType: TextInputType.number,
                                  getText: getDisValueText),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              TileTextFieldWidget(
                                  hintText: 'Dis Prece',
                                  widthFactor: 0.17,
                                  heightFactor: 0.03,
                                  textController: sellCtrl,
                                  inputType: TextInputType.number,
                                  getText: getDisPreceText),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
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
