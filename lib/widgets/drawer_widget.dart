import 'package:flutter/material.dart';

import '../config/drawer_item.dart';
import '../data/seller_drawer_items.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key, required this.onSelectedItem}) : super(key: key);

  final ValueChanged<DrawerItem> onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildDrawerItems(context),
          ],
        ),
      ),
    );
  }

  buildDrawerItems(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView(
        children: SellerDrawerItems.all
            .map((item) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: Icon(item.icon, color: Theme.of(context).iconTheme.color),
                  title: Text(item.title, style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 16)),
                  onTap: () => onSelectedItem(item),
                ))
            .toList(),
      ),
    );
  }
}
