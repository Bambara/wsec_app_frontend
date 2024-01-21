import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/store/owner/member_home_controller.dart';
import '../../models/store_member.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/gtw_store_product.dart';
import '../../widgets/text_field_widget.dart';

class MemberHomeTab extends StatelessWidget {
  MemberHomeTab({Key? key}) : super(key: key);

  final TextEditingController _nameCtrl = TextEditingController();
  final mhc = Get.put(MemberHomeController());

  String selectedMemberType = 'All';
  List<StoreMember> storeMember = [
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
    StoreMember('0001', 'Employee', 'Active', '14:00', '002', '003'),
  ];

  final faker = Faker();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextFieldWidget(
            hintText: 'Name', label: 'Name', isRequired: true, txtCtrl: _nameCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        GetBuilder<MemberHomeController>(
          builder: (mhc) => DropDownButtonWidget(
              items: const ["All", "Customer", "Employees", "Suppliers"],
              label: 'Type',
              isRequired: true,
              selectData: selectMemberType,
              heightFactor: 0.057,
              widthFactor: 0.9,
              valveChoose: selectedMemberType),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Expanded(
          child: GridView.builder(
            addAutomaticKeepAlives: false,
            cacheExtent: 100,
            itemCount: storeMember.length,
            itemBuilder: (context, index) {
              return GTWStoreProduct(
                navigate: () {},
                removeItem: (int) {},
                index: index,
                storeProduct: [],
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 6.0, mainAxisSpacing: 6.0),
          ),
        ),
      ],
    );
  }

  void selectMemberType(String data) {
    selectedMemberType = data;
    mhc.memberType = selectedMemberType;
    // Logger().i(value);
  }
}
