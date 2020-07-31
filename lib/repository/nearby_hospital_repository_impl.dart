import 'dart:async';

import 'package:curativecare/models/hospitals.dart';
import 'package:curativecare/network/hospital_image_client.dart';
import 'package:curativecare/network/overpass_api_client.dart';
import 'package:curativecare/repository/abstract/nearby_hospitals_repository.dart';

import '../main.dart';

class NearbyHospitalsRepoImpl implements NearbyHospitalsRepository {
  List<Hospitals> getSavedList() {
    List<Hospitals> hospitals =
        listbox.get('nearbyHospitalList').cast<Hospitals>();
    return hospitals;
  }

  List<Hospitals> sortList(List<Hospitals> hospitals) {
    if (box.containsKey('order')) {
      String order = box.get('order');
      if (order == 'Ascending')
        hospitals.sort((a, b) =>
            double.parse(a.distance).compareTo(double.parse(b.distance)));
      else if (order == 'Descending')
        hospitals.sort((a, b) =>
            double.parse(b.distance).compareTo(double.parse(a.distance)));
    } else
      hospitals.sort((a, b) =>
          double.parse(a.distance).compareTo(double.parse(b.distance)));
    return hospitals;
  }

  void saveList(List<Hospitals> nearbyHospitals) {
    listbox.put('nearbyHospitalList', nearbyHospitals);
    String address = box.get('address');
    String radius = box.get('radius');
    box.put('settings', "$address" + "$radius");
  }

  bool checkSaved() {
    String address = box.get('address');
    String radius = box.get('radius');
    String currentSettings = "$address" + "$radius";
    //Check if list already exists in Hive with same settings as earlier2
    if (listbox.containsKey('nearbyHospitalList') &&
        box.get('settings') == currentSettings) {
      return true;
    }
    return false;
  }

  Future fetchHospitals() async {
    OverpassAPIClient overpassAPIClient = new OverpassAPIClient();
    var response = await overpassAPIClient.fetch_nearby_hospitals();
    return response;
  }

  @override
  Future<List<Hospitals>> parseJson(Map<String, dynamic> responseBody) async {
    OverpassAPIClient overpassAPIClient = new OverpassAPIClient();
    //Store List in Hive
    return overpassAPIClient.parse_hospital_json_data(responseBody);
  }

  @override
  Future<String> fetchImages(String name) async {
    FetchHospitalImages fetchHospitalImages = new FetchHospitalImages();
    try {
      Future<String> response = fetchHospitalImages.fetchImagesFromGoogle(name);
      return response;
    } catch (e) {}
  }
}
