import 'package:flutter/material.dart';

import '../models/store_member.dart';
import 'icon_button_widget.dart';

class GtwStoreMember extends StatelessWidget {
  const GtwStoreMember({Key? key, required this.storeMember, required this.index, required this.function, required this.navigate}) : super(key: key);

  final List<StoreMember> storeMember;
  final int index;
  final VoidCallback function;
  final VoidCallback navigate;

  void get() {
    print('Call');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: navigate,
      child: Container(
        margin: EdgeInsets.only(top: screenHeight * 0.02),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
          elevation: 5,
          shadowColor: Theme.of(context).textTheme.bodyText1?.color,
          // color: Theme.of(context).primaryColorLight,
          child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
            Container(
              // margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.purple, Colors.redAccent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenWidth * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(children: [Text(storeMember[index].id, style: const TextStyle(fontSize: 12))]),
                    ],
                  ),
                  const Divider(thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [const Text('Name :'), Text(storeMember[index].type, style: const TextStyle(fontSize: 12))])
                    ],
                  ),
                  const Divider(endIndent: 100, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [const Text('Type :'), Text(storeMember[index].status, style: const TextStyle(fontSize: 12))]),
                    ],
                  ),
                  const Divider(endIndent: 100, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [const Text('Status :'), Text(storeMember[index].status, style: const TextStyle(fontSize: 12))]),
                      Row(
                        children: [
                          IconButtonWidget(
                            imagePath: 'assets/images/create.png',
                            function: function,
                            isIcon: true,
                            iconData: Icons.edit_note,
                            iconSize: screenWidth * 0.06,
                          ),
                          IconButtonWidget(
                            imagePath: 'assets/images/delete_sweep.png',
                            function: function,
                            isIcon: true,
                            iconData: Icons.delete,
                            iconSize: screenWidth * 0.06,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -(screenHeight * 0.03),
              left: screenHeight * 0.07,
              child: CircleAvatar(
                radius: screenHeight * 0.06,
                backgroundImage: const AssetImage("assets/images/users_duo_black.png"),
                backgroundColor: Colors.grey.shade600,
                child: Text(
                  'Player'[0].toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
