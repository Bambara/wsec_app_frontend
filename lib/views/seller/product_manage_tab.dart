import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/store/owner/product_manage_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class ProductManageTab extends StatelessWidget {
  ProductManageTab({Key? key}) : super(key: key);

  final _pmc = Get.put(ProductManageController());

  void selectStatus(String value) {
    _pmc.status = value;
  }

  void selectBrand(String value) {
    _pmc.brandName = value;
  }

  void selectPackageType(String value) {
    _pmc.packageType = value;
  }

  void selectCategory(String value) {
    _pmc.category = value;
  }

  void selectStore(String value) {
    _pmc.store = value;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          /*Card(
            elevation: 1,
            child: GestureDetector(
              child: GFAvatar(
                radius: screenHeight * 0.08,
                shape: GFAvatarShape.standard,
                backgroundImage: const AssetImage('assets/images/dettol.jpg'),
                backgroundColor: Colors.grey.shade600,
                child: Text(
                  'Player'[0].toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
            ),
          ),*/
          GestureDetector(
            onTap: () {
              _pmc.pickProfileImage();
            },
            child: GetBuilder<ProductManageController>(
              builder: (controller) => controller.isSelected == false
                  ? GFImageOverlay(
                      image: const AssetImage('assets/images/company_logo.jpg'),
                      width: screenWidth * 0.3,
                      height: screenWidth * 0.3,
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      boxFit: BoxFit.cover,
                    )
                  : GFImageOverlay(
                      image: FileImage(controller.profileImage),
                      width: screenWidth * 0.3,
                      height: screenWidth * 0.3,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      boxFit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          GetBuilder<ProductManageController>(
            builder: (pmc) => DropDownButtonWidget(
                items: _pmc.storeNames, label: 'Store', isRequired: true, selectData: selectStore, heightFactor: 0.057, widthFactor: 0.9, valveChoose: _pmc.store),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          TextFieldWidget(
              hintText: 'Name', label: 'Name', isRequired: true, txtCtrl: _pmc.nameCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          TextFieldWidget(
              hintText: 'Code', label: 'Code', isRequired: true, txtCtrl: _pmc.codeCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          SizedBox(
            width: screenWidth * 0.9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFieldWidget(
                    hintText: 'Bar Code',
                    label: 'Bar Code',
                    isRequired: true,
                    txtCtrl: _pmc.barCodeCtrl,
                    secret: false,
                    heightFactor: 0.055,
                    widthFactor: 0.791,
                    inputType: TextInputType.text),
                IconButtonWidget(
                    iconSize: screenWidth * 0.07,
                    imagePath: '',
                    function: () {
                      _pmc.popUpBarCodeScanner(context, screenWidth, screenHeight);
                    },
                    iconData: Icons.qr_code_scanner,
                    isIcon: true),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          GetBuilder<ProductManageController>(
            builder: (pmc) => DropDownButtonWidget(items: const [
              "",
              "Beverage",
              'Snack',
              'Biscuits',
              "House Hold",
              'Fruit',
              'Vegetable',
              'Dairy',
              'Drug',
              'Chemical',
              'Fabric',
              'Cloths',
              'Electronic',
              'Electric',
              'Common'
            ], label: 'Category', isRequired: true, selectData: selectCategory, heightFactor: 0.057, widthFactor: 0.9, valveChoose: _pmc.category),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          GetBuilder<ProductManageController>(
            builder: (pmc) => DropDownButtonWidget(
                items: const ["", "Packet", 'Item', 'Bottle', 'Reel'],
                label: 'Package Type',
                isRequired: true,
                selectData: selectPackageType,
                heightFactor: 0.057,
                widthFactor: 0.9,
                valveChoose: _pmc.packageType),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          GetBuilder<ProductManageController>(
            builder: (pmc) => DropDownButtonWidget(
                items: const ["", "Common"], label: 'Brand', isRequired: true, selectData: selectBrand, heightFactor: 0.057, widthFactor: 0.9, valveChoose: _pmc.brandName),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          GetBuilder<ProductManageController>(
            builder: (pmc) => DropDownButtonWidget(
                items: const ["Active", "Deactivate"],
                label: 'Status',
                isRequired: true,
                selectData: selectStatus,
                heightFactor: 0.057,
                widthFactor: 0.9,
                valveChoose: _pmc.status),
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          FlatButtonWidget(
            title: 'Add Product',
            function: () {
              _pmc.createProduct(context, screenWidth, screenHeight);
            },
            heightFactor: 0.065,
            widthFactor: 0.9,
            color: themeData.buttonTheme.colorScheme!.primary,
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
        ],
      ),
    );
  }
}
