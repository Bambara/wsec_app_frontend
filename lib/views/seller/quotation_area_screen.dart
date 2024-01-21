import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wsec_app_frontend/models/seller/product_prices.dart';
import 'package:wsec_app_frontend/views/seller/quotation_add_tab.dart';
import 'package:wsec_app_frontend/views/seller/quotation_finish_tab.dart';
import 'package:wsec_app_frontend/views/seller/quotation_pending_tab.dart';

import '../../config/control_values.dart';
import '../../controllers/store/owner/quotation_add_controller.dart';
import '../../controllers/store/owner/quotation_area_controller.dart';
import '../../models/product.dart';
import '../../models/quotation_product.dart';
import '../../models/stock_product.dart';
import '../../widgets/active_text_field_widget.dart';
import '../../widgets/drawer_menu_widget.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/ltw_stock_product.dart';
import '../../widgets/text_field_widget.dart';
import 'member_add_tab.dart';

class QuotationAreaScreen extends StatelessWidget {
  QuotationAreaScreen({Key? key, required this.openDrawer}) : super(key: key);
  static const routeName = '/quotation_area_dashboard';

  final VoidCallback openDrawer;

  final _qac = Get.put(QuotationAreaController());
  final _qAddC = Get.put(QuotationAddController());

  final _tabList = [
    QuotationAddTab(),
    QuotationPendingTab(),
    QuotationFinishTab(),
  ];

  void add() {
    _qac.stockProduct.clear();
    List<Product> product = [
      Product('0001', 'Nodetool', 'D01', '14:00', '002', '003', '', '', [], []),
    ];

    List<StockProduct> stockProduct = [
      StockProduct('0001', 'Nodetool', 'D01', '14:00', '002', '003', '', '', [], 25, 35),
      StockProduct('0001', 'Nodetool', 'D01', '14:00', '002', '003', '', '', [], 25, 35)
    ];

    _qac.stockProduct.addAll(stockProduct);
  }

  @override
  Widget build(BuildContext context) {
    //add();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.iconTheme.color,
            floating: true,
            leading: DrawerMenuWidget(
              onClicked: openDrawer,
            ),
            snap: true,
            title: const Text('Quotation Area'),
            centerTitle: true,
          )
        ],
        body: Center(
          child: GetBuilder<QuotationAreaController>(
            builder: (controller) => _tabList.elementAt(_qac.selectedIndex),
          ),
        ),
      ),
      floatingActionButton: GetBuilder<QuotationAreaController>(builder: (controller) {
        return controller.selectedIndex == 0
            ? SpeedDial(
                overlayColor: Colors.black,
                overlayOpacity: 0.4,
                animatedIcon: AnimatedIcons.menu_close,
                spacing: 10,
                children: [
                  SpeedDialChild(child: const Icon(FontAwesomeIcons.arrowsRotate), label: 'Refresh'),
                  controller.selectedIndex == 0
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.fileCircleCheck),
                          label: 'Proceed Quotation',
                          onTap: () {
                            // loadQuotationProceedBottomSheet(context, screenHeight, screenWidth, themeData);
                          },
                        )
                      : SpeedDialChild(),
                  controller.selectedIndex == 0
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.truckRampBox),
                          label: 'Add Item',
                          onTap: () {
                            // loadBottomSheet(context, screenHeight, screenWidth, themeData);
                          },
                        )
                      : SpeedDialChild(),
                  controller.selectedIndex == 1
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.print),
                          label: 'Print GRN',
                          onTap: () {
                            Get.to(() => AddMemberTab());
                          },
                        )
                      : SpeedDialChild(),
                  controller.selectedIndex == 2
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.print),
                          label: 'Print GRN',
                          onTap: () {
                            Get.to(() => AddMemberTab());
                          },
                        )
                      : SpeedDialChild(),
                ],
              )
            : Container();
      }),
      bottomNavigationBar: ConvexAppBar(
        height: 50,
        backgroundColor: themeData.primaryColor,
        color: themeData.textTheme.bodyText1?.color,
        items: const [
          TabItem(icon: FontAwesomeIcons.fileCirclePlus, title: 'New'),
          TabItem(icon: FontAwesomeIcons.fileCircleExclamation, title: 'Pending'),
          TabItem(icon: FontAwesomeIcons.fileCircleCheck, title: 'Finished'),
        ],
        onTap: (int i) {
          _qac.selectedIndex = i;
          Get.put(QuotationAddController()).onReady();
          if (kDebugMode) {
            print('click index=${_qac.selectedIndex}');
          }
        },
        curveSize: 100,
        style: TabStyle.reactCircle,
      ),
    );
  }

  void loadBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // final QuotationAddController qaddc = Get.put(QuotationAddController());
    // final QuotationAreaController controller = Get.put(QuotationAreaController());

    _qac.syncProductStock();

    String store = 'Cate 01';
    String category = 'Cate 01';
    double qty = 0;
    double disValue = 0;
    double disPrece = 0;

    void selectStore(String data) {
      category = data;
      _qac.category = (data);
    }

    void getQtyText(String data) {
      try {
        qty = double.parse(data);
      } catch (e) {
        e.printError();
      }
    }

    void getDisValueText(String data) {
      try {
        disValue = double.parse(data);
      } catch (e) {
        e.printError();
      }
    }

    void getDisPerceText(String data) {
      try {
        disPrece = double.parse(data);
      } catch (e) {
        e.printError();
      }
    }

    void calDiscountValue(int index) {
      disValue = ((disPrece * (qty * _qac.stockProduct.elementAt(index).sale_price)) / 100);
    }

    void calDiscountPercentage(int index) {
      disPrece = ((disValue / (qty * _qac.stockProduct.elementAt(index).sale_price)) * 100);
    }

    void addSelectedProduct(int index) {
      if (qty != 0) {
        if (disValue > 0) {
          //Logger().i('Cal Dis Value');
          calDiscountPercentage(index);
        } else if (disPrece > 0) {
          //Logger().i('Cal Dis Perce');
          calDiscountValue(index);
        }
        final product = Product(
            _qac.stockProduct.elementAt(index).id,
            _qac.stockProduct.elementAt(index).name,
            _qac.stockProduct.elementAt(index).product_code,
            _qac.stockProduct.elementAt(index).bar_code,
            _qac.stockProduct.elementAt(index).category,
            _qac.stockProduct.elementAt(index).package_type,
            _qac.stockProduct.elementAt(index).brand,
            _qac.stockProduct.elementAt(index).status,
            _qac.stockProduct.elementAt(index).images, [
          ProductPrice(
            '',
            _qac.stockProduct.elementAt(index).sale_price,
            _qac.stockProduct.elementAt(index).sale_price,
            _qac.stockProduct.elementAt(index).quantity,
          )
        ]);
        _qAddC.addProduct(
            QuotationProduct('', '', product, _qac.stockProduct.elementAt(index).sale_price, _qac.stockProduct.elementAt(index).sale_price, qty, disValue, disPrece, ''));
      }
      qty = 0;
      disValue = 0;
      disPrece = 0;
    }

    showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ControlValues.boarderRadius)),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom * 0.5),
            child: SizedBox(
              height: screenHeight * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: themeData.primaryColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.1,
                              ),
                              const Text('Add Products', style: TextStyle(fontSize: 16))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButtonWidget(
                                imagePath: '',
                                function: () {
                                  Navigator.pop(context);
                                },
                                iconData: Icons.close,
                                isIcon: true,
                                iconSize: 32),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  TextFieldWidget(
                      hintText: 'Search',
                      label: 'Search',
                      isRequired: false,
                      txtCtrl: _qac.nameCtrl,
                      secret: false,
                      heightFactor: 0.055,
                      widthFactor: 0.9,
                      inputType: TextInputType.text),
                  SizedBox(
                    height: screenHeight * 0.007,
                  ),
                  GetBuilder<QuotationAreaController>(
                    builder: (sac) => DropDownButtonWidget(
                        items: const ["Cate 01", "Cate 02"],
                        label: 'Category',
                        isRequired: true,
                        selectData: selectStore,
                        heightFactor: 0.057,
                        widthFactor: 0.9,
                        valveChoose: category),
                  ),
                  SizedBox(
                    height: screenHeight * 0.007,
                  ),
                  Expanded(
                    child: GetBuilder<QuotationAreaController>(
                      builder: (controller) => ListView.builder(
                        addAutomaticKeepAlives: false,
                        cacheExtent: 100,
                        itemCount: controller.stockProduct.length,
                        itemBuilder: (context, index) => LTWStockProduct(
                          index: index,
                          productList: controller.stockProduct.toList(),
                          getQtyText: getQtyText,
                          getDisValueText: getDisValueText,
                          getDisPreceText: getDisPerceText,
                          selectItem: addSelectedProduct,
                          editItem: (code) {},
                          removeItem: (code) {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void loadQuotationProceedBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // List<Product> product = [Product('0001', 'Nodetool', 'D01', '14:00', '002', '003', '', '', Store())];

    // List<StockProduct> stockProduct = [StockProduct('', product.last, '', 25, 35, 15, ''), StockProduct('', product.last, '', 25, 35, 15, '')];
    // List<StockProduct> stockProduct = [];

    void selectPayType(String data) {
      _qAddC.payType = (data);
    }

    void calBillDisPercentage(String disValue) {
      try {
        _qAddC.billDisValue = double.parse(disValue);
        _qAddC.netAmount = _qAddC.grossAmount - _qAddC.billDisValue;
        _qAddC.dueAmount = _qAddC.netAmount - _qAddC.payedAmount;
        _qAddC.billDisPercentage = (_qAddC.billDisValue / _qAddC.grossAmount) * 100;
        _qAddC.bdpCtrl.text = _qAddC.billDisPercentage.toStringAsPrecision(3);
        // _qAddC.update();
      } catch (e) {
        e.printError();
      }
    }

    void calBillDisValue(String disValue) {
      try {
        _qAddC.billDisPercentage = double.parse(disValue);
        _qAddC.billDisValue = (_qAddC.billDisPercentage * _qAddC.grossAmount) / 100;
        _qAddC.netAmount = _qAddC.grossAmount - _qAddC.billDisValue;
        _qAddC.dueAmount = _qAddC.netAmount - _qAddC.payedAmount;
        _qAddC.bdaCtrl.text = _qAddC.billDisValue.toStringAsPrecision(3);
        // _qAddC.update();
      } catch (e) {
        e.printError();
      }
    }

    void calDeuAmount(String payedAmount) {
      try {
        _qAddC.payedAmount = double.parse(payedAmount);
        _qAddC.dueAmount = (_qAddC.netAmount - _qAddC.payedAmount);
        // _qAddC.update();
      } catch (e) {
        e.printError();
      }
    }

    void proceedQuotation() {
      /*ifc.addInvoice(
        Invoice(
          'id',
          'number',
          'create_time',
          'modify_time',
          'cashier_id',
          'customer_id',
          _qAddC.itemQty,
          _qAddC.totalAmount,
          _qAddC.lineDisValue,
          _qAddC.lineDisPercentage,
          _qAddC.grossAmount,
          _qAddC.billDisValue,
          _qAddC.billDisPercentage,
          _qAddC.netAmount,
          'Pending',
          'store_id',
          _qAddC.payedAmount,
          _qAddC.dueAmount,
          '',
          '',
          _qAddC.invoiceProducts,
        ),
      );
       _logger.i(ifc.invoices.last.toJson());
      _logger.i(ifc.invoices.last.invoice_products.last.toJson());

      try {
        _qAddC.proceedQuotation();
        _qAddC.update();
        _qAddC.onClose();
        Navigator.of(context).pop();
      } catch (e) {
        _qac.logger.e(e);
      }*/
    }

    _qAddC.calQuotationValues();

    showMaterialModalBottomSheet(

        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ControlValues.boarderRadius)),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom * 0.5),
            child: SizedBox(
              height: screenHeight * 0.72,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: themeData.primaryColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.1,
                                ),
                                const Text('Quotation Proceed', style: TextStyle(fontSize: 16))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButtonWidget(
                                  imagePath: '',
                                  function: () {
                                    Navigator.pop(context);
                                  },
                                  iconData: Icons.close,
                                  isIcon: true,
                                  iconSize: 32),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Total Amount : ${_qAddC.totalAmount.toString()}', style: const TextStyle(fontSize: 16)),
                        Text('Item Count : ${_qAddC.itemQty.toString()}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Total Line Dis Value : ${_qAddC.totalLineDisValue.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 16)),
                        Text('Total Line Dis % : ${_qAddC.totalLineDisPercentage.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Center(
                      child: Text('Gross Amount : ${_qAddC.grossAmount.toStringAsFixed(3)}', style: const TextStyle(fontSize: 16)),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ActiveTextFieldWidget(
                          hintText: 'Bll Dis. Amount',
                          label: 'Bill Dis. Amount',
                          isRequired: true,
                          txtCtrl: _qAddC.bdaCtrl,
                          secret: false,
                          heightFactor: 0.055,
                          widthFactor: 0.45,
                          inputType: TextInputType.number,
                          getText: calBillDisPercentage,
                        ),
                        ActiveTextFieldWidget(
                            hintText: 'Bill Dis. Percentage',
                            label: 'Bill Dis. Percentage',
                            isRequired: true,
                            txtCtrl: _qAddC.bdpCtrl,
                            secret: false,
                            heightFactor: 0.055,
                            widthFactor: 0.45,
                            inputType: TextInputType.number,
                            getText: calBillDisValue),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Center(
                        child: GetBuilder<QuotationAddController>(
                      builder: (controller) => Text('Net Amount : ${controller.netAmount.toStringAsFixed(3)}', style: const TextStyle(fontSize: 16)),
                    )),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GetBuilder<QuotationAddController>(
                          builder: (controller) => DropDownButtonWidget(
                              items: const ['Cash', 'Credit', 'Cheque', 'Bank Deposit'],
                              label: 'Pay Type',
                              isRequired: true,
                              selectData: selectPayType,
                              heightFactor: 0.057,
                              widthFactor: 0.45,
                              valveChoose: _qAddC.payType),
                        ),
                        ActiveTextFieldWidget(
                            hintText: 'Payed Amount',
                            label: 'Payed Amount',
                            isRequired: true,
                            txtCtrl: _qAddC.payedCtrl,
                            secret: false,
                            heightFactor: 0.055,
                            widthFactor: 0.45,
                            inputType: TextInputType.number,
                            getText: calDeuAmount),
                      ],
                    ),
                    GetBuilder<QuotationAddController>(
                      builder: (controller) {
                        return _qAddC.payType == 'Cheque' || _qAddC.payType == 'Bank Deposit'
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  TextFieldWidget(
                                      hintText: 'Pay Number',
                                      label: 'Pay Number',
                                      isRequired: true,
                                      txtCtrl: _qAddC.payNumberCtrl,
                                      secret: true,
                                      heightFactor: 0.055,
                                      widthFactor: 0.9,
                                      inputType: TextInputType.number),
                                ],
                              )
                            : const Center();
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Center(child: Text('Due Amount : ${_qAddC.dueAmount.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 16))),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    FlatButtonWidget(
                      title: 'Proceed',
                      function: proceedQuotation,
                      heightFactor: 0.065,
                      widthFactor: 0.9,
                      color: themeData.buttonTheme.colorScheme!.primary,
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
