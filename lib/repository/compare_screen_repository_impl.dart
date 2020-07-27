import 'package:curativecare/main.dart';
import 'package:curativecare/network/compare_hospital_api_client.dart';
import 'abstract/compare_screen_repository.dart';

class CompareScreenRepositoryImpl extends CompareScreenRepository{
  @override
  Future getListOfHospitals() async {
    String stateName=await box.get("state");
    CompareHospitalAPIClient compareHospitalAPIClient=new CompareHospitalAPIClient();
    return compareHospitalAPIClient.fetchHospitalsName(stateName);
  }

}