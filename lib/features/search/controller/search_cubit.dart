import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_ui_internshala/main.dart';
import 'package:search_ui_internshala/utils/common_const.dart';
import 'package:search_ui_internshala/utils/common_enums.dart';
import 'package:search_ui_internshala/utils/common_models.dart';
import 'package:search_ui_internshala/utils/network__class/api_url_constants.dart';
import 'package:search_ui_internshala/utils/network__class/dio_network_class.dart';
import 'package:search_ui_internshala/utils/network__class/network_response.dart';
import 'dart:developer' as devtools show log;
import 'package:search_ui_internshala/features/search/controller/search_state.dart';

class SearchCubit extends Cubit<SearchState> implements NetworkResponse {
  final TextEditingController profileController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  SearchCubit()
      : super(
          SearchState(
            isLoading: true,
            internDetailsList: [],
            filteredInternDetailsList: [],
            idsList: [],
            originalProfileList: [],
            filteredProfileList: [],
            selectedProfileList: [],
            originalCityList: [],
            filteredCityList: [],
            selectedCityList: [],
            selectedDuration: -1,
            dummyProfileSelectedList: [],
            dummyCitySelectedList: [],
          ),
        ) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callGetFlutterHiringSearchApiFunc();
    });
  }

  /// dispose controllers
  @override
  Future<void> close() {
    profileController.dispose();
    cityController.dispose();
    return super.close();
  }

  /// get integer duration func
  int getIntegerDurationFunc(String duration) {
    RegExp regExp = RegExp(r'\d+');
    Match? match = regExp.firstMatch(duration);

    if (match != null) {
      int value = int.parse(match.group(0)!);
      return value;
    } else {
      return 0;
    }
  }

  /// apply all filters func
  void applyAllFiltersFunc() {
    /// if all filters empty
    if (state.selectedProfileList!.isEmpty &&
        state.selectedCityList!.isEmpty &&
        state.selectedDuration == -1) {
      emit(state.copyWith(
          filteredInternDetailsList: List.from(state.internDetailsList!)));
    } else {
      state.filteredInternDetailsList = [];
      debugPrint('////////////////////////////////');
      for (int i = 0; i < state.internDetailsList!.length; i++) {
        // debugPrint(state.filteredInternDetailsList![i].toString());
        //         InternshipMetaModel tmpData = state.filteredInternDetailsList![i];
        debugPrint(state.internDetailsList![i].toString());

        Map<int, dynamic> mapData = state.internDetailsList![i];
        debugPrint('mapData::::${mapData.values.first}');
        InternshipMetaModel tmpData =
            mapData[state.idsList![i]] as InternshipMetaModel;

        int profileTmpIdx = state.selectedProfileList!
            .indexWhere((element) => element == tmpData.profileName);
        int cityTmpIdx = state.selectedCityList!
            .indexWhere((element) => element == tmpData.locationName);
        debugPrint('profileTmpIdx::$profileTmpIdx');
        debugPrint('cityTmpIdx::$cityTmpIdx');
        debugPrint('selected duration::::${state.selectedDuration}');
        debugPrint(
            'getIntegerDurationFunc duration::::${getIntegerDurationFunc(tmpData.duration!)}');
        if (state.selectedDuration == -1) {
          if (profileTmpIdx != -1 ||
              cityTmpIdx != -1 ||
              (state.selectedDuration != -1 &&
                  getIntegerDurationFunc(tmpData.duration!) <=
                      state.selectedDuration!)) {
            state.filteredInternDetailsList!.add(mapData);
          }
        } else if ((profileTmpIdx != -1 || cityTmpIdx != -1) &&
            (state.selectedDuration != -1 &&
                getIntegerDurationFunc(tmpData.duration!) <=
                    state.selectedDuration!)) {
          state.filteredInternDetailsList!.add(mapData);
        }
      }

      emit(state.copyWith(
          filteredInternDetailsList: state.filteredInternDetailsList));
    }
    Navigator.pop(navigatorKey.currentContext!);
  }

  /// update final selected list func
  void updateFinalSelctedListFunc(String type) {
    if (type == profileText) {
      emit(state.copyWith(selectedProfileList: state.dummyProfileSelectedList));
    } else {
      emit(state.copyWith(selectedCityList: state.dummyCitySelectedList));
    }
  }

  /// initial values for selected list func
  void initialValuesForSelectedListFunc(String type) {
    if (type == profileText) {
      for (var element in state.filteredProfileList!) {
        int tmpIdx = state.selectedProfileList!
            .indexWhere((ele) => ele == element.profileName);
        if (tmpIdx != -1) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }
      }
      emit(state.copyWith(
          dummyProfileSelectedList: List.from(state.selectedProfileList!)));
    } else {
      for (var element in state.filteredCityList!) {
        int tmpIdx = state.selectedCityList!
            .indexWhere((ele) => ele == element.cityName);
        if (tmpIdx != -1) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }
      }
      emit(state.copyWith(
          dummyCitySelectedList: List.from(state.selectedCityList!)));
    }
  }

  /// update selected duration func
  void updateSelectedDurationFunc(int val) {
    /// val == -1 (means removed)
    emit(state.copyWith(selectedDuration: val));
  }

  /// update profile filter list func
  void updateCityFilterListFunc(
      {required int index, required SelectionTypeEnum type}) {
    switch (type) {
      case SelectionTypeEnum.textFormField:

        /// 1. empty filtered city list
        /// 2. iterate on original city list & if element cityName contains controller value add it & check if element present in selected city list if present first make element value true then add it
        state.filteredCityList = [];
        for (var element in state.originalCityList!) {
          if (element.cityName
              .toLowerCase()
              .contains(cityController.text.trim().toLowerCase())) {
            int tmpIdx = state.dummyCitySelectedList!
                .indexWhere((ele) => ele == element.cityName);
            if (tmpIdx != -1) {
              element.isSelected = true;
            } else {
              element.isSelected = false;
            }
            state.filteredCityList!.add(element);
          }
        }
        emit(state.copyWith(filteredCityList: state.filteredCityList));
        break;
      case SelectionTypeEnum.closeIcon:

        /// 1. update in filtered city list as value = false
        /// 2. remove value from selected city list
        int tmpIdx = state.filteredCityList!.indexWhere((element) =>
            element.cityName == state.dummyCitySelectedList![index]);
        debugPrint('tmpIdx::::$tmpIdx');
        if (tmpIdx != -1) state.filteredCityList![tmpIdx].isSelected = false;
        state.dummyCitySelectedList!.removeAt(index);
        emit(state.copyWith(
            filteredCityList: state.filteredCityList,
            dummyCitySelectedList: state.dummyCitySelectedList));

        break;
      case SelectionTypeEnum.checkBox:
        state.filteredCityList![index].isSelected =
            !state.filteredCityList![index].isSelected;
        if (state.filteredCityList![index].isSelected) {
          state.dummyCitySelectedList!
              .insert(0, state.filteredCityList![index].cityName);
        } else {
          state.dummyCitySelectedList!.removeWhere(
              (element) => element == state.filteredCityList![index].cityName);
        }
        emit(
          state.copyWith(
            filteredCityList: state.filteredCityList,
            dummyCitySelectedList: state.dummyCitySelectedList,
          ),
        );
        break;
    }
  }

  /// update profile filter list func
  void updateProfileFilterListFunc(
      {required int index, required SelectionTypeEnum type}) {
    switch (type) {
      case SelectionTypeEnum.textFormField:

        /// 1. empty filtered profile list
        /// 2. iterate on original profile list & if element profileName contains controller value add it & check if element present in selected profile list if present first make element value true then add it
        state.filteredProfileList = [];
        for (var element in state.originalProfileList!) {
          if (element.profileName
              .toLowerCase()
              .contains(profileController.text.trim().toLowerCase())) {
            int tmpIdx = state.dummyProfileSelectedList!
                .indexWhere((ele) => ele == element.profileName);
            if (tmpIdx != -1) {
              element.isSelected = true;
            } else {
              element.isSelected = false;
            }
            state.filteredProfileList!.add(element);
          }
        }
        emit(state.copyWith(filteredProfileList: state.filteredProfileList));
        break;
      case SelectionTypeEnum.closeIcon:

        /// 1. update in filtered profile list as value = false
        /// 2. remove value from selected profile list
        int tmpIdx = state.filteredProfileList!.indexWhere((element) =>
            element.profileName == state.dummyProfileSelectedList![index]);
        debugPrint('tmpIdx::::$tmpIdx');
        if (tmpIdx != -1) state.filteredProfileList![tmpIdx].isSelected = false;
        state.dummyProfileSelectedList!.removeAt(index);
        emit(state.copyWith(
            filteredProfileList: state.filteredProfileList,
            dummyProfileSelectedList: state.dummyProfileSelectedList));

        break;
      case SelectionTypeEnum.checkBox:
        state.filteredProfileList![index].isSelected =
            !state.filteredProfileList![index].isSelected;
        if (state.filteredProfileList![index].isSelected) {
          state.dummyProfileSelectedList!
              .insert(0, state.filteredProfileList![index].profileName);
        } else {
          state.dummyProfileSelectedList!.removeWhere((element) =>
              element == state.filteredProfileList![index].profileName);
        }
        emit(
          state.copyWith(
            filteredProfileList: state.filteredProfileList,
            dummyProfileSelectedList: state.dummyProfileSelectedList,
          ),
        );
        break;
    }
  }

  /// clear all func
  void clearAllFunc(String val) {
    if (val == profileText) {
      for (var element in state.originalProfileList!) {
        element.isSelected = false;
      }
      emit(
        state.copyWith(
          originalProfileList: state.originalProfileList,
          selectedProfileList: [],
          dummyProfileSelectedList: [],
        ),
      );
    } else {
      for (var element in state.originalCityList!) {
        element.isSelected = false;
      }
      emit(
        state.copyWith(
          originalCityList: state.originalCityList,
          selectedCityList: [],
          dummyCitySelectedList: [],
        ),
      );
    }
  }

  /// call get flutter hiring search api func
  void callGetFlutterHiringSearchApiFunc() async {
    emit(state.copyWith(isLoading: true));
    Map<String, dynamic> map = {};

    debugPrint("Data::::::::::::::::::::::::::$map");
    DioNetworkClass(
      endUrl: getFlutterHiringSearchUrl,
      networkResponse: this,
      requestCode: getFlutterHiringSearchReq,
    ).callRequestService(true, 'get');
  }

  @override
  void onApiError({required int requestCode, required String response}) {
    switch (requestCode) {
      case getFlutterHiringSearchReq:
        devtools.log("getFlutterHiringSearchReq error:::::$response");
        var data = jsonDecode(response);
        emit(state.copyWith(isLoading: false));

        break;
    }
  }

  @override
  void onResponse({required int requestCode, required String response}) {
    switch (requestCode) {
      case getFlutterHiringSearchReq:
        devtools.log("getFlutterHiringSearchReq success:::::$response");
        var data = jsonDecode(jsonDecode(response));
        if (data != null) {
          List<int> tmpList = data['internship_ids'].cast<int>();

          debugPrint(data['internships_meta'].toString());
          Set<String> seenProfileNames = {};
          Set<String> seenCityNames = {};
          for (var element in tmpList) {
            debugPrint('element-->$element');
            var tmpEle = InternshipMetaModel.fromJson(
                data['internships_meta'][element.toString()]);
            state.internDetailsList!.add(
              {element: tmpEle},
            );

            /// no duplicacy in profile list
            if (!seenProfileNames.contains(tmpEle.profileName!)) {
              state.originalProfileList!.add(
                ProfileFilterModel(
                  profileName: tmpEle.profileName!,
                  isSelected: false,
                ),
              );
              seenProfileNames.add(tmpEle.profileName!);
            }

            /// no duplicacy in city list
            if (!seenCityNames.contains(tmpEle.locationName)) {
              state.originalCityList!.add(
                CityFilterModel(
                  cityName: tmpEle.locationName ?? "",
                  isSelected: false,
                ),
              );
              seenCityNames.add(tmpEle.locationName!);
            }
          }

          /// emit changes
          emit(
            state.copyWith(
              idsList: tmpList,
              internDetailsList: state.internDetailsList,
              filteredInternDetailsList: List.from(state.internDetailsList!),
              originalProfileList: state.originalProfileList,
              filteredProfileList: state.originalProfileList,
              originalCityList: state.originalCityList,
              filteredCityList: state.originalCityList,
              isLoading: false,
            ),
          );
        }
        break;
    }
  }
}
