import 'dart:async';

import 'package:curativecare/models/nearby_hospital.dart';

// To find Nearby Hospitals using coordinates
abstract class NearbyHospitalsRepository {
  Future
      fetch_hospitals(); // To get Data of Nearby Hospitals  using Overpass API
  Future<List<NearbyHospital>> parse_json(
      String responseBody); //To Parse Json Data & convert it to List
//Future<String> fetchImages(String name);
  Future<String> fetchImages(String name);
}
