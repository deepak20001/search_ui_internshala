import 'package:search_ui_internshala/utils/common_models.dart';

class SearchState {
  List<Map<int, dynamic>>? internDetailsList;
  List<Map<int, dynamic>>? filteredInternDetailsList;
  bool? isLoading;
  List<int>? idsList;
  List<ProfileFilterModel>? originalProfileList;
  List<ProfileFilterModel>? filteredProfileList;
  List<String>? selectedProfileList;
  List<CityFilterModel>? originalCityList;
  List<CityFilterModel>? filteredCityList;
  List<String>? selectedCityList;
  int? selectedDuration;
  List<String>? dummyProfileSelectedList;
  List<String>? dummyCitySelectedList;

  SearchState({
    this.internDetailsList,
    this.filteredInternDetailsList,
    this.isLoading,
    this.idsList,
    this.originalProfileList,
    this.filteredProfileList,
    this.selectedProfileList,
    this.originalCityList,
    this.filteredCityList,
    this.selectedCityList,
    this.selectedDuration,
    this.dummyProfileSelectedList,
    this.dummyCitySelectedList,
  });

  SearchState copyWith({
    List<Map<int, dynamic>>? internDetailsList,
    List<Map<int, dynamic>>? filteredInternDetailsList,
    bool? isLoading,
    List<int>? idsList,
    List<ProfileFilterModel>? originalProfileList,
    List<ProfileFilterModel>? filteredProfileList,
    List<String>? selectedProfileList,
    List<CityFilterModel>? originalCityList,
    List<CityFilterModel>? filteredCityList,
    List<String>? selectedCityList,
    int? selectedDuration,
    List<String>? dummyProfileSelectedList,
    List<String>? dummyCitySelectedList,
  }) {
    return SearchState(
      internDetailsList: internDetailsList ?? this.internDetailsList,
      filteredInternDetailsList:
          filteredInternDetailsList ?? this.filteredInternDetailsList,
      isLoading: isLoading ?? this.isLoading,
      idsList: idsList ?? this.idsList,
      originalProfileList: originalProfileList ?? this.originalProfileList,
      filteredProfileList: filteredProfileList ?? this.filteredProfileList,
      selectedProfileList: selectedProfileList ?? this.selectedProfileList,
      originalCityList: originalCityList ?? this.originalCityList,
      filteredCityList: filteredCityList ?? this.filteredCityList,
      selectedCityList: selectedCityList ?? this.selectedCityList,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      dummyProfileSelectedList:
          dummyProfileSelectedList ?? this.dummyProfileSelectedList,
      dummyCitySelectedList:
          dummyCitySelectedList ?? this.dummyCitySelectedList,
    );
  }
}
