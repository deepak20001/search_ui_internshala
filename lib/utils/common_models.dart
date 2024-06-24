class InternshipMetaModel {
  int? id;
  String? title;
  String? employmentType;
  String? companyName;
  String? profileName;
  String? duration;
  String? stipend;
  String? postedOn;
  int? postedOnDateTime;
  String? locationName;
  String? ppoLabelValue;
  String? postedByLabel;

  InternshipMetaModel({
    this.id,
    this.title,
    this.employmentType,
    this.companyName,
    this.profileName,
    this.duration,
    this.stipend,
    this.postedOn,
    this.postedOnDateTime,
    this.locationName,
    this.ppoLabelValue,
    this.postedByLabel,
  });

  factory InternshipMetaModel.fromJson(Map<String, dynamic> json) {
    String tmpLocationName = 'Delhi';
    if (json['locations'] != null && json['locations'].isNotEmpty) {
      var firstLocation = json['locations'].first;
      if (firstLocation != null && firstLocation['locationName'] != null) {
        tmpLocationName = firstLocation['locationName'];
      }
    }
    return InternshipMetaModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      employmentType: json['employment_type'] ?? '',
      companyName: json['company_name'] ?? '',
      profileName: json['profile_name'] ?? '',
      duration: json['duration'] ?? '',
      stipend: (json['stipend'] != null && json['stipend']['salary'] != null)
          ? json['stipend']['salary']
          : '',
      postedOn: json['posted_on'] ?? '',
      postedOnDateTime: json['postedOnDateTime'] ?? '',
      locationName: tmpLocationName,
      ppoLabelValue: json['ppo_label_value'] ?? '',
      postedByLabel: json['posted_by_label'] ?? '',
    );
  }
}

class ProfileFilterModel {
  String profileName;
  bool isSelected;

  ProfileFilterModel({
    required this.profileName,
    required this.isSelected,
  });
}

class CityFilterModel {
  String cityName;
  bool isSelected;

  CityFilterModel({
    required this.cityName,
    required this.isSelected,
  });
}