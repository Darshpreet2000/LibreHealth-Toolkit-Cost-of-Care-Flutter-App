import 'package:cost_of_care/main.dart';
import 'package:cost_of_care/models/compare_hospital_model.dart';
import 'package:cost_of_care/network/compare_hospital_api_client.dart';
import 'package:dio/dio.dart';

import 'abstract/compare_screen_repository.dart';

class CompareScreenRepositoryImpl extends CompareScreenRepository {
  Future checkSavedList() async {
    String state = await box.get("state");
    bool condition = listbox.containsKey('compareHospitalList$state');
    return condition;
  }

  Future saveList(List<CompareHospitalModel> hospitalList) async {
    String state = await box.get("state");
    listbox.put('compareHospitalList$state', hospitalList);
  }

  Future fetchSavedList() async {
    String state = await box.get("state");
    return listbox
        .get('compareHospitalList$state')
        .cast<CompareHospitalModel>();
  }

  @override
  Future getListOfHospitals() async {
    String stateName = await box.get("state");
    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
        );
    Dio dio = new Dio(options);

    CompareHospitalAPIClient compareHospitalAPIClient =
        new CompareHospitalAPIClient(dio);
    return compareHospitalAPIClient.fetchHospitalsName(stateName);
  }

  Future fetchImages(String name) {
    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
        );
    Dio dio = new Dio(options);
    CompareHospitalAPIClient compareHospitalAPIClient =
        new CompareHospitalAPIClient(dio);
    return compareHospitalAPIClient.fetchImages(name);
  }

  Future fetchGeneralInformation(String hospitalName) async {
    String stateName = await box.get('state');
    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
        );
    Dio dio = new Dio(options);
    CompareHospitalAPIClient compareHospitalAPIClient =
        new CompareHospitalAPIClient(dio);
    return compareHospitalAPIClient.fetchGeneralInformation(
        hospitalName, stateName);
  }

  Future fetchPatientExperience(String hospitalName) async {
    String stateName = await box.get('state');
    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
        );
    Dio dio = new Dio(options);
    CompareHospitalAPIClient compareHospitalAPIClient =
        new CompareHospitalAPIClient(dio);
    return compareHospitalAPIClient.fetchPatientExperience(
        hospitalName, stateName);
  }
}
