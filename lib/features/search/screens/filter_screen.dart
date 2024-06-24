import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_ui_internshala/features/search/controller/search_cubit.dart';
import 'package:search_ui_internshala/features/search/controller/search_state.dart';
import 'package:search_ui_internshala/features/search/screens/profile_or_city_screen.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_enums.dart';
import 'package:search_ui_internshala/utils/common_routes.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_button.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';
import 'package:search_ui_internshala/features/search/widgets/app_bar_widget.dart';
import 'package:search_ui_internshala/features/search/widgets/pop_up_menu_widget.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key, required this.filterCubit});
  final SearchCubit filterCubit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: filterCubit,
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          var cubitData = context.read<SearchCubit>();
          return Scaffold(
            /// appBar
            appBar: appBarWidget(
              context: context,
              size: size,
              titleText: 'Filters',
              onSearchTap: () {},
              isSearchVisible: false,
              isBackButtonVisible: true,
              isSavedVisible: true,
              isChatVisible: true,
              isButtonsVisible: false,
              onTapClearAll: () {},
              onTapApply: () {},
            ),

            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * numD038)
                  .copyWith(bottom: size.width * numD03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: size.width * numD12,
                      child: CommonButton(
                        onTap: () {
                          cubitData.clearAllFunc(profileText);
                          cubitData.clearAllFunc(cityText);
                          cubitData.updateSelectedDurationFunc(-1);
                        },
                        buttonText: 'Clear all',
                        buttonColor: CommonColors.whiteColor,
                        borderColor: CommonColors.appThemeColor,
                        buttonTextColor: CommonColors.appThemeColor,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * numD035),
                  Expanded(
                    child: SizedBox(
                      height: size.width * numD12,
                      child: CommonButton(
                        onTap: () {
                          cubitData.applyAllFiltersFunc();
                        },
                        buttonText: 'Apply',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// body
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * numD038),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.width * numD03),
                  CommonText(
                    title: 'PROFILE',
                    fontSize: size.width * numD035,
                    color: CommonColors.greyTextColorTwo,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: size.width * numD02),
                  if (state.selectedProfileList!.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.only(top: size.width * numD01),
                      child: SizedBox(
                        height: size.width * numD075,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: state.selectedProfileList!.length,
                            itemBuilder: (context, index) {
                              var item = state.selectedProfileList![index];
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
                                        cubitData.updateProfileFilterListFunc(
                                          index: index,
                                          type: SelectionTypeEnum.closeIcon,
                                        );
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
                    SizedBox(height: size.width * numD02),
                  ],
                  GestureDetector(
                    onTap: () {
                      cubitData.initialValuesForSelectedListFunc(profileText);
                      Routes.push(
                          widget: ProfileOrCityScreen(
                            screenName: profileText,
                            searchCubit: cubitData,
                          ),
                          context: context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: CommonColors.appThemeColor,
                        ),
                        SizedBox(width: size.width * numD015),
                        CommonText(
                          title: 'Add profile',
                          fontSize: size.width * numD035,
                          color: CommonColors.appThemeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.width * numD04),
                  CommonText(
                    title: 'CITY',
                    fontSize: size.width * numD035,
                    color: CommonColors.greyTextColorTwo,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: size.width * numD02),
                  if (state.selectedCityList!.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.only(top: size.width * numD01),
                      child: SizedBox(
                        height: size.width * numD075,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: state.selectedCityList!.length,
                            itemBuilder: (context, index) {
                              var item = state.selectedCityList![index];
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
                                        cubitData.updateCityFilterListFunc(
                                          index: index,
                                          type: SelectionTypeEnum.closeIcon,
                                        );
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
                    SizedBox(height: size.width * numD02),
                  ],
                  GestureDetector(
                    onTap: () {
                      cubitData.initialValuesForSelectedListFunc(cityText);
                      Routes.push(
                          widget: ProfileOrCityScreen(
                            screenName: cityText,
                            searchCubit: cubitData,
                          ),
                          context: context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: CommonColors.appThemeColor,
                        ),
                        SizedBox(width: size.width * numD015),
                        CommonText(
                          title: 'Add city',
                          fontSize: size.width * numD035,
                          color: CommonColors.appThemeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.width * numD04),
                  CommonText(
                    title: 'MAXIMUM DURATION IN MONTHS',
                    fontSize: size.width * numD035,
                    color: CommonColors.greyTextColorTwo,
                  ),
                  SizedBox(height: size.width * numD03),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      var cubitData = context.read<SearchCubit>();
                      return Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          popUpMenuWidget(
                            size: size,
                            menuItems: [1, 2, 3, 4, 5, 6],
                            onSelected: (val) {
                              cubitData.updateSelectedDurationFunc(val);
                            },
                            cubitData: cubitData,
                          ),
                          state.selectedDuration != -1
                              ? Positioned(
                                  left: size.width * numD035,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * numD02,
                                      vertical: size.width * numD015,
                                    ),
                                    decoration: BoxDecoration(
                                      color: CommonColors.appThemeColor,
                                      borderRadius: BorderRadius.circular(
                                          size.width * numD01),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CommonText(
                                          title: state.selectedDuration == 1
                                              ? '${state.selectedDuration} month'
                                              : '${state.selectedDuration} months',
                                          fontSize: size.width * numD035,
                                          color: CommonColors.whiteColor,
                                        ),
                                        SizedBox(width: size.width * numD01),
                                        InkWell(
                                          onTap: () {
                                            cubitData
                                                .updateSelectedDurationFunc(-1);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: CommonColors.whiteColor,
                                            size: size.width * numD045,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
