import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wsec_app_frontend/views/seller/quotation_pending_tab.dart';

import '../../config/control_values.dart';
import '../../controllers/store/owner/invoice_add_controller.dart';
import '../../controllers/store/owner/invoice_area_controller.dart';
import '../../controllers/store/owner/invoice_finish_controller.dart';
import '../../models/invoice_product.dart';
import '../../models/product.dart';
import '../../models/seller/invoice.dart';
import '../../models/stock_product.dart';
import '../../models/user/avatar.dart';
import '../../widgets/active_text_field_widget.dart';
import '../../widgets/drawer_menu_widget.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/ltw_stock_product.dart';
import '../../widgets/text_field_widget.dart';
import 'invoice_add_tab.dart';
import 'invoice_finish_tab.dart';
import 'member_add_tab.dart';

class InvoiceAreaScreen extends StatelessWidget {
  InvoiceAreaScreen({Key? key, required this.openDrawer}) : super(key: key);
  static const routeName = '/invoice_area_dashboard';

  final VoidCallback openDrawer;

  final Logger _logger = Logger(filter: null);

  final InvoiceAreaController _iaC = Get.put(InvoiceAreaController());
  final InvoiceAddController _iaddC = Get.put(InvoiceAddController());
  final InvoiceFinishController _ifC = Get.put(InvoiceFinishController());

  final tabList = [
    InvoiceAddTab(),
    QuotationPendingTab(),
    InvoiceFinishTab(),
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            title: const Text('Invoice Area'),
            centerTitle: true,
          )
        ],
        // body: TabBarView(
        //   children: [talList.elementAt(selectedTab)],
        // ),
        body: Center(
          child: GetBuilder<InvoiceAreaController>(
            builder: (sac) => tabList.elementAt(_iaC.selectedIndex),
          ),
        ),
      ),
      floatingActionButton: GetBuilder<InvoiceAreaController>(
          builder: (qac) => SpeedDial(
                overlayColor: Colors.black,
                overlayOpacity: 0.4,
                animatedIcon: AnimatedIcons.menu_close,
                spacing: 10,
                children: [
                  SpeedDialChild(child: const Icon(FontAwesomeIcons.arrowsRotate), label: 'Refresh'),
                  qac.selectedIndex == 0
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.fileCircleCheck),
                          label: 'Proceed Invoice',
                          onTap: () {
                            _loadInvoiceProceedBottomSheet(context, screenHeight, screenWidth, themeData);
                          },
                        )
                      : SpeedDialChild(),
                  qac.selectedIndex == 0
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.truckRampBox),
                          label: 'Add Item',
                          onTap: () {
                            _loadProductSelectBottomSheet(context, screenHeight, screenWidth, themeData);
                          },
                        )
                      : SpeedDialChild(),
                  qac.selectedIndex == 1
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.print),
                          label: 'Print Invoice',
                          onTap: () {
                            Get.to(() => AddMemberTab());
                          },
                        )
                      : SpeedDialChild(),
                  qac.selectedIndex == 2
                      ? SpeedDialChild(
                          child: const Icon(FontAwesomeIcons.print),
                          label: 'Print Invoice',
                          onTap: () {
                            Get.to(() => AddMemberTab());
                          },
                        )
                      : SpeedDialChild(),
                ],
              )),
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
          _iaC.selectedIndex = i;
          Get.put(InvoiceAddController()).onReady();
          if (kDebugMode) {
            print('click index=$selectedTab');
          }
        },
        curveSize: 100,
        style: TabStyle.reactCircle,
      ),
    );
  }

  void _loadProductSelectBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    final TextEditingController nameCtrl = TextEditingController();

    List<Product> product = [
      Product('0001', 'Nodetool', 'D01', '14:00', '002', '003', '', '', [], []),
    ];

    final avatar = Avatar('', '', '');

    List<StockProduct> stockProduct = [
      StockProduct('0001', 'Nodetool', 'D01', '14:00', '002', '003', '', '', [avatar], 25, 35),
      StockProduct('0001', 'Nodetool', 'D01', '14:00', '002', '003', '', '', [avatar], 25, 35)
    ];

    String category = 'Cate 01';
    double qty = 0;
    double discountValue = 0;
    double discountPercentage = 0;

    void selectStore(String data) {
      category = data;
      _iaC.category = (data);
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
        discountValue = double.parse(data);
      } catch (e) {
        e.printError();
      }
    }

    void getDisPerceText(String data) {
      try {
        discountPercentage = double.parse(data);
      } catch (e) {
        e.printError();
      }
    }

    void calDiscountValue(int index) {
      discountValue = ((discountPercentage * (qty * stockProduct.elementAt(index).sale_price)) / 100);
    }

    void calDiscountPercentage(int index) {
      discountPercentage = ((discountValue / (qty * stockProduct.elementAt(index).sale_price)) * 100);
    }

    void addSelectedProduct(int index) {
      if (qty != 0) {
        if (discountValue > 0) {
          //Logger().i('Cal Dis Value');
          calDiscountPercentage(index);
        } else if (discountPercentage > 0) {
          //Logger().i('Cal Dis Perce');
          calDiscountValue(index);
        }
        _iaddC.addProduct(InvoiceProduct(
          'id',
          'invoice_num',
          stockProduct.elementAt(index),
          stockProduct.elementAt(index).sale_price,
          stockProduct.elementAt(index).sale_price,
          qty,
          discountValue,
          discountPercentage,
          0,
          'Invoiced',
          'None',
        ));
        // _logger.i(iaddc.invoiceProducts.toString());
      }
      qty = 0;
      discountValue = 0;
      discountPercentage = 0;
    }

    showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ControlValues.boarderRadius)),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              const Text('Product Search', style: TextStyle(fontSize: 16))
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
                    height: screenHeight * 0.007,
                  ),
                  TextFieldWidget(
                      hintText: 'Search',
                      label: 'Search',
                      isRequired: true,
                      txtCtrl: nameCtrl,
                      secret: true,
                      heightFactor: 0.055,
                      widthFactor: 0.9,
                      inputType: TextInputType.streetAddress),
                  SizedBox(
                    height: screenHeight * 0.007,
                  ),
                  GetBuilder<InvoiceAreaController>(
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
                    child: ListView.builder(
                      addAutomaticKeepAlives: false,
                      cacheExtent: 100,
                      itemCount: stockProduct.length,
                      itemBuilder: (context, index) => LTWStockProduct(
                        index: index,
                        productList: stockProduct.toList(),
                        getQtyText: getQtyText,
                        getDisValueText: getDisValueText,
                        getDisPreceText: getDisPerceText,
                        selectItem: addSelectedProduct,
                        editItem: (code) {},
                        removeItem: (code) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _loadInvoiceProceedBottomSheet(BuildContext context, double screenHeight, double screenWidth, ThemeData themeData) {
    // List<Product> product = [Product('0001', 'Nodetool', 'D01', '14:00', '002', '003', '', '', Store())];

    // List<StockProduct> stockProduct = [StockProduct('', product.last, '', 25, 35, 15, ''), StockProduct('', product.last, '', 25, 35, 15, '')];
    List<StockProduct> stockProduct = [];

    _iaddC.payType = 'Cash';

    double totalAmount = 0;
    double itemQty = 0;
    double lineDisValue = 0;
    double lineDisPercentage = 0;
    double grossAmount = 0;
    double billDisValue = 0;
    double billDisPercentage = 0;
    double netAmount = 0;
    double payedAmount = 0;
    double dueAmount = 0;

    void selectPayType(String data) {
      _iaddC.payType = (data);
    }

    void calBillDiscountValue(int index) {
      lineDisValue = ((lineDisPercentage * (itemQty * stockProduct.elementAt(index).sale_price)) / 100);
    }

    void calBillDiscountPercentage(int index) {
      lineDisPercentage = ((lineDisValue / (itemQty * stockProduct.elementAt(index).sale_price)) * 100);
    }

    void calBillDisPercentage(String disValue) {
      try {
        _iaddC.billDisValue = double.parse(disValue);
        _iaddC.netAmount = _iaddC.grossAmount - _iaddC.billDisValue;
        _iaddC.dueAmount = _iaddC.netAmount - _iaddC.payedAmount;
        _iaddC.billDisPercentage = (_iaddC.billDisValue / _iaddC.grossAmount) * 100;
        _iaddC.bdpCtrl.text = _iaddC.billDisPercentage.toStringAsPrecision(3);
        // iaddc.update();
      } catch (e) {
        e.printError();
      }
    }

    void calBillDisValue(String disValue) {
      try {
        _iaddC.billDisPercentage = double.parse(disValue);
        _iaddC.billDisValue = (_iaddC.billDisPercentage * _iaddC.grossAmount) / 100;
        _iaddC.netAmount = _iaddC.grossAmount - _iaddC.billDisValue;
        _iaddC.dueAmount = _iaddC.netAmount - _iaddC.payedAmount;
        _iaddC.bdaCtrl.text = _iaddC.billDisValue.toStringAsPrecision(3);
        // iaddc.update();
      } catch (e) {
        e.printError();
      }
    }

    void calDeuAmount(String payedAmount) {
      try {
        _iaddC.payedAmount = double.parse(payedAmount);
        _iaddC.dueAmount = (_iaddC.netAmount - _iaddC.payedAmount);
        if (_iaddC.dueAmount < 0) {
          _iaddC.dueAmount += (-1);
          _iaddC.BorD = 'Balance Amount';
        } else {
          _iaddC.BorD = 'Deu Amount';
        }
        // iaddc.update();
      } catch (e) {
        e.printError();
      }
    }

    void proceedInvoice() {
      _ifC.addInvoice(
        Invoice(
          'id',
          'number',
          'create_time',
          'modify_time',
          'cashier_id',
          'customer_id',
          _iaddC.itemQty,
          _iaddC.totalAmount,
          _iaddC.lineDisValue,
          _iaddC.lineDisPercentage,
          _iaddC.grossAmount,
          _iaddC.billDisValue,
          _iaddC.billDisPercentage,
          _iaddC.netAmount,
          'Pending',
          'store_id',
          _iaddC.payedAmount,
          _iaddC.dueAmount,
          '',
          '',
          _iaddC.invoiceProducts,
        ),
      );
      /*_logger.i(ifc.invoices.last.toJson());
      _logger.i(ifc.invoices.last.invoice_products.last.toJson());*/
      _iaddC.onClose();
      Navigator.of(context).pop();
    }

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
                                const Text('Invoice Proceed', style: TextStyle(fontSize: 16))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButtonWidget(
                                  imagePath: '',
                                  function: () {
                                    _iaddC.resetValues();
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
                        Text('Total Amount : ${_iaddC.totalAmount.toString()}', style: const TextStyle(fontSize: 16)),
                        Text('Item Count : ${_iaddC.itemQty.toString()}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Total Line Dis Value : ${_iaddC.lineDisValue.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 16)),
                        Text('Total Line Dis % : ${_iaddC.lineDisPercentage.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Center(child: Text('Gross Amount : ${_iaddC.grossAmount.toStringAsFixed(3)}', style: const TextStyle(fontSize: 16))),
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
                          txtCtrl: _iaddC.bdaCtrl,
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
                            txtCtrl: _iaddC.bdpCtrl,
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
                    Center(child: Text('Net Amount : ${_iaddC.netAmount.toStringAsFixed(3)}', style: const TextStyle(fontSize: 16))),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GetBuilder<InvoiceAddController>(
                          builder: (controller) => DropDownButtonWidget(
                              items: const ['Cash', 'Credit', 'Cheque', 'Bank Deposit'],
                              label: 'Pay Type',
                              isRequired: true,
                              selectData: selectPayType,
                              heightFactor: 0.057,
                              widthFactor: 0.45,
                              valveChoose: _iaddC.payType),
                        ),
                        ActiveTextFieldWidget(
                            hintText: 'Payed Amount',
                            label: 'Payed Amount',
                            isRequired: true,
                            txtCtrl: _iaddC.payedCtrl,
                            secret: false,
                            heightFactor: 0.055,
                            widthFactor: 0.45,
                            inputType: TextInputType.number,
                            getText: calDeuAmount),
                      ],
                    ),
                    GetBuilder<InvoiceAddController>(
                      builder: (controller) {
                        return _iaddC.payType == 'Cheque' || _iaddC.payType == 'Bank Deposit'
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  TextFieldWidget(
                                      hintText: 'Pay Number',
                                      label: 'Pay Number',
                                      isRequired: true,
                                      txtCtrl: _iaddC.payNumberCtrl,
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
                    Center(child: Text('Due Amount : ${_iaddC.dueAmount.toStringAsPrecision(3)}', style: const TextStyle(fontSize: 16))),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    FlatButtonWidget(
                      title: 'Proceed',
                      function: proceedInvoice,
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
