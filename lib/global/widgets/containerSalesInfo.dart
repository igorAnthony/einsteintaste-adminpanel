import 'package:eisteintaste/global/constant/dimensions.dart';
import 'package:eisteintaste/global/widgets/text.dart';
import 'package:flutter/material.dart';

Container containerSalesInfo(String title, String label){
  return Container(
    padding: EdgeInsets.only(top: Dimensions.height15),
    width: Dimensions.containerSalesInfoSizeWidth,
    height: Dimensions.containerSalesInfoSizeHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius5),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0xFFe8e8e8),
          blurRadius: Dimensions.shadowBlurRadius,
          offset: Offset(0, 5),
        ),
      ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        smallText(title, size: Dimensions.font14),
        bigText(label, size: Dimensions.font26),
        Container(),
      ],
    ),
  );
}