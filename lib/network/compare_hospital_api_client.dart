import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:dio/dio.dart';

class CompareHospitalAPIClient {
  //API
  String hospitalNameUrl =
      "https://data.medicare.gov/resource/xubh-q36u.json?\$select=hospital_name&state=";
  String generalInformationUrl =
      "https://data.medicare.gov/resource/xubh-q36u.json?\$select=hospital_name,phone_number,hospital_type,hospital_ownership,emergency_services,hospital_overall_rating&state=AK";
  String patientExperienceUrl =
      "https://data.medicare.gov/resource/avtz-f2ge.json?\$select=hospital_name,communication_with_nurses_performance_rate,communication_with_doctors_performance_rate,responsiveness_of_hospital_staff_performance_rate,care_transition_performance_rate,communication_about_medicines_performance_rate,cleanliness_and_quietness_of_hospital_environment_performance_rate,discharge_information_performance_rate&state=";

  //To Fetch Hospitals Name
  Future fetchHospitalsName(String stateName) async {
    String url = hospitalNameUrl + getAbbreviation(stateName);
    Dio dio = new Dio();

    var response;
    try {
      response = await dio.get(url);
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw Exception("Please check your internet connection and try again");
      } else if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('No Internet Connection');
        }
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
    List<dynamic> elements = response.data;
    List<CompareHospitalModel> name = new List();
    for (int i = 0; i < elements.length; i++) {
      Map<String, dynamic> current_hospital = elements[i];
      String hospitalName = current_hospital['hospital_name'];
      name.add(new CompareHospitalModel(hospitalName, false));
    }
    return name;
  }

  String getAbbreviation(String stateName) {
    final name = stateName.trim().toLowerCase();

    return states.keys.firstWhere((key) => states[key].toLowerCase() == name,
        orElse: () => "");
  }

  final states = {
    "AK": "Alaska",
    "AL": "Alabama",
    "AR": "Arkansas",
    "AS": "American Samoa",
    "AZ": "Arizona",
    "CA": "California",
    "CO": "Colorado",
    "CT": "Connecticut",
    "DC": "District of Columbia",
    "DE": "Delaware",
    "FL": "Florida",
    "GA": "Georgia",
    "GU": "Guam",
    "HI": "Hawaii",
    "IA": "Iowa",
    "ID": "Idaho",
    "IL": "Illinois",
    "IN": "Indiana",
    "KS": "Kansas",
    "KY": "Kentucky",
    "LA": "Louisiana",
    "MA": "Massachusetts",
    "MD": "Maryland",
    "ME": "Maine",
    "MI": "Michigan",
    "MN": "Minnesota",
    "MO": "Missouri",
    "MS": "Mississippi",
    "MT": "Montana",
    "NC": "North Carolina",
    "ND": "North Dakota",
    "NE": "Nebraska",
    "NH": "New Hampshire",
    "NJ": "New Jersey",
    "NM": "New Mexico",
    "NV": "Nevada",
    "NY": "New York",
    "OH": "Ohio",
    "OK": "Oklahoma",
    "OR": "Oregon",
    "PA": "Pennsylvania",
    "PR": "Puerto Rico",
    "RI": "Rhode Island",
    "SC": "South Carolina",
    "SD": "South Dakota",
    "TN": "Tennessee",
    "TX": "Texas",
    "UT": "Utah",
    "VA": "Virginia",
    "VI": "Virgin Islands",
    "VT": "Vermont",
    "WA": "Washington",
    "WI": "Wisconsin",
    "WV": "West Virginia",
    "WY": "Wyoming"
  };
}
