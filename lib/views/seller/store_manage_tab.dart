import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:logger/logger.dart';

import '../../config/control_values.dart';
import '../../controllers/store/owner/store_manage_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/ltw_add_store.dart';
import '../../widgets/text_field_widget.dart';

class StoreManageTab extends StatelessWidget {
  StoreManageTab({Key? key}) : super(key: key);

  //static const routeName = '/store_add_screen';

  final _smc = Get.put(StoreManageController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    _smc.getInfo().remove('');

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GetBuilder<StoreManageController>(
              builder: (controller) => DropDownButtonWidget(
                  items: controller.storeNames,
                  label: 'Store',
                  isRequired: true,
                  selectData: selectStore,
                  heightFactor: 0.057,
                  widthFactor: 0.9,
                  valveChoose: controller.store),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GestureDetector(
              onTap: () {
                _smc.pickProfileImage();
              },
              child: _smc.logoUrl == ''
                  ? GetBuilder<StoreManageController>(
                      builder: (controller) => _smc.isSelected == false
                          ? GFImageOverlay(
                              image: const AssetImage('assets/images/company_logo.jpg'),
                              width: screenWidth * 0.3,
                              height: screenWidth * 0.3,
                              borderRadius: BorderRadius.circular(screenWidth * 0.05),
                              boxFit: BoxFit.cover,
                            )
                          : GFImageOverlay(
                              image: FileImage(_smc.profileImage),
                              width: screenWidth * 0.3,
                              height: screenWidth * 0.3,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(screenWidth * 0.05),
                              boxFit: BoxFit.cover,
                            ),
                    )
                  : GetBuilder<StoreManageController>(
                      builder: (controller) => GFImageOverlay(
                            image: NetworkImage(_smc.logoUrl),
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            borderRadius: BorderRadius.circular(screenWidth * 0.05),
                            boxFit: BoxFit.cover,
                          )),
            ),
            /*Material(
                  shadowColor: Colors.grey,
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  elevation: 2.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // type: MaterialType.transparency,
                  child: Image.asset(
                    'assets/images/company_logo.jpg',
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.25,
                    fit: BoxFit.fill,
                  ),
                ),*/
            SizedBox(
              height: screenHeight * 0.02,
            ),
            TextFieldWidget(
                hintText: 'Name',
                label: 'Name',
                isRequired: true,
                txtCtrl: _smc.nameCtrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.name),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            TextFieldWidget(
                hintText: 'Address Line 01',
                label: 'Address Line 01',
                isRequired: true,
                txtCtrl: _smc.addressLine01Ctrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.streetAddress),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            TextFieldWidget(
                hintText: 'Address Line 02',
                label: 'Address Line 02',
                isRequired: true,
                txtCtrl: _smc.addressLine02Ctrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.streetAddress),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            TextFieldWidget(
                hintText: 'City',
                label: 'City',
                isRequired: true,
                txtCtrl: _smc.cityCtrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.streetAddress),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            TextFieldWidget(
                hintText: 'State',
                label: 'State',
                isRequired: true,
                txtCtrl: _smc.stateCtrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.streetAddress),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            TextFieldWidget(
                hintText: 'Country',
                label: 'Country',
                isRequired: true,
                txtCtrl: _smc.countryCtrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.streetAddress),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            TextFieldWidget(
                hintText: 'Zip Code',
                label: 'Zip Code',
                isRequired: false,
                txtCtrl: _smc.zipCodeCtrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.streetAddress),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            TextFieldWidget(
                hintText: 'Location',
                label: 'Location',
                isRequired: true,
                txtCtrl: _smc.locationCtrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.number),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GetBuilder<StoreManageController>(
                    builder: (sac) => DropDownButtonWidget(
                        items: const ["Mobile", "Work", "Fax", "Website", "Email"],
                        label: 'Contact Info',
                        isRequired: true,
                        selectData: selectContactType,
                        heightFactor: 0.057,
                        widthFactor: 0.3,
                        valveChoose: _smc.contactType),
                  ),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  TextFieldWidget(
                      hintText: '',
                      label: '',
                      isRequired: false,
                      txtCtrl: _smc.contactCtrl,
                      secret: false,
                      heightFactor: 0.055,
                      widthFactor: 0.47,
                      inputType: TextInputType.phone),
                  SizedBox(
                    height: screenHeight * 0.055,
                    child: Center(
                      child: IconButtonWidget(
                          iconSize: screenWidth * 0.05,
                          imagePath: '',
                          function: () {
                            _smc.addItem('${_smc.contactType} : ${_smc.contactCtrl.text.toString()}');
                          },
                          iconData: Icons.add_circle,
                          isIcon: true),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            GetBuilder<StoreManageController>(
              builder: (sac) => Container(
                height: screenHeight * 0.15,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(ControlValues.boarderRadius)),
                ),
                child: ListView.builder(
                  addAutomaticKeepAlives: false,
                  cacheExtent: 100,
                  // itemCount: itemList.length,
                  itemCount: sac.getInfo().length,
                  itemBuilder: (context, index) => ListItemWidget(
                    itemList: sac.getInfo(),
                    index: index,
                    removeItem: removeContactInfo,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            GetBuilder<StoreManageController>(
              builder: (sac) => DropDownButtonWidget(
                  items: const ["Whole Sale", "Retail Sale"],
                  label: 'Type',
                  isRequired: true,
                  selectData: selectStoreType,
                  heightFactor: 0.057,
                  widthFactor: 0.9,
                  valveChoose: _smc.storeType),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            FlatButtonWidget(
              title: 'Add',
              function: () {
                _smc.createStore(context, screenWidth, screenHeight);
              },
              heightFactor: 0.065,
              widthFactor: 0.9,
              color: themeData.buttonTheme.colorScheme!.primary,
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
          ],
        ),
      ),
    );
  }

  void selectContactType(String data) {
    _smc.contactType = data;
  }

  void removeContactInfo(int index) {
    Logger().i('Remove : ');
    if (_smc.getInfo().isNotEmpty) {
      _smc.removeItem(index);
    }
  }

  void selectStoreType(String data) {
    _smc.storeType = data;
  }

  void selectStore(String data) {
    _smc.store = data;
    _smc.selectStore();
  }
}
