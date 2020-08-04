import 'package:curativecare/main.dart';
import 'package:curativecare/models/compare_hospital_model.dart';
import 'package:curativecare/network/compare_hospital_api_client.dart';
import 'abstract/compare_screen_repository.dart';

class CompareScreenRepositoryImpl extends CompareScreenRepository{

  Future checkSavedList() async {
    String state=await box.get("state");
    bool condition = listbox.containsKey('compareHospitalList$state');
    return condition;
  }
  Future saveList(List<CompareHospitalModel> hospitalList) async {
    String state=await box.get("state");
    listbox.put('compareHospitalList$state',hospitalList);
  }

  Future fetchSavedList() async {
    String state=await box.get("state");
    return listbox.get('compareHospitalList$state').cast<CompareHospitalModel>();
  }

  @override
  Future getListOfHospitals() async {
    String stateName=await box.get("state");
    CompareHospitalAPIClient compareHospitalAPIClient=new CompareHospitalAPIClient();
    return compareHospitalAPIClient.fetchHospitalsName(stateName);
  }
  Future fetchImages(String name){
    CompareHospitalAPIClient compareHospitalAPIClient=new CompareHospitalAPIClient();
    return compareHospitalAPIClient.fetchImages(name);
  }
  Future fetchGeneralInformation(String hospitalName) async {
    String stateName=await box.get('state');
    CompareHospitalAPIClient compareHospitalAPIClient=new CompareHospitalAPIClient();
    return compareHospitalAPIClient.fetchGeneralInformation(hospitalName,stateName);
  }
  Future fetchPatientExperience(String hospitalName) async {
    String stateName=await box.get('state');
    CompareHospitalAPIClient compareHospitalAPIClient=new CompareHospitalAPIClient();
    return compareHospitalAPIClient.fetchPatientExperience(hospitalName,stateName);
  }
}