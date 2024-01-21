import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../api/rest/api_client.dart';
import '../../config/control_values.dart';
import '../../controllers/user/store_add_controller.dart';
import '../../models/album.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/ltw_add_store.dart';
import '../../widgets/text_field_widget.dart';

class AddStoreTab extends StatelessWidget {
  AddStoreTab({Key? key}) : super(key: key);

  //static const routeName = '/store_add_screen';

  final StoreAddController sac = Get.put(StoreAddController());
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _contactCtrl = TextEditingController();
  Logger logger = Logger(filter: null);
  final apiClient = ApiClient();

  String selectedContactType = 'Mobile';
  String selectedStoreType = 'Whole Sale';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    sac.getInfo().remove('');

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Material(
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
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            TextFieldWidget(
                hintText: 'Name', label: 'Name', isRequired: true, txtCtrl: _nameCtrl, secret: false, heightFactor: 0.055, widthFactor: 0.9, inputType: TextInputType.name),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            TextFieldWidget(
                hintText: 'Address',
                label: 'Address',
                isRequired: true,
                txtCtrl: _addressCtrl,
                secret: true,
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
                txtCtrl: _locationCtrl,
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
                  GetBuilder<StoreAddController>(
                    builder: (sac) => DropDownButtonWidget(
                        items: const ["Mobile", "Work", "Fax", "Website", "Email"],
                        label: 'Contact Info',
                        isRequired: true,
                        selectData: selectContactType,
                        heightFactor: 0.057,
                        widthFactor: 0.3,
                        valveChoose: selectedContactType),
                  ),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  TextFieldWidget(
                      hintText: '',
                      label: '',
                      isRequired: false,
                      txtCtrl: _contactCtrl,
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
                            sac.addItem('$selectedContactType : ${_contactCtrl.text.toString()}');
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
            GetBuilder<StoreAddController>(
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
            GetBuilder<StoreAddController>(
              builder: (sac) => DropDownButtonWidget(
                  items: const ["Whole Sale", "Retail Sale"],
                  label: 'Type',
                  isRequired: true,
                  selectData: selectStoreType,
                  heightFactor: 0.057,
                  widthFactor: 0.9,
                  valveChoose: selectedStoreType),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            FlatButtonWidget(
              title: 'Add',
              function: () {},
              heightFactor: 0.065,
              widthFactor: 0.9,
              color: themeData.buttonTheme.colorScheme!.primary,
            ),
            FutureBuilder<Album?>(
                future: apiClient.fetchAlbum(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    logger.i(snapshot.data!.title);
                    return Text(snapshot.data!.title);
                  }
                  return const Text('');
                }),
            SizedBox(
              height: screenHeight * 0.04,
            ),
          ],
        ),
      ),
    );
  }

  void selectContactType(String data) {
    selectedContactType = data;
    sac.setContactType(data);
  }

  void removeContactInfo(int index) {
    Logger().i('Remove : ');
    if (sac.getInfo().isNotEmpty) {
      sac.removeItem(index);
    }
  }

  void selectStoreType(String data) {
    selectedStoreType = data;
    sac.setStoreType(data);
  }

  void fetchData() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
