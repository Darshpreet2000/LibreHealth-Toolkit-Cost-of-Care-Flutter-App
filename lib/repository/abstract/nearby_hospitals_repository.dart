import 'package:cost_of_care/models/hospitals.dart';

// To find Nearby Hospitals using coordinates
abstract class NearbyHospitalsRepository {
  Future
      fetchHospitals(); // To get Data of Nearby Hospitals  using Overpass API
  Future<List<Hospitals>> parseJson(
      Map<String, dynamic>
          responseBody); //To Parse Json Data & convert it to List
//Future<String> fetchImages(String name);
  Future fetchImages(String name);
}
