import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

import '../../config/control_values.dart';
import '../../controllers/user/store_add_controller.dart';
import '../../widgets/dropdown_button_widget.dart';
import '../../widgets/flat_button_widget.dart';
import '../../widgets/icon_button_widget.dart';
import '../../widgets/ltw_add_store.dart';
import '../../widgets/text_field_widget.dart';

class AddStoreScreen extends StatelessWidget {
  AddStoreScreen({Key? key}) : super(key: key);
  static const routeName = '/store_add_screen';

  final _sac = Get.put(StoreAddController());

  /*  Logger logger = Logger(filter: null);
  final apiClient = ApiClient();*/

  // final _sac = Get.put(StockAddController());

  String contactType = 'Mobile';
  String storeType = 'Whole Sale';

  void selectContactType(String data) {
    contactType = data;
    _sac.setContactType(data);
  }

  void removeContactInfo(int index) {
    //Logger().i('Remove : ');
    if (_sac.getInfo().isNotEmpty) {
      _sac.removeItem(index);
    }
  }

  void selectStoreType(String data) {
    storeType = data;
    _sac.setStoreType(data);
  }

  /*void fetchData() async {
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
  }*/

  /*  void getDataFromServer() {
    FutureBuilder<Album?>(
        future: apiClient.fetchAlbum(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            logger.i(snapshot.data!.title);
            return Text(snapshot.data!.title);
          }
          return const Text('');
        });
  }*/

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    _sac.getInfo().remove('');

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: themeData.navigationBarTheme.backgroundColor,
            foregroundColor: themeData.iconTheme.color,
            floating: true,
            snap: true,
            title: const Text('Add Store'),
            centerTitle: true,
            toolbarHeight: screenHeight * 0.06,
          )
        ],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    _sac.pickProfileImage();
                  },
                  child: GetBuilder<StoreAddController>(
                    builder: (controller) => _sac.isSelected == false
                        ? GFImageOverlay(
                            image: const AssetImage('assets/images/company_logo.jpg'),
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            borderRadius: BorderRadius.circular(screenWidth * 0.05),
                            boxFit: BoxFit.cover,
                          )
                        : GFImageOverlay(
                            image: FileImage(_sac.profileImage),
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(screenWidth * 0.05),
                            boxFit: BoxFit.cover,
                          ),
                  ),
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
                    txtCtrl: _sac.nameCtrl,
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
                    txtCtrl: _sac.addressLine01Ctrl,
                    secret: true,
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
                    txtCtrl: _sac.addressLine02Ctrl,
                    secret: true,
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
                    txtCtrl: _sac.cityCtrl,
                    secret: true,
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
                    txtCtrl: _sac.stateCtrl,
                    secret: true,
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
                    txtCtrl: _sac.countryCtrl,
                    secret: true,
                    heightFactor: 0.055,
                    widthFactor: 0.9,
                    inputType: TextInputType.streetAddress),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                TextFieldWidget(
                    hintText: 'Zip Code',
                    label: 'Zip Code',
                    isRequired: true,
                    txtCtrl: _sac.zipCodeCtrl,
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
                    txtCtrl: _sac.locationCtrl,
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
                            valveChoose: contactType),
                      ),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      TextFieldWidget(
                          hintText: '',
                          label: '',
                          isRequired: false,
                          txtCtrl: _sac.contactCtrl,
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
                                _sac.addItem('$contactType : ${_sac.contactCtrl.text.toString()}');
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
                      valveChoose: storeType),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                FlatButtonWidget(
                  title: 'Add',
                  function: () {
                    _sac.createStore();
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
        ),
      ),
    );
  }
}
