import 'package:eisteintaste/global/widgets/text.dart';
import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:flutter/material.dart';

Row iconAndTextWidget(String label, IconData icon, Color? iconColor,
    {double? size, Color? textColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: iconColor,
        size: size ?? Dimensions.iconSize24,
      ),
      SizedBox(width: 5),
      smallText(label, color: textColor),
    ],
  );
}
