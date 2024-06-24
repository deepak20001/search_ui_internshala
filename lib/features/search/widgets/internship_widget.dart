// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:search_ui_internshala/features/search/controller/search_cubit.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_models.dart';
import 'package:search_ui_internshala/utils/common_path.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_button.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';

Column internshipWidget({
  required Size size,
  required int index,
  required SearchCubit cubitData,
  required InternshipMetaModel item,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * numD038),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0) SizedBox(height: size.width * numD025),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.width * numD01,
                  horizontal: size.width * numD015),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * numD01),
                border: Border.all(
                  color: CommonColors.borderColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SvgPicture.asset(
                    '${CommonPath.iconPath}ic_hiring.svg',
                  ),
                  SizedBox(width: size.width * numD015),
                  CommonText(
                    title: activelyHiringText,
                    fontSize: size.width * numD03,
                    fontWeight: FontWeight.w600,
                    color: CommonColors.blackColor.withOpacity(0.6),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.width * numD02),
            CommonText(
              title: item.profileName!,
              fontSize: size.width * numD045,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: size.width * numD02),
            CommonText(
              title: item.companyName!,
              fontSize: size.width * numD035,
              color: CommonColors.greyTextColor,
            ),
            SizedBox(height: size.width * numD04),
            Row(
              children: [
                SvgPicture.asset('${CommonPath.iconPath}ic_location.svg'),
                SizedBox(width: size.width * numD01),
                CommonText(
                  title: item.locationName!,
                  fontSize: size.width * numD035,
                ),
              ],
            ),
            SizedBox(height: size.width * numD04),
            Row(
              children: [
                SvgPicture.asset('${CommonPath.iconPath}ic_start.svg'),
                SizedBox(width: size.width * numD01),
                CommonText(
                  title: 'Starts Immediately',
                  fontSize: size.width * numD035,
                ),
                SizedBox(width: size.width * numD03),
                Icon(
                  Icons.calendar_today_rounded,
                  size: size.width * numD035,
                ),
                SizedBox(width: size.width * numD01),
                CommonText(
                  title: item.duration!,
                  fontSize: size.width * numD035,
                ),
              ],
            ),
            SizedBox(height: size.width * numD04),
            Row(
              children: [
                SvgPicture.asset('${CommonPath.iconPath}ic_money.svg'),
                SizedBox(width: size.width * numD01),
                CommonText(
                  title: item.stipend!,
                  fontSize: size.width * numD035,
                ),
              ],
            ),
            SizedBox(height: size.width * numD04),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: size.width * numD01,
                horizontal: size.width * numD013,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * numD01),
                color: CommonColors.greyTextColor.withOpacity(0.15),
              ),
              child: CommonText(
                title: item.employmentType!,
                fontSize: size.width * numD03,
              ),
            ),
            SizedBox(height: size.width * numD035),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: size.width * numD01,
                horizontal: size.width * numD013,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * numD01),
                color: CommonColors.greyTextColor.withOpacity(0.15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('${CommonPath.iconPath}ic_ago.svg'),
                  CommonText(
                    title: ' ${item.postedByLabel!}',
                    fontSize: size.width * numD03,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: size.width * numD01),
      Divider(
        thickness: size.width * numD003,
        color: CommonColors.borderColor,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * numD038),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              splashColor: CommonColors.whiteColor,
              highlightColor: CommonColors.whiteColor,
              onTap: () {},
              child: CommonText(
                title: 'View Details',
                fontSize: size.width * numD038,
                color: CommonColors.appThemeColor,
              ),
            ),
            SizedBox(width: size.width * numD03),
            CommonButton(
              onTap: () {},
              buttonText: 'Apply now',
            ),
          ],
        ),
      ),
      SizedBox(height: size.width * numD018),
    ],
  );
}
