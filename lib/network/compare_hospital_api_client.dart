import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/models/general_information.dart';
import 'package:curativecare/models/patient_experience.dart';
import 'package:curativecare/util/api_config.dart';
import 'package:curativecare/util/states_abbreviation.dart';
import 'package:dio/dio.dart';

import 'hospital_image_client.dart';

class CompareHospitalAPIClient {
  //To Fetch Hospitals Name
  Future fetchGeneralInformation(String hospitalsName, String stateName) async {
    ApiConfig apiConfig = new ApiConfig();
    StatesAbbreviation statesAbbreviation = new StatesAbbreviation();
    String url = apiConfig.generalInformationUrl +
        statesAbbreviation.getAbbreviation(stateName) +
        "&hospital_name=$hospitalsName";
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
    String hospitalName,
        phoneNumber,
        hospitalType,
        hospitalOwnership,
        emergencyServices,
        hospitalOverallRating;
    if (elements.length > 0) {
      hospitalName = elements[0]['hospital_name'] != null
          ? elements[0]['hospital_name']
          : "N/A";
      phoneNumber = elements[0]['phone_number'] != null
          ? elements[0]['phone_number']
          : "N/A";
      hospitalType = elements[0]['hospital_type'] != null
          ? elements[0]['hospital_type']
          : "N/A";
      hospitalOwnership = elements[0]['hospital_ownership'] != null
          ? elements[0]['hospital_ownership']
          : "N/A";
      emergencyServices = elements[0]['emergency_services'] != null
          ? elements[0]['emergency_services']
          : "N/A";
      hospitalOverallRating = elements[0]['hospital_overall_rating'] != null
          ? elements[0]['hospital_overall_rating']
          : "N/A";
    } else {
      hospitalName = phoneNumber = hospitalType =
          hospitalOwnership = emergencyServices = hospitalOverallRating = "N/A";
    }
    GeneralInformation generalInformation = new GeneralInformation(
        hospitalName,
        phoneNumber,
        hospitalType,
        hospitalOwnership,
        emergencyServices,
        hospitalOverallRating);
    return generalInformation;
  }

  Future fetchHospitalsName(String stateName) async {
    ApiConfig apiConfig = new ApiConfig();
    StatesAbbreviation statesAbbreviation = new StatesAbbreviation();
    String url = apiConfig.hospitalNameUrl +
        statesAbbreviation.getAbbreviation(stateName);
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

  Future fetchImages(String name) {
    FetchHospitalImages fetchHospitalImages = new FetchHospitalImages();
    try {
      Future<String> response = fetchHospitalImages.fetchImagesFromGoogle(name);
      return response;
    } catch (e) {}
  }

  Future fetchPatientExperience(String hospitalsName, String stateName) async {
    ApiConfig apiConfig = new ApiConfig();
    StatesAbbreviation statesAbbreviation = new StatesAbbreviation();
    String url = apiConfig.patientExperienceUrl +
        statesAbbreviation.getAbbreviation(stateName) +
        "&hospital_name=$hospitalsName";
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
    String hospitalName,
        communicationWithNursesPerformanceRate,
        communicationWithDoctorsPerformanceRate,
        responsivenessOfHospitalStaffPerformanceRate,
        careTransitionPerformanceRate,
        communicationAboutMedicinesPerformanceRate,
        cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate;
    if (elements.length > 0) {
      hospitalName = elements[0]['hospital_name'] != null
          ? elements[0]['hospital_name']
          : "N/A";
      communicationWithNursesPerformanceRate =
          elements[0]['communication_with_nurses_performance_rate'] != null
              ? elements[0]['communication_with_nurses_performance_rate']
              : "N/A";
      communicationWithDoctorsPerformanceRate =
          elements[0]['communication_with_doctors_performance_rate'] != null
              ? elements[0]['communication_with_doctors_performance_rate']
              : "N/A";
      responsivenessOfHospitalStaffPerformanceRate = elements[0]
                  ['responsiveness_of_hospital_staff_performance_rate'] !=
              null
          ? elements[0]['responsiveness_of_hospital_staff_performance_rate']
          : "N/A";
      careTransitionPerformanceRate =
          elements[0]['care_transition_performance_rate'] != null
              ? elements[0]['care_transition_performance_rate']
              : "N/A";
      communicationAboutMedicinesPerformanceRate =
          elements[0]['communication_about_medicines_performance_rate'] != null
              ? elements[0]['communication_about_medicines_performance_rate']
              : "N/A";
      cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate = elements[0][
                  'cleanliness_and_quietness_of_hospital_environment_performance_rate'] !=
              null
          ? elements[0][
              'cleanliness_and_quietness_of_hospital_environment_performance_rate']
          : "N/A";
    } else {
      hospitalName = communicationWithNursesPerformanceRate =
          communicationWithDoctorsPerformanceRate =
              responsivenessOfHospitalStaffPerformanceRate =
                  careTransitionPerformanceRate =
                      communicationAboutMedicinesPerformanceRate =
                          cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate =
                              "N/A";
    }
    PatientExperience patientExperience = new PatientExperience(
        hospitalName,
        communicationWithNursesPerformanceRate,
        communicationWithDoctorsPerformanceRate,
        responsivenessOfHospitalStaffPerformanceRate,
        careTransitionPerformanceRate,
        communicationAboutMedicinesPerformanceRate,
        cleanlinessAndQuietnessOfHospitalEnvironmentPerformanceRate);
    return patientExperience;
  }
}
