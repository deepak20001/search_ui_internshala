import 'package:flutter/material.dart';
import 'package:search_ui_internshala/features/search/controller/search_cubit.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_textformfield.dart';

Widget popUpMenuWidget({
  required Size size,
  required List<int> menuItems,
  required Function(int) onSelected,
  required SearchCubit cubitData,
}) {
  return PopupMenuButton<int>(
    color: CommonColors.whiteColor,
    surfaceTintColor: CommonColors.whiteColor,
    offset: Offset(0, size.width * numD15),
    constraints: const BoxConstraints(
      minWidth: double.infinity,
    ),
    onSelected: onSelected,
    itemBuilder: (BuildContext context) {
      return menuItems.map((int value) {
        return PopupMenuItem<int>(
          value: value,
          child: CommonText(
            title: value.toString(),
            fontSize: size.width * numD03,
          ),
        );
      }).toList();
    },
    child: AbsorbPointer(
      absorbing: true,
      child: CommonTextFormField(
        size: size,
        isRead: true,
        hintText: '',
        labelText: 'Choose Duration',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: CommonColors.appThemeColor,
        ),
      ),
    ),
  );
}
