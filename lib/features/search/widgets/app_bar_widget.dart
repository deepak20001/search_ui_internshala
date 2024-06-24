import 'package:flutter/material.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_path.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_button.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';

AppBar appBarWidget({
  required BuildContext context,
  required Size size,
  required String titleText,
  required VoidCallback onSearchTap,
  required bool isSearchVisible,
  required bool isBackButtonVisible,
  required bool isSavedVisible,
  required bool isChatVisible,
  required bool isButtonsVisible,
  required VoidCallback onTapClearAll,
  required VoidCallback onTapApply,
}) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    titleSpacing: size.width * numD01,
    leading: isBackButtonVisible
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * numD045),
            child: Image.asset(
              '${CommonPath.iconPath}ic_menu.png',
            ),
          ),
    title: CommonText(
      title: titleText,
      fontSize: size.width * numD048,
      fontWeight: FontWeight.bold,
    ),
    actions: [
      if (isButtonsVisible)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              splashColor: CommonColors.whiteColor,
              highlightColor: CommonColors.whiteColor,
              onTap: onTapClearAll,
              child: CommonText(
                title: 'Clear all',
                fontSize: size.width * numD038,
                color: CommonColors.appThemeColor,
              ),
            ),
            SizedBox(width: size.width * numD03),
            CommonButton(
              onTap: onTapApply,
              buttonText: 'Apply',
            ),
          ],
        ),
      if (isSearchVisible)
        IconButton(
          padding: EdgeInsets.all(size.width * numD025),
          constraints: const BoxConstraints(),
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onSearchTap,
          icon: Image.asset(
            '${CommonPath.iconPath}ic_search.png',
            height: size.width * numD045,
          ),
        ),
      if (isSavedVisible)
        IconButton(
          padding: EdgeInsets.all(size.width * numD025),
          constraints: const BoxConstraints(),
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          icon: Image.asset(
            '${CommonPath.iconPath}ic_save.png',
            height: size.width * numD045,
          ),
        ),
      IconButton(
        padding: EdgeInsets.all(size.width * numD025),
        constraints: const BoxConstraints(),
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {},
        icon: Image.asset(
          '${CommonPath.iconPath}ic_notification.png',
          height: size.width * numD045,
        ),
      ),
      if (isChatVisible)
        IconButton(
          padding: EdgeInsets.all(size.width * numD025),
          constraints: const BoxConstraints(),
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {},
          icon: Image.asset(
            '${CommonPath.iconPath}ic_chat.png',
            height: size.width * numD045,
          ),
        ),
      SizedBox(width: size.width * numD015),
    ],
  );
}
