import 'package:flutter/material.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_path.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';

Container filterWidget(
    {required Size size, required VoidCallback onTapFilter}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size.width * numD055),
      border: Border.all(
        color: Colors.blue,
        width: 1.3,
      ),
    ),
    child: Material(
      color: CommonColors.transparentColor,
      child: InkWell(
        onTap: onTapFilter,
        borderRadius: BorderRadius.circular(size.width * numD055),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * numD01),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: size.width * numD015),
              Image.asset(
                '${CommonPath.iconPath}ic_filter.png',
                height: size.width * numD03,
                color: CommonColors.appThemeColor,
              ),
              SizedBox(width: size.width * numD015),
              CommonText(
                title: filtersText,
                fontSize: size.width * numD03,
                fontWeight: FontWeight.w500,
                color: CommonColors.appThemeColor,
              ),
              SizedBox(width: size.width * numD015),
            ],
          ),
        ),
      ),
    ),
  );
}
