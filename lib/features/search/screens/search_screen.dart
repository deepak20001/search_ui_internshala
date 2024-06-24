import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_routes.dart';
import 'package:search_ui_internshala/utils/common_widgets.dart/common_text.dart';
import 'package:search_ui_internshala/features/search/controller/search_cubit.dart';
import 'package:search_ui_internshala/features/search/controller/search_state.dart';
import 'package:search_ui_internshala/features/search/screens/filter_screen.dart';
import 'package:search_ui_internshala/features/search/widgets/app_bar_widget.dart';
import 'package:search_ui_internshala/features/search/widgets/filter_widget.dart';
import 'package:search_ui_internshala/features/search/widgets/internship_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          var cubitData = context.read<SearchCubit>();
          return Scaffold(
            /// appBar
            appBar: appBarWidget(
              context: context,
              size: size,
              titleText: 'Internships',
              onSearchTap: () {},
              isSearchVisible: true,
              isBackButtonVisible: false,
              isSavedVisible: true,
              isChatVisible: true,
              isButtonsVisible: false,
              onTapClearAll: () {},
              onTapApply: () {},
            ),

            /// body
            body: state.isLoading!
                ? const Center(
                    child: CircularProgressIndicator(
                      color: CommonColors.appThemeColor,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: size.width * numD05),
                      Align(
                        alignment: Alignment.center,
                        child: filterWidget(
                          size: size,
                          onTapFilter: () {
                            Routes.push(
                              widget: FilterScreen(filterCubit: cubitData),
                              context: context,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: size.width * numD018),
                      Align(
                        alignment: Alignment.center,
                        child: CommonText(
                          title:
                              '${state.filteredInternDetailsList!.length} $totalInternshipsText',
                          fontSize: size.width * numD033,
                          color: CommonColors.greyTextColor,
                        ),
                      ),
                      SizedBox(height: size.width * numD015),
                      Container(
                        height: size.width * numD005,
                        width: double.infinity,
                        color: CommonColors.borderColor,
                      ),
                      state.filteredInternDetailsList!.isEmpty
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
                              child: ListView.separated(
                                itemCount:
                                    state.filteredInternDetailsList!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  debugPrint('index::::$index');

                                  int tmpIdx = state.idsList!.indexWhere(
                                      (element) =>
                                          element ==
                                          state
                                              .filteredInternDetailsList![index]
                                              .keys
                                              .first);

                                  return state.filteredInternDetailsList![index]
                                              [state.idsList![tmpIdx]] !=
                                          null
                                      ? internshipWidget(
                                          size: size,
                                          index: index,
                                          cubitData:
                                              context.read<SearchCubit>(),
                                          item: state
                                                  .filteredInternDetailsList![
                                              index][state.idsList![tmpIdx]],
                                        )
                                      : const SizedBox.shrink();
                                },
                                separatorBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: size.width * numD003,
                                        width: double.infinity,
                                        color: CommonColors.borderColor,
                                      ),
                                      Container(
                                        height: size.width * numD02,
                                        color: CommonColors.greyTextColor
                                            .withOpacity(0.1),
                                      ),
                                      Container(
                                        height: size.width * numD003,
                                        width: double.infinity,
                                        color: CommonColors.borderColor,
                                      ),
                                      SizedBox(height: size.width * numD025),
                                    ],
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
