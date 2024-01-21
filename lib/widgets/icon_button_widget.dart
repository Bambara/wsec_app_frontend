import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({Key? key, required this.imagePath, required this.function, required this.iconData, required this.isIcon, required this.iconSize}) : super(key: key);

  final String imagePath;
  final VoidCallback function;
  final IconData iconData;
  final bool isIcon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      icon: isIcon
          ? Icon(iconData)
          : Image(
              image: AssetImage(imagePath),
              color: Theme.of(context).iconTheme.color,
            ),
      onPressed: () => function(),
    );
  }
}
