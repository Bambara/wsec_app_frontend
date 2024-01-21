import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:wsec_app_frontend/views/seller/seller_drawer_screen.dart';

import '../../controllers/store/owner/member_manage_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class AddMemberTab extends StatelessWidget {
  AddMemberTab({Key? key}) : super(key: key);

  //static const routeName = '/add_member_screen';

  final MemberManageController mmc = Get.put(MemberManageController());
  final TextEditingController _nameCtrl = TextEditingController();
  Logger logger = Logger(filter: null);

  String store = '';
  String memberType = 'Customer';
  String memberStatus = 'Active';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    /*return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.iconTheme.color,
            floating: true,
            snap: true,
            title: const Text('Member Register'),
            centerTitle: true,
          )
        ],
        body: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            TextFieldWidget(
                hintText: 'User Name',
                label: 'User Name',
                isRequired: true,
                txtCtrl: _nameCtrl,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.name),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            TextFieldWidget(
                hintText: 'Name', label: 'Name', isRequired: true, txtCtrl: _nameCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GetBuilder<MemberManageController>(
              builder: (mmc) => DropDownButtonWidget(
                  items: const ["Customer", "Employees", "Suppliers"],
                  label: 'Type',
                  isRequired: true,
                  selectData: selectMemberType,
                  heightFactor: 0.057,
                  widthFactor: 0.9,
                  valveChoose: memberType),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            GetBuilder<MemberManageController>(
              builder: (mmc) => DropDownButtonWidget(
                  items: const ["Active", "Deactivate"],
                  label: 'Status',
                  isRequired: true,
                  selectData: selectMemberStatus,
                  heightFactor: 0.057,
                  widthFactor: 0.9,
                  valveChoose: memberStatus),
            ),
          ],
        ),
      ),
    );*/

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.02,
        ),
        GetBuilder<MemberManageController>(
          builder: (mmc) => DropDownButtonWidget(
              items: const ["", "Store 02", "Store 03"], label: 'Store', isRequired: true, selectData: selectStore, heightFactor: 0.057, widthFactor: 0.9, valveChoose: store),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextFieldWidget(
            hintText: 'User Name',
            label: 'User Name',
            isRequired: true,
            txtCtrl: _nameCtrl,
            secret: false,
            heightFactor: 0.055,
            widthFactor: 0.9,
            inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextFieldWidget(
            hintText: 'Name', label: 'Name', isRequired: true, txtCtrl: _nameCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        GetBuilder<MemberManageController>(
          builder: (mmc) => DropDownButtonWidget(
              items: const ["Customer", "Employees", "Suppliers"],
              label: 'Type',
              isRequired: true,
              selectData: selectMemberType,
              heightFactor: 0.057,
              widthFactor: 0.9,
              valveChoose: memberType),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        GetBuilder<MemberManageController>(
          builder: (mmc) => DropDownButtonWidget(
              items: const ["Active", "Deactivate"],
              label: 'Status',
              isRequired: true,
              selectData: selectMemberStatus,
              heightFactor: 0.057,
              widthFactor: 0.9,
              valveChoose: memberStatus),
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        FlatButtonWidget(
          title: 'Add',
          function: () {
            Get.to(() => SellerDrawerScreen());
          },
          heightFactor: 0.065,
          widthFactor: 0.9,
          color: themeData.buttonTheme.colorScheme!.primary,
        ),
      ],
    );
  }

  void selectStore(String data) {
    store = data;
    mmc.store = store;
    //Logger().i(mmc.memberType);
  }

  void selectMemberType(String data) {
    memberType = data;
    mmc.memberType = memberType;
    //Logger().i(mmc.memberType);
  }

  void selectMemberStatus(String data) {
    memberStatus = data;
    mmc.memberStatus = memberStatus;
    //Logger().i(mmc.memberType);
  }
}
