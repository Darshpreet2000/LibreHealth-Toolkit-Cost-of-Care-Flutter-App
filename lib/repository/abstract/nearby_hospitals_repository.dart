

import 'package:curativecare/models/hospitals.dart';

// To find Nearby Hospitals using coordinates
abstract class NearbyHospitalsRepository {
  Future
      fetchHospitals(); // To get Data of Nearby Hospitals  using Overpass API
  Future<List<Hospitals>> parseJson(
      String responseBody); //To Parse Json Data & convert it to List
//Future<String> fetchImages(String name);
  Future<String> fetchImages(String name);
}
