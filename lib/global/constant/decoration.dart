import 'package:eisteintaste/global/constant/colors.dart';
import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:flutter/material.dart';

InputDecoration kInputDecoration(String label, IconData icon, {Color? iconColor}) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(fontSize: Dimensions.font14),
    prefixIcon: Icon(icon, color: iconColor ?? AppColors.mainColor),
    contentPadding: EdgeInsets.symmetric(horizontal:Dimensions.height10, vertical: Dimensions.width10),
    border: const OutlineInputBorder(
        borderSide: BorderSide.none
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}

InputDecoration kInputDecorationDescription(String label, IconData icon, {Color? iconColor}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: iconColor ?? AppColors.mainColor),
    contentPadding: EdgeInsets.symmetric(horizontal:Dimensions.height10, vertical: Dimensions.width20),
    border: const OutlineInputBorder(
        borderSide: BorderSide.none
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}
Material buildMaterialDecoration<T extends Widget>(T child, {double? borderRadius, double? sizeMax, double? heightElevation}) {
  if (borderRadius == null) {
    borderRadius = Dimensions.border10;
  }
  return Material(
    elevation: heightElevation??Dimensions.height5,
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    shadowColor: Colors.white,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
      child: child,
    ),
  );
}


TextButton kTextButton(String label, Function onPressed, {Color? backgroundColor, double? fontSize, 
  double? borderRadius, double?  paddingVertical, double? paddingHorizontal}) {

  return TextButton(
    onPressed: () => onPressed(),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => (backgroundColor ?? AppColors.mainColor)),
      padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical: paddingVertical ?? Dimensions.height10, horizontal: paddingHorizontal ?? Dimensions.height15)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimensions.radius20)
        )
      ),
    ),
    child: bigText(label, color: Colors.white, size: fontSize ?? Dimensions.font26)
  );
}

Row kLoginOrRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      smallText(text, size: Dimensions.font18, color: Colors.white.withOpacity(0.3)),
      GestureDetector(
        child: bigText(label, size: Dimensions.font18, weight: FontWeight.bold, color: Colors.white.withOpacity(0.5)),
        onTap: () => onTap(),
      )
    ],
  );
}
