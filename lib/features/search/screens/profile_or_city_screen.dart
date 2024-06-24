import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_ui_internshala/features/search/controller/search_cubit.dart';
import 'package:search_ui_internshala/features/search/controller/search_state.dart';
import 'package:search_ui_internshala/features/search/widgets/app_bar_widget.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_enums.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_textformfield.dart';

class ProfileOrCityScreen extends StatelessWidget {
  const ProfileOrCityScreen(
      {super.key, required this.screenName, required this.searchCubit});
  final String screenName;
  final SearchCubit searchCubit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: searchCubit,
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          var cubitData = context.read<SearchCubit>();
          return Scaffold(
            /// appbar
            appBar: appBarWidget(
              context: context,
              size: size,
              titleText: screenName,
              onSearchTap: () {},
              isSearchVisible: false,
              isBackButtonVisible: true,
              isSavedVisible: false,
              isChatVisible: false,
              isButtonsVisible: true,
              onTapClearAll: () {
                cubitData.clearAllFunc(screenName);
              },
              onTapApply: () {
                cubitData.updateFinalSelctedListFunc(screenName);
                Navigator.pop(context);
              },
            ),

            /// body
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * numD038),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.width * numD015),
                  CommonTextFormField(
                    autoFocus: true,
                    controller: screenName == profileText
                        ? cubitData.profileController
                        : cubitData.cityController,
                    size: size,
                    hintText: '',
                    labelText: 'Search ${screenName.toLowerCase()}',
                    onChange: (val) {
                      if (screenName == profileText) {
                        cubitData.updateProfileFilterListFunc(
                            index: -1, type: SelectionTypeEnum.textFormField);
                      } else {
                        cubitData.updateCityFilterListFunc(
                            index: -1, type: SelectionTypeEnum.textFormField);
                      }
                    },
                  ),
                  SizedBox(height: size.width * numD01),
                  if ((screenName == profileText &&
                          state.dummyProfileSelectedList!.isNotEmpty) ||
                      (screenName == cityText &&
                          state.dummyCitySelectedList!.isNotEmpty))
                    Padding(
                      padding: EdgeInsets.only(top: size.width * numD01),
                      child: SizedBox(
                        height: size.width * numD075,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: screenName == profileText
                                ? state.dummyProfileSelectedList!.length
                                : state.dummyCitySelectedList!.length,
                            itemBuilder: (context, index) {
                              var item = screenName == profileText
                                  ? state.dummyProfileSelectedList![index]
                                  : state.dummyCitySelectedList![index];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * numD02,
                                  vertical: size.width * numD015,
                                ),
                                margin:
                                    EdgeInsets.only(right: size.width * numD01),
                                decoration: BoxDecoration(
                                  color: CommonColors.appThemeColor,
                                  borderRadius: BorderRadius.circular(
                                      size.width * numD01),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CommonText(
                                      title: item,
                                      fontSize: size.width * numD035,
                                      color: CommonColors.whiteColor,
                                    ),
                                    SizedBox(width: size.width * numD01),
                                    InkWell(
                                      onTap: () {
                                        if (screenName == profileText) {
                                          cubitData.updateProfileFilterListFunc(
                                              index: index,
                                              type:
                                                  SelectionTypeEnum.closeIcon);
                                        } else {
                                          cubitData.updateCityFilterListFunc(
                                              index: index,
                                              type:
                                                  SelectionTypeEnum.closeIcon);
                                        }
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: CommonColors.whiteColor,
                                        size: size.width * numD045,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  (screenName == profileText &&
                              state.filteredProfileList!.isEmpty) ||
                          (screenName == cityText &&
                              state.filteredCityList!.isEmpty)
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.width * numD045),
                            child: CommonText(
                              title: 'No results found!',
                              fontSize: size.width * numD04,
                              color: CommonColors.greyTextColor,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: screenName == profileText
                                  ? state.filteredProfileList!.length
                                  : state.filteredCityList!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  splashColor: CommonColors.whiteColor,
                                  highlightColor: CommonColors.whiteColor,
                                  onTap: () {
                                    if (screenName == profileText) {
                                      cubitData.updateProfileFilterListFunc(
                                        index: index,
                                        type: SelectionTypeEnum.checkBox,
                                      );
                                    } else {
                                      cubitData.updateCityFilterListFunc(
                                        index: index,
                                        type: SelectionTypeEnum.checkBox,
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      AbsorbPointer(
                                        absorbing: true,
                                        child: Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return CommonColors.appThemeColor;
                                            }
                                            return CommonColors.whiteColor;
                                          }),
                                          value: screenName == profileText
                                              ? state
                                                  .filteredProfileList![index]
                                                  .isSelected
                                              : state.filteredCityList![index]
                                                  .isSelected,
                                          onChanged: (val) {},
                                        ),
                                      ),
                                      CommonText(
                                        title: screenName == profileText
                                            ? state.filteredProfileList![index]
                                                .profileName
                                            : state.filteredCityList![index]
                                                .cityName,
                                        fontSize: size.width * numD035,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
