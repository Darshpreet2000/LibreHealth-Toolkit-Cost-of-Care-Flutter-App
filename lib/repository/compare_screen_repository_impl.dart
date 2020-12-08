import 'package:cost_of_care/main.dart';
import 'package:cost_of_care/network/compare_hospital_api_client.dart';
import 'package:cost_of_care/util/states_abbreviation.dart';
import 'package:dio/dio.dart';
import 'abstract/compare_screen_repository.dart';

class CompareScreenRepositoryImpl extends CompareScreenRepository {
  @override
  Future getListOfHospitals() async {
    String stateName;
    //Check if location is saved in App
    if (box.containsKey("state"))
      stateName = await box.get("state");
    else
      throw Exception("Location Not Found");
    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
        );
    StatesAbbreviation statesAbbreviation = new StatesAbbreviation();
    stateName = statesAbbreviation.getAbbreviation(stateName);
    if (stateName == "")
      throw Exception("No hospitals available to compare for your location");
    Dio dio = new Dio(options);
    CompareHospitalAPIClient compareHospitalAPIClient =
        new CompareHospitalAPIClient(dio);
    return compareHospitalAPIClient.fetchDataFromAssets(stateName);
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
}
